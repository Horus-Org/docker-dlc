use clap::Parser;
use std::path::PathBuf;

#[derive(Parser)]
#[clap(author, version, about, long_about = None)]
pub struct Cli {
    /// Path to the file to read
    #[clap(parse(from_os_str))]
    pub
    path: PathBuf,
}

pub struct command {
    
}