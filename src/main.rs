use crate::DLCMessage::{DLC, DLCBuilder, DLCBuilderError, Oracle, OracleBuilder};


impl Oracle {
    pub fn new() -> OracleBuilder {
        OracleBuilder::new()
    }
}

impl DLC {
    pub fn new() -> DLCBuilder {
        DLCBuilder::new()
    }
}

impl DLCBuilderError {
    pub fn new() -> DLCBuilderError {
        DLCBuilderError::new()
    }
}

fn main() {
    println!("Hello, world!");
}

fn test_oracle() {
    let oracle = Oracle::new();
    let oracle_builder = oracle.build();
    let oracle = oracle_builder.unwrap();
    let oracle_id = oracle.get_id();
    println!("Oracle ID: {}", oracle_id);
}
fn test_dlc() {
    let dlc = DLC::new();
    let dlc_builder = dlc.build();
    let dlc = dlc_builder.unwrap();
    let dlc_id = dlc.get_id();
    println!("DLC ID: {}", dlc_id);
}

fn test_dlc_builder() {
    let dlc = DLC::new();
    let dlc_builder = dlc.build();
    let dlc = dlc_builder.unwrap();
    let dlc_id = dlc.get_id();
    println!("DLC ID: {}", dlc_id);
}

fn test_oracle_builder() {
    let oracle = Oracle::new();
    let oracle_builder = oracle.build();
    let oracle = oracle_builder.unwrap();
    let oracle_id = oracle.get_id();
    println!("Oracle ID: {}", oracle_id);
}
