use std::{
    collections::HashMap,
    path::PathBuf,
    str::FromStr,
    sync::{LazyLock, OnceLock},
};

use anyhow::{Context, Result};
use r2d2::{Pool, PooledConnection};
use r2d2_sqlite::SqliteConnectionManager;
use rusqlite::{OptionalExtension, params};
use rusqlite_migration::{M, Migrations};

pub const DB_NAME: &str = "db_rust.sqlite";
pub const LAST_SEEN_VERSION_KEY: &str = "last_seen_version";
pub static DB_PATH_OVERRIDE: OnceLock<String> = OnceLock::new();
static CONN: LazyLock<Pool<SqliteConnectionManager>> = LazyLock::new(|| create_connection_pool());

pub fn get_conn() -> Result<PooledConnection<SqliteConnectionManager>> {
    CONN.try_get().context("No sqlite conns available")
}

fn create_connection_pool() -> Pool<SqliteConnectionManager> {
    let manager = SqliteConnectionManager::file(get_and_create_sqlite_db_path());
    r2d2::Pool::builder().max_size(20).build(manager).unwrap()
}

fn get_and_create_sqlite_db_path() -> String {
    let mut path = PathBuf::from_str(DB_PATH_OVERRIDE.get().unwrap()).unwrap();
    if !path.exists() {
        std::fs::create_dir_all(&path).unwrap();
    }
    path.push(DB_NAME);
    return path.to_string_lossy().to_string();
}

pub fn apply_migrations() -> Result<()> {
    let mut sql = get_conn()?;
    let migrations = Migrations::new(vec![M::up(
        r#"
CREATE TABLE "settings" (
  "key"   VARCHAR(50) PRIMARY KEY,
  "value" VARCHAR(100)
);

CREATE UNIQUE INDEX settings_unique ON settings(key);
ANALYZE;
"#,
    )]);
    migrations.to_latest(&mut sql)?;
    Ok(())
}

pub fn get_whats_new() -> Result<Option<String>> {
    let sql = get_conn()?;
    let version: Option<String> = sql
        .query_row(
            r#"
        SELECT value 
        FROM settings
        WHERE key = ?
        LIMIT 1
    "#,
            params![LAST_SEEN_VERSION_KEY],
            |row| row.get(0),
        )
        .optional()?;
    Ok(version)
}

pub fn get_settings() -> Result<HashMap<String, String>> {
    let sql = get_conn()?;
    let map = sql
        .prepare("SELECT key, value FROM Settings")?
        .query_map([], |row| {
            let key: String = row.get(0)?;
            let value: String = row.get(1)?;
            Ok((key, value))
        })?
        .filter_map(Result::ok)
        .collect();
    Ok(map)
}

pub fn update_settings(map: HashMap<String, Option<String>>) -> Result<()> {
    let mut sql: PooledConnection<SqliteConnectionManager> = get_conn()?;
    let tx = sql.transaction()?;
    for (key, value) in map {
        tx.execute(
            r#"
            INSERT INTO Settings (key, value)
            VALUES (?1, ?2)
            ON CONFLICT(key) DO UPDATE SET value = ?2
            "#,
            params![key, value],
        )?;
    }
    tx.commit()?;
    Ok(())
}
