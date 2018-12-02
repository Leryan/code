#[macro_use]
extern crate serde_derive;

pub mod chat;
pub mod models;

#[derive(Debug)]
pub enum Error {
    Data(String),
    Remote(String),
    Client(String),
    Unexpected(String),
    Login(String),
}

impl From<reqwest::Error> for Error {
    fn from(error: reqwest::Error) -> Self {
        let es = error.to_string();
        if error.is_serialization() {
            Error::Data(es)
        } else if error.is_server_error() {
            Error::Remote(es)
        } else if error.is_http() {
            Error::Client(es)
        } else if error.is_redirect() {
            Error::Client(es)
        } else if error.is_client_error() {
            Error::Client(es)
        } else {
            Error::Unexpected(es)
        }
    }
}

