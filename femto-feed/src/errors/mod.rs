use reqwest::Error as ReqError;

#[derive(Debug)]
pub enum Error {
    Fetch(String),
    Parse(String),
    Write(String),
    Worker(String),
}

impl From<ReqError> for Error {
    fn from(error: ReqError) -> Error {
        Error::Fetch(error.to_string())
    }
}

impl From<std::io::Error> for Error {
    fn from(error: std::io::Error) -> Error {
        Error::Write(error.to_string())
    }
}

impl From<std::num::ParseIntError> for Error {
    fn from(error: std::num::ParseIntError) -> Error {
        Error::Parse(error.to_string())
    }
}

impl From<std::sync::mpsc::RecvError> for Error {
    fn from(error: std::sync::mpsc::RecvError) -> Error {
        Error::Worker(error.to_string())
    }
}

impl<T> From<std::sync::mpsc::SendError<T>> for Error {
    fn from(error: std::sync::mpsc::SendError<T>) -> Error {
        Error::Worker(error.to_string())
    }
}
