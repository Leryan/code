extern crate xml;

use std::fs::File;
use std::io::BufReader;
use xml::reader::{EventReader, XmlEvent};

fn main() {
    let mut urls: Vec<String> = Vec::new();
    let file = File::open("sitemap.xml").unwrap();
    let file = BufReader::new(file);
    let mut loc = false;

    let parser = EventReader::new(file);
    for e in parser {
        match e {
            Ok(XmlEvent::StartElement { name, .. }) => {
                match name {
                    xml::name::OwnedName{ local_name, prefix, .. } => {
                        match prefix {
                            None => {
                                if local_name == "loc" {
                                    loc = true;
                                }
                            },
                            _ => ()
                        }
                    }
                }
            }
            Ok(XmlEvent::Characters(s)) => {
                if loc {
                    urls.push(s.clone());
                }
            }
            Ok(XmlEvent::EndElement{..}) => {
                loc = false;
            }
            Err(e) => {
                println!("Error: {}", e);
                break;
            }
            _ => {}
        }
    }

    println!("{}", urls.len());
}
