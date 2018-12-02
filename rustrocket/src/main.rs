extern crate clap;
extern crate reqwest;
extern crate rocket;

use clap::{App, Arg};

use rocket::chat::Chat;

fn main() {
    let args = App::new("RocketChat")
        .arg(
            Arg::with_name("user")
                .short("u")
                .value_name("user")
                .required(true),
        )
        .arg(
            Arg::with_name("password")
                .short("p")
                .value_name("password")
                .required(true),
        )
        .arg(
            Arg::with_name("url")
                .short("U")
                .value_name("url")
                .required(true),
        )
        .get_matches();

    let mut client = Chat::new(
        None,
        args.value_of("url").unwrap(),
        args.value_of("user").unwrap(),
        args.value_of("password").unwrap(),
    );
    println!("{:?}", client.login());
    println!("{:?}", client.channels_list());
}
