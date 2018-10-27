use std::fs::File;
use std::io::{BufReader, Read};

#[derive(Debug, Clone)]
struct Token {
    tag: Vec<u8>,
    data: Vec<u8>,
}

impl Token {
    fn new() -> Token {
        return Token {
            tag: Vec::new(),
            data: Vec::new(),
        };
    }
}

struct Parser<Read> {
    bufr: Read,
    s: State,
    nread: usize,
    irn: usize,
    bvec: Vec<u8>,
    tok: Token,
}

enum State {
    None,
    Data,
    StartTag,
    EndTag,
}

impl<R: Read> Parser<R> {
    fn new(reader: R) -> Parser<R> {
        let mut bvec = Vec::with_capacity(8192);
        unsafe {
            let c = bvec.capacity();
            bvec.set_len(c);
        }
        return Parser {
            bufr: reader,
            s: State::None,
            nread: 0,
            irn: 0,
            bvec: bvec,
            tok: Token::new(),
        };
    }

    fn read(&mut self) -> Result<usize, std::io::Error> {
        let read = self.bufr.read(&mut self.bvec);
        match read {
            Ok(0) => Ok(0),
            Ok(c) => {
                self.irn = 0;
                self.nread = c - 1;
                Ok(self.nread)
            }
            Err(e) => Err(e),
        }
    }

    fn parse(&mut self) -> Option<Token> {
        loop {
            if self.irn == self.nread {
                match self.read() {
                    Ok(0) => return None,
                    Err(e) => {
                        println!("{:?}", e);
                        return None;
                    }
                    _ => {}
                }
            }

            match self.nread {
                0 => return None,
                _ => match self.parse_chunk() {
                    Some(t) => return Some(t),
                    _ => (),
                },
            }
        }
    }

    fn parse_open(&mut self) -> Option<Token> {
        let nb: u8 = self.bvec[self.irn];
        match self.s {
            State::None => {
                if nb != b'/' {
                    self.s = State::StartTag;
                    self.tok.tag.clear();
                }
            }
            State::Data => {
                if nb == b'/' {
                    self.s = State::EndTag;
                    return Some(self.tok.clone());
                }
                self.s = State::StartTag;
                self.tok.tag.clear();
            }
            _ => {}
        }

        None
    }

    fn parse_close(&mut self) {
        match self.s {
            State::StartTag => {
                self.tok.data.clear();
                self.s = State::Data;
            }
            State::EndTag => {
                self.s = State::None;
            }
            _ => {}
        }
    }

    fn parse_chunk(&mut self) -> Option<Token> {
        while self.irn < self.nread {
            self.irn += 1;
            let b: u8 = self.bvec[self.irn - 1];

            match b {
                b'<' => match self.parse_open() {
                    Some(tok) => return Some(tok),
                    _ => {}
                },
                b'>' => self.parse_close(),
                _ => match self.s {
                    State::Data => self.tok.data.push(b),
                    State::StartTag => self.tok.tag.push(b),
                    _ => {}
                },
            }
        }

        None
    }
}

fn main() {
    let capacity = 128 * 1024;
    let file = File::open("sitemap.xml").unwrap();
    let bufr = BufReader::with_capacity(capacity, file);
    let mut urls: Vec<String> = Vec::new();
    let mut parser = Parser::new(bufr);

    loop {
        match parser.parse() {
            Some(tok) => {
                let t = String::from_utf8(tok.tag).unwrap();
                if t == "loc" {
                    urls.push(String::from_utf8(tok.data).unwrap());
                }
            }
            None => {
                println!("nothing");
                break;
            }
        }
    }

    println!("{} results", urls.len());
}
