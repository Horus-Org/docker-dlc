use async_trait::async_trait;
use dlc_messages::{Message as DlcMessage, OfferDlc as DlcOfferDlc};
use ddk_messages::{Message as DdkMessage, OfferDlc as DdkOfferDlc};
use std::convert::TryFrom;

// Conversion between OfferDlc types with error handling
#[derive(Debug, thiserror::Error)]
pub enum ConversionError {
    #[error("Invalid field mapping: {0}")]
    InvalidField(String),
}

impl TryFrom<DdkOfferDlc> for DlcOfferDlc {
    type Error = ConversionError;

    fn try_from(ddk_offer: DdkOfferDlc) -> Result<Self, Self::Error> {
        Ok(DlcOfferDlc {
            field1: ddk_offer.field1,
            field2: ddk_offer.field2,
        })
    }
}

impl TryFrom<DlcOfferDlc> for DdkOfferDlc {
    type Error = ConversionError;

    fn try_from(dlc_offer: DlcOfferDlc) -> Result<Self, Self::Error> {
        Ok(DdkOfferDlc {
            field1: dlc_offer.field1,
            field2: dlc_offer.field2,
        })
    }
}

// Conversion for Oracle messages
impl TryFrom<dlc_messages::oracle_msgs::OracleAnnouncement> for ddk_messages::oracle_msgs::OracleAnnouncement {
    type Error = ConversionError;

    fn try_from(dlc_ann: dlc_messages::oracle_msgs::OracleAnnouncement) -> Result<Self, Self::Error> {
        Ok(ddk_messages::oracle_msgs::OracleAnnouncement {
            field: dlc_ann.field,
        })
    }
}

impl TryFrom<dlc_messages::oracle_msgs::OracleAttestation> for ddk_messages::oracle_msgs::OracleAttestation {
    type Error = ConversionError;

    fn try_from(dlc_att: dlc_messages::oracle_msgs::OracleAttestation) -> Result<Self, Self::Error> {
        Ok(ddk_messages::oracle_msgs::OracleAttestation {
            field: dlc_att.field,
        })
    }
}

// Conversion for Messages with full variant mapping
impl TryFrom<DdkMessage> for DlcMessage {
    type Error = ConversionError;

    fn try_from(ddk_msg: DdkMessage) -> Result<Self, Self::Error> {
        match ddk_msg {
            DdkMessage::OfferDlc(offer) => Ok(DlcMessage::OfferDlc(
                DlcOfferDlc::try_from(offer)?,
            )),
            DdkMessage::AcceptDlc(accept) => Ok(DlcMessage::AcceptDlc(accept)),
            DdkMessage::SignDlc(sign) => Ok(DlcMessage::SignDlc(sign)),
            // Add other variants as needed
            _ => Err(ConversionError::InvalidField(
                "Unsupported message variant".to_string(),
            )),
        }
    }
}

impl TryFrom<DlcMessage> for DdkMessage {
    type Error = ConversionError;

    fn try_from(dlc_msg: DlcMessage) -> Result<Self, Self::Error> {
        match dlc_msg {
            DlcMessage::OfferDlc(offer) => Ok(DdkMessage::OfferDlc(
                DdkOfferDlc::try_from(offer)?,
            )),
            DlcMessage::AcceptDlc(accept) => Ok(DdkMessage::AcceptDlc(accept)),
            DlcMessage::SignDlc(sign) => Ok(DdkMessage::SignDlc(sign)),
            // Add other variants as needed
            _ => Err(ConversionError::InvalidField(
                "Unsupported message variant".to_string(),
            )),
        }
    }
}

/// Trait for Oracle operations
#[async_trait]
pub trait OracleTrait: Send + Sync {
    async fn get_announcement(&self) -> Result<ddk_messages::oracle_msgs::OracleAnnouncement, ConversionError>;
    async fn get_attestation(&self) -> Result<ddk_messages::oracle_msgs::OracleAttestation, ConversionError>;
}

/// In-memory Oracle implementation
pub struct MemoryOracle;

#[async_trait]
impl OracleTrait for MemoryOracle {
    async fn get_announcement(&self) -> Result<ddk_messages::oracle_msgs::OracleAnnouncement, ConversionError> {
        let dlc_announcement = dlc_messages::oracle_msgs::OracleAnnouncement {
            field: String::from("example"),
        };

        ddk_messages::oracle_msgs::OracleAnnouncement::try_from(dlc_announcement)
    }

    async fn get_attestation(&self) -> Result<ddk_messages::oracle_msgs::OracleAttestation, ConversionError> {
        let dlc_attestation = dlc_messages::oracle_msgs::OracleAttestation {
            field: vec![1, 2, 3],
        };

        ddk_messages::oracle_msgs::OracleAttestation::try_from(dlc_attestation)
    }
}

/// Message transport layer
pub struct Transport;

impl Transport {
    /// Processes incoming DLC messages
    pub async fn on_dlc_message(&self, msg: dlc_messages::Message) -> Result<(), ConversionError> {
        let ddk_message = DdkMessage::try_from(msg)?;
        self.handle_message(ddk_message).await
    }

    /// Internal message handler
    async fn handle_message(&self, message: ddk_messages::Message) -> Result<(), ConversionError> {
        log::debug!("Handling message: {:?}", message);
        Ok(())
    }
}