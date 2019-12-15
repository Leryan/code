extern crate reqwest;

use chat::reqwest::StatusCode;
use std::collections::HashMap;
use std::vec::Vec;
use Error;
use models;

pub struct Chat<'a> {
    client: reqwest::Client,
    auth: HashMap<&'a str, &'a str>,
    root_url: &'a str,
    me: Option<models::Me>,
}

fn concat(left: &str, right: &str) -> String {
    let mut s = String::from(left);
    s.push_str(right);
    s
}

impl<'a> Chat<'a> {
    pub fn new(client: Option<reqwest::Client>, root_url: &'a str, username: &'a str, password: &'a str) -> Self {
        let mut auth = HashMap::new();
        auth.insert("user", username);
        auth.insert("password", password);

        let client = match client {
            Some(c) => c,
            None => reqwest::Client::new(),
        };

        return Chat{
            client: client,
            auth: auth,
            root_url: root_url,
            me: None,
        };
    }

    pub fn auth(&self, reqbuilder: reqwest::RequestBuilder) -> reqwest::RequestBuilder{
        match self.me.as_ref() {
            Some(token) => {
                reqbuilder
                    .header("X-Auth-Token", token.auth_token.as_str())
                    .header("X-User-Id", token.user_id.as_str())
            },
            None => reqbuilder,
        }
    }

    pub fn login(&mut self) -> Result<(), Error> {
        self.me = None;

        let mut r = self.client
            .post(concat(self.root_url, "/api/v1/login").as_str())
            .json(&self.auth)
            .send()?;

        match r.status() {
            StatusCode::OK => {
                let text = r.text()?;
                match models::Login::from_str(text.as_str()) {
                    Ok(rl) => {
                        self.me = Some(rl.data);
                        return Ok(());
                    },
                    Err(e) => return Err(e),
                };
            },
            _ => return Err(Error::Login(String::from("Bad code"))),
        }
    }

    pub fn channels_list(&mut self) -> Result<Vec<String>, Error> {
        let api = concat(self.root_url, "/api/v1/channels.list");
        let r = self.auth(self.client.get(api.as_str())).send()?;

        match r.status() {
            StatusCode::OK => {
                return Ok(Vec::new());
            },
            _ => return Err(Error::Data(String::from("prout"))),
        }
    }
}
