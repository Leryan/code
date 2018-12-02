extern crate serde;
extern crate serde_json;

use Error;
#[derive(Deserialize)]
pub struct Me {
    #[serde(rename = "authToken")]
    pub auth_token: String,
    #[serde(rename = "userId")]
    pub user_id: String,
}

#[derive(Deserialize)]
pub struct Login {
    pub data: Me,
}

impl Login {
    pub fn from_str(data: &str) -> Result<Login, Error> {
        match serde_json::from_str(data) {
            Ok(v) => return Ok(v),
            Err(e) => return Err(Error::Data(e.to_string())),
        };
    }
}
