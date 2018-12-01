extern crate reqwest;
extern crate clap;

use std::collections::HashMap;

use clap::{App, Arg};
use reqwest::StatusCode;

struct RocketChat<'a> {
    client: reqwest::Client,
    auth: HashMap<&'a str, &'a str>,
    root_url: &'a str,
}

fn concat(left: &str, right: &str) -> String {
    let mut s = String::from(left);
    s.push_str(right);
    s
}

impl<'a> RocketChat<'a> {
    fn new(root_url: &'a str, username: &'a str, password: &'a str) -> Self {
        let mut auth = HashMap::new();
        auth.insert("user", username);
        auth.insert("password", password);
        return RocketChat{
            client: reqwest::Client::new(),
            auth: auth,
            root_url: root_url,
        };
    }

    fn login(&self) -> Result<(), reqwest::Error> {
        let mut r = self.client
            .post(concat(self.root_url, "/api/v1/login").as_str())
            .json(&self.auth)
            .send()?;

        match r.status() {
            StatusCode::OK => println!("ok: {:?}", r.text().unwrap()),
            _ => println!("{:?}", r.text()),
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

    let client = RocketChat::new(
        args.value_of("url").unwrap(),
        args.value_of("user").unwrap(),
        args.value_of("password").unwrap(),
    );
    println!("{:?}", client.login());
}
