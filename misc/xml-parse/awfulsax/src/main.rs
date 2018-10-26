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
    acc: Vec<u8>,
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
            acc: Vec::with_capacity(8192),
            bvec: bvec,
            tok: Token::new(),
        };
    }

    fn parse(&mut self) -> Option<Token> {
        loop {
            if self.irn == self.nread {
                let read = self.bufr.read(&mut self.bvec);
                match read {
                    Ok(0) => {
                        return None;
                    }
                    Ok(c) => {
                        self.irn = 0;
                        self.nread = c - 1;
                    }
                    Err(e) => {
                        println!("err: {}", e);
                        return None;
                    }
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

    fn parse_chunk(&mut self) -> Option<Token> {
        while self.irn < self.nread {
            self.irn += 1;
            let b: u8 = self.bvec[self.irn - 1];

            if b == b'<' {
                let nb: u8 = self.bvec[self.irn];
                match self.s {
                    State::None => {
                        if nb != b'/' {
                            self.s = State::StartTag;
                            self.acc.clear();
                        }
                    }
                    State::Data => {
                        if nb == b'/' {
                            self.s = State::EndTag;
                            self.tok.data.clear();
                            self.tok.data.append(&mut self.acc.clone());
                            return Some(self.tok.clone());
                        }
                        self.s = State::StartTag;
                        self.acc.clear();
                    }
                    _ => (),
                }
            } else if b == b'>' {
                match self.s {
                    State::StartTag => {
                        self.s = State::Data;
                        self.tok.tag.clear();
                        self.tok.tag.append(&mut self.acc.clone());
                        self.acc.clear();
                    }
                    State::EndTag => {
                        self.s = State::None;
                    }
                    _ => (),
                }
            } else {
                match self.s {
                    State::Data | State::StartTag => {
                        self.acc.push(b);
                    }
                    _ => (),
                }
            }
        }

        None
    }
}

fn main() {
    let capacity = 128 * 1024;
    let file = File::open("sitemap.xml").unwrap();
    let bufr = BufReader::with_capacity(capacity, file);
    let mut urls: Vec<Vec<u8>> = Vec::with_capacity(8192);
    let mut parser = Parser::new(bufr);

    loop {
        match parser.parse() {
            Some(tok) => {
                urls.push(tok.data);
            }
            None => {
                println!("nothing");
                break;
            }
        }
    }
}
