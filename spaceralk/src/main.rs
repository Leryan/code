extern crate argparse;
extern crate spaceralk;
extern crate xmlrpc;

use argparse::{ArgumentParser, Store};

use spaceralk::spacewalk::*;

struct PrgmArgs {
    url: String,
    method: String,
    json_args: String,
    username: String,
    password: String,
}

fn main_args() -> PrgmArgs {
    let mut prgm_args = PrgmArgs {
        url: String::from(""),
        method: "".to_string(),
        json_args: "[]".to_string(),
        username: String::from(""),
        password: String::from(""),
    };

    // if this block is removed, we rush into a borrow problem.
    // this block solves it because we explicitely contain the "borrow lifetime"
    {
        let mut parser = ArgumentParser::new();

        parser.set_description("Spacewalk XML-RPC API to the CLI, powered by Rust.");

        parser
            .refer(&mut prgm_args.url)
            .add_option(&["-U", "--url"], Store, "Full URL to XML-RPC API.")
            .required();

        parser
            .refer(&mut prgm_args.username)
            .add_option(&["-u", "--username"], Store, "Spacewalk user")
            .required();

        parser
            .refer(&mut prgm_args.password)
            .add_option(&["-p", "--password"], Store, "Spacewalk password")
            .required();

        parser
            .refer(&mut prgm_args.method)
            .add_option(&["-m", "--method"], Store, "Method to call")
            .required();

        parser.refer(&mut prgm_args.json_args).add_option(
            &["-j", "--json-args"],
            Store,
            "Arguments as JSON Array",
        );

        parser.parse_args_or_exit();
    }

    prgm_args
}

fn work(sw: &mut Spacewalk, method: &str, args: &str) -> Result<xmlrpc::Value, SpacewalkError> {
    try!(sw.login());
    let cr = try!(sw.call(method, args));
    Ok(cr)
}

fn main() {
    let prgm_args = main_args();
    let mut spc = Spacewalk::new(prgm_args.url, prgm_args.username, prgm_args.password);
    let r = work(&mut spc, &prgm_args.method, &prgm_args.json_args);

    match r {
        Ok(value) => println!("Result: {:?}", value),
        Err(err) => println!("Error: {:?}", err),
    };
}
