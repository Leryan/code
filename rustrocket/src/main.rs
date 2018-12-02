extern crate clap;
extern crate reqwest;
extern crate serde;
#[macro_use]
extern crate serde_derive;
extern crate serde_json;

use std::collections::HashMap;

use clap::{App, Arg};
use reqwest::StatusCode;
use serde_json::Value;

#[derive(Debug)]
enum Error {
    Data(String),
    Remote(String),
    Client(String),
    Unexpected(String),
    Login(String),
}

impl From<reqwest::Error> for Error {
    fn from(error: reqwest::Error) -> Self {
        if error.is_serialization() {
            Error::Data(error.to_string())
        } else if error.is_server_error() {
            Error::Remote(error.to_string())
        } else if error.is_http() {
            Error::Client(error.to_string())
        } else if error.is_redirect() {
            Error::Client(error.to_string())
        } else if error.is_client_error() {
            Error::Client(error.to_string())
        } else {
            Error::Unexpected(error.to_string())
        }
    }
}

#[derive(Deserialize)]
struct RocketLogin {
    data: HashMap<String, Value>,
}

impl RocketLogin {
    fn from_str(data: &str) -> Result<RocketLogin, Error> {
        match serde_json::from_str(data) {
            Ok(v) => return Ok(v),
            Err(e) => return Err(Error::Data(e.to_string())),
        };
    }

    fn auth_token(&self) -> Option<String> {
        if !self.data.contains_key("authToken") {
            return None;
        }

        match self.data["authToken"] {
            Value::String(ref s) => return Some(s.clone()),
            _ => return None,
        };
    }
}

struct RocketChat<'a> {
    client: reqwest::Client,
    auth: HashMap<&'a str, &'a str>,
    root_url: &'a str,
    auth_token: Option<String>,
}

fn concat(left: &str, right: &str) -> String {
    let mut s = String::from(left);
    s.push_str(right);
    s
}

impl<'a> RocketChat<'a> {
    fn new(client: Option<reqwest::Client>, root_url: &'a str, username: &'a str, password: &'a str) -> Self {
        let mut auth = HashMap::new();
        auth.insert("user", username);
        auth.insert("password", password);

        let client = match client {
            Some(c) => c,
            None => reqwest::Client::new(),
        };

        return RocketChat{
            client: client,
            auth: auth,
            root_url: root_url,
            auth_token: None,
        };
    }

    fn login(&mut self) -> Result<(), Error> {
        self.auth_token = None;

        let mut r = self.client
            .post(concat(self.root_url, "/api/v1/login").as_str())
            .json(&self.auth)
            .send()?;

        match r.status() {
            StatusCode::OK => {
                let text = r.text()?;
                let _t = match RocketLogin::from_str(text.as_str()) {
                    Ok(rl) => match rl.auth_token() {
                        Some(t) => {
                            self.auth_token = Some(t.clone());
                        },
                        None => return Err(Error::Data(String::from("No login data"))),
                    },
                    Err(e) => return Err(e),
                };
            },
            _ => return Err(Error::Login(String::from("Bad code"))),
        }

        Ok(())
    }
}

fn main() {
    let args = App::new(
            "RocketChat"
        ).arg(Arg::with_name("user")
             .short("u")
             .value_name("user")
             .required(true)
        ).arg(Arg::with_name("password")
             .short("p")
             .value_name("password")
             .required(true)
        ).arg(Arg::with_name("url")
              .short("U")
              .value_name("url")
              .required(true)
        ).get_matches();

    let mut client = RocketChat::new(
        None,
        args.value_of("url").unwrap(),
        args.value_of("user").unwrap(),
        args.value_of("password").unwrap(),
    );
    println!("{:?}", client.login());
}
