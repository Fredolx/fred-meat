use crate::sql;
use anyhow::Result;
use std::sync::OnceLock;

pub static TEMP_PATH: OnceLock<String> = OnceLock::new();

pub fn should_show_whats_new(version: Option<String>) -> Result<bool> {
    Ok(sql::get_whats_new()? != version)
}
