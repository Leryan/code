extern crate serde_json;
extern crate xmlrpc;

use self::xmlrpc::Request;

#[derive(Debug)]
pub enum SpacewalkError {
    Error(xmlrpc::Error),
    LoginFailed(xmlrpc::Error),
    UnknownError(String),
}

impl From<xmlrpc::Error> for SpacewalkError {
    fn from(err: xmlrpc::Error) -> SpacewalkError {
        SpacewalkError::Error(err)
    }
}

pub struct Spacewalk {
    url: String,
    username: String,
    password: String,
    authkey: String,
}

fn login_error(err: xmlrpc::Error) -> SpacewalkError {
    SpacewalkError::LoginFailed(err)
}

impl Spacewalk {
    /// Constructs a new `Spacewalk`.
    ///
    /// # Examples
    ///
    /// ```
    /// use spaceralk::spacewalk::Spacewalk;
    ///
    /// let url = String::from("http://localhost/rpc/api/");
    /// let user = String::from("admin");
    /// let pass = String::from("admin");
    /// let spc = Spacewalk::new(url, user, pass);
    /// ```
    pub fn new(url: String, username: String, password: String) -> Spacewalk {
        Spacewalk {
            url: url,
            username: username,
            password: password,
            authkey: "".to_string(),
        }
    }

    /// Log the user to Spacewalk, retreiving an authorization key.
    pub fn login(&mut self) -> Result<(), SpacewalkError> {
        let req = Request::new("auth.login")
            .arg(self.username.clone())
            .arg(self.password.clone());

        let authkey = try!(req.call_url(self.url.as_str()).map_err(login_error));

        match authkey {
            xmlrpc::Value::String(authkey) => {
                self.authkey = authkey; Ok(())
            }
            _ => {
                Err(SpacewalkError::UnknownError("authkey must be a String".to_string()))
            }
        }
    }

    /// Call a remote procedure with arguments as a JSON array.
    pub fn call(&self, method: &str, json_args: &str) -> Result<xmlrpc::Value, SpacewalkError> {
        let mut req = Request::new(method).arg(self.authkey.clone());
        let args: serde_json::Value = serde_json::from_str(json_args).unwrap();

        for arg in args.as_array().cloned().unwrap() {
            req = req.arg(decode_json_value(arg));
        }

        let val = try!(req.call_url(self.url.as_str()));
        Ok(val)
    }

    /// If logged-in, deauth from Spacewalk and reset the key.
    pub fn logout(&mut self) {
        if self.authkey == "" {
            return;
        }

        let _ = self.call("auth.logout", "[]");
        self.authkey = "".to_string();
    }
}

impl Drop for Spacewalk {
    fn drop(&mut self) {
        let _ = self.logout();
    }
}

fn decode_json_array(jarr: Vec<serde_json::Value>) -> xmlrpc::Value {
    let mut xarr: Vec<xmlrpc::Value> = Vec::new();
    for i in 0..jarr.len() {
        xarr.push(decode_json_value(jarr[i].clone()));
    }

    xmlrpc::Value::Array(xarr)
}

pub fn decode_json_value(jval: serde_json::Value) -> xmlrpc::Value {
    match jval {
        serde_json::Value::Number(item_val) => {
            xmlrpc::Value::Double(item_val.as_f64().unwrap())
        }
        serde_json::Value::String(item_val) => xmlrpc::Value::String(item_val.clone()),
        serde_json::Value::Null => xmlrpc::Value::Nil,
        serde_json::Value::Array(item_val) => decode_json_array(item_val),
        serde_json::Value::Bool(item_val) => xmlrpc::Value::Bool(item_val),
        _ => panic!("unhandeled value: {:?}", jval),
    }
}
