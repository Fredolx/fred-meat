use crate::{sql, types::Settings};
use anyhow::Result;
use std::collections::HashMap;

pub const TEST_KEY: &str = "test";

pub fn get_settings() -> Result<Settings> {
    let map = sql::get_settings()?;
    let settings = Settings {
        test: map.get(TEST_KEY).and_then(|s| s.parse().ok()),
    };
    Ok(settings)
}

pub fn update_settings(settings: Settings) -> Result<()> {
    let mut map: HashMap<String, Option<String>> = HashMap::with_capacity(5);

    if let Some(test) = settings.test {
        map.insert(TEST_KEY.to_string(), Some(test.to_string()));
    }

    sql::update_settings(map)?;
    Ok(())
}
