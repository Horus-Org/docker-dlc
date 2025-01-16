use dlc_messages::Message;

// Define DLCBuilder struct
pub struct DLCBuilder {
    // DLC messages (field in use)
    ddk_messages: Vec<Message>,
}

// Define Oracle struct and OracleBuilder struct
pub struct Oracle;
pub struct OracleBuilder;

impl Oracle {
    pub fn new() -> OracleBuilder {
        OracleBuilder::new()
    }
}

impl OracleBuilder {
    pub fn new() -> Self {
        OracleBuilder
    }

    pub fn build(self) -> Result<Oracle, String> {
        Ok(Oracle)
    }
}

// Define DLC struct and DLCBuilderError struct
pub struct DLC;
pub enum DLCBuilderError {
    EmptyMessages,
}

impl DLC {
    pub fn new() -> DLCBuilder {
        DLCBuilder::new()
    }
}

impl DLCBuilder {
    pub fn new() -> Self {
        DLCBuilder {
            ddk_messages: Vec::new(), // Initialized to an empty vector
        }
    }

    pub fn add_message(mut self, message: Message) -> Self {
        self.ddk_messages.push(message);
        self
    }

    pub fn build(self) -> Result<DLC, DLCBuilderError> {
        if self.ddk_messages.is_empty() {
            Err(DLCBuilderError::EmptyMessages)
        } else {
            Ok(DLC)
        }
    }
}

impl DLCBuilderError {
    pub fn to_string(&self) -> &'static str {
        match self {
            DLCBuilderError::EmptyMessages => "No messages provided to DLCBuilder.",
        }
    }
}

// Main function
fn main() {
    let dlc_builder = DLC::new();
    let oracle_builder = Oracle::new();

    // Add messages to DLCBuilder
    let dlc_result = dlc_builder
        .add_message(Message::default()) // Assuming Message has a `default` constructor
        .build();

    // Handle the result
    match dlc_result {
        Ok(_) => println!("DLC successfully built."),
        Err(err) => println!("Error building DLC: {}", err.to_string()),
    }

    let oracle_result = oracle_builder.build();
    match oracle_result {
        Ok(_) => println!("Oracle successfully built."),
        Err(err) => println!("Error building Oracle: {}", err),
    }
}
