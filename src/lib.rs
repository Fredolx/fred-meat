use std::collections::HashMap;

use crate::c::FfiCallback;
use crate::generated_proto::ToggleFavorite;
use anyhow::Ok;

mod c;
mod log;

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
pub extern "C" fn free_message(ptr: *mut u8, len: usize) {
    unsafe {
        if !ptr.is_null() && len > 0 {
            let fat_ptr = std::ptr::slice_from_raw_parts_mut(ptr, len);
            let _ = Box::from_raw(fat_ptr);
        }
    }
}
