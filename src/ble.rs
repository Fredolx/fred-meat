use anyhow::{Context, Result};
use btleplug::{
    api::{Central, CentralEvent, Peripheral, ScanFilter, bleuuid::BleUuid},
    platform::{Adapter, Manager},
};
use futures::{Stream, StreamExt};
use log::{error, info};
use std::sync::Mutex;
use tokio::task::JoinHandle;
use tokio_util::sync::CancellationToken;

struct ScanHandle {
    token: CancellationToken,
    task: JoinHandle<()>,
}

static SCAN: Mutex<Option<ScanHandle>> = Mutex::new(None);

pub async fn start_scan() -> Result<()> {
    stop_scan().await;

    let manager = Manager::new().await?;
    let adapters = btleplug::api::Manager::adapters(&manager).await?;
    let central = adapters.into_iter().nth(0).context("no adapters found")?;
    let events = central.events().await?;
    central.start_scan(ScanFilter::default()).await?;

    let token = CancellationToken::new();
    let task = crate::c::spawn(run_scan_loop(central, events, token.clone()));
    *SCAN.lock().unwrap() = Some(ScanHandle { token, task });
    Ok(())
}

pub async fn stop_scan() {
    let handle = SCAN.lock().unwrap().take();
    if let Some(ScanHandle { token, task }) = handle {
        token.cancel();
        let _ = task.await;
    }
}

async fn run_scan_loop(
    central: Adapter,
    mut events: impl Stream<Item = CentralEvent> + Unpin + Send,
    token: CancellationToken,
) {
    loop {
        tokio::select! {
            _ = token.cancelled() => break,
            maybe_event = events.next() => {
                let Some(event) = maybe_event else { break };
                if let Err(e) = handle_event(&central, event).await {
                    error!("scan event handling failed: {e:?}");
                }
            }
        }
    }

    if let Err(e) = central.stop_scan().await {
        error!("failed to stop scan: {e:?}");
    }
}

async fn handle_event(central: &Adapter, event: CentralEvent) -> Result<()> {
    match event {
        CentralEvent::DeviceDiscovered(id) => {
            let peripheral = central.peripheral(&id).await?;
            let properties = peripheral.properties().await?;
            let name = properties
                .and_then(|p| p.local_name)
                .map(|local_name| format!("Name: {local_name}"))
                .unwrap_or_default();
            info!("DeviceDiscovered: {:?} {}", id, name);
        }
        CentralEvent::StateUpdate(state) => {
            info!("AdapterStatusUpdate {:?}", state);
        }
        CentralEvent::DeviceConnected(id) => {
            info!("DeviceConnected: {:?}", id);
        }
        CentralEvent::DeviceDisconnected(id) => {
            info!("DeviceDisconnected: {:?}", id);
        }
        CentralEvent::ManufacturerDataAdvertisement {
            id,
            manufacturer_data,
        } => {
            info!(
                "ManufacturerDataAdvertisement: {:?}, {:?}",
                id, manufacturer_data
            );
        }
        CentralEvent::ServiceDataAdvertisement { id, service_data } => {
            info!("ServiceDataAdvertisement: {:?}, {:?}", id, service_data);
        }
        CentralEvent::ServicesAdvertisement { id, services } => {
            let services: Vec<String> = services.into_iter().map(|s| s.to_short_string()).collect();
            info!("ServicesAdvertisement: {:?}, {:?}", id, services);
        }
        _ => {}
    }
    Ok(())
}
