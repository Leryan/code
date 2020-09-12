use clap::{App, Arg};
use lib::errors::Error;
use lib::femtofeed::outputs::HTML;
use lib::femtofeed::FemtoFeed;
use std::fs::File;
use std::io::BufReader;

fn main() -> Result<(), Error> {
    let args = App::new("Femto Feed")
        .arg(
            Arg::with_name("feeds")
                .short("f")
                .value_name("feeds")
                .default_value("feeds.txt"),
        )
        .arg(
            Arg::with_name("output")
                .short("o")
                .value_name("output")
                .default_value("femtofeed.html"),
        )
        .arg(
            Arg::with_name("threads")
                .short("t")
                .value_name("threads")
                .default_value("4"),
        )
        .get_matches();
    FemtoFeed::new(
        HTML::new(File::create(args.value_of("output").unwrap())?),
        BufReader::new(File::open(args.value_of("feeds").unwrap())?),
        args.value_of("threads").unwrap().parse()?,
    )?
    .run()
}
