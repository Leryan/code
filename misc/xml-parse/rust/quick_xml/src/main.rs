extern crate quick_xml;

use std::fs::File;
use std::io::BufReader;
use quick_xml::Reader;
use quick_xml::events::Event;

fn main() {
    println!("Rust quick_xml SAX parsing");
    let mut urls: Vec<String> = Vec::new();
    let file = File::open("sitemap.xml").unwrap();
    let buffr = BufReader::new(file);
    let mut parser = Reader::from_reader(buffr);
    let mut loc = false;
    let mut pbuf = Vec::new();

    parser.trim_text(true);
    loop {
        match parser.read_event(&mut pbuf) {
            Ok(Event::Start(e)) => {
                match e.name() {
                    b"loc" => loc = true,
                    _ => (),
                }
            },
            Ok(Event::Text(e)) => {
                if loc {
                    let v = e.unescape_and_decode(&parser).unwrap();
                    urls.push(v);
                }
            },
            Ok(Event::End(e)) => {
                match e.name() {
                    b"loc" => loc = false,
                    _ => (),
                }
            }
            Err(_) => break,
            Ok(Event::Eof) => break,
            _ => (),
        }
        pbuf.clear();
    }

    println!("Memory? heh… dunno, but i have {} results", urls.len());
}
