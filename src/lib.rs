use std::collections::HashMap;

use crate::c::FfiCallback;
use anyhow::Ok;

mod c;
mod generated_proto;
mod log;
mod settings;
mod sql;
mod types;
mod utils;

#[unsafe(no_mangle)]
pub extern "C" fn initialize(task_id: u64, callback: FfiCallback, ptr: *const u8, len: usize) {
    c::queue_blocking_with_message(
        task_id,
        callback,
        ptr,
        len,
        |init_msg: generated_proto::InitMessage| {
            sql::DB_PATH_OVERRIDE
                .set(init_msg.db_path)
                .map_err(|e| anyhow::anyhow!(e))?;
            utils::TEMP_PATH
                .set(init_msg.temp_path)
                .map_err(|e| anyhow::anyhow!(e))?;
            log::init_logger();
            sql::apply_migrations()
        },
    )
}

#[unsafe(no_mangle)]
pub extern "C" fn should_show_whats_new(
    task_id: u64,
    callback: FfiCallback,
    ptr: *const u8,
    len: usize,
) {
    c::queue_blocking_with_message(
        task_id,
        callback,
        ptr,
        len,
        |opt_str_message: generated_proto::OptStrMessage| {
            Ok(generated_proto::ffi_result::Data::BoolMessage(
                crate::generated_proto::BoolMessage {
                    value: utils::should_show_whats_new(opt_str_message.value)?,
                },
            ))
        },
    )
}

#[unsafe(no_mangle)]
pub extern "C" fn update_last_seen_version(
    task_id: u64,
    callback: FfiCallback,
    ptr: *const u8,
    len: usize,
) {
    c::queue_blocking_with_message(
        task_id,
        callback,
        ptr,
        len,
        |str_msg: crate::generated_proto::StrMessage| {
            let mut map: HashMap<String, Option<String>> = HashMap::new();
            map.insert(sql::LAST_SEEN_VERSION_KEY.to_string(), Some(str_msg.value));
            sql::update_settings(map)
        },
    )
}

#[unsafe(no_mangle)]
pub extern "C" fn get_settings(task_id: u64, callback: FfiCallback) {
    c::queue_blocking(task_id, callback, || {
        settings::get_settings().map(|settings| generated_proto::ffi_result::Data::Settings {
            0: generated_proto::Settings {
                test: settings.test,
            },
        })
    })
}

#[unsafe(no_mangle)]
pub extern "C" fn update_settings(task_id: u64, callback: FfiCallback, ptr: *const u8, len: usize) {
    c::queue_blocking_with_message(
        task_id,
        callback,
        ptr,
        len,
        |settings: generated_proto::Settings| {
            settings::update_settings(crate::types::Settings {
                test: settings.test,
            })
        },
    );
}

#[unsafe(no_mangle)]
pub extern "C" fn free_message(ptr: *mut u8, len: usize) {
    unsafe {
        if !ptr.is_null() && len > 0 {
            let fat_ptr = std::ptr::slice_from_raw_parts_mut(ptr, len);
            let _ = Box::from_raw(fat_ptr);
        }
    }
}
