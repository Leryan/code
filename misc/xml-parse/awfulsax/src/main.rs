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
    s: u64,
    nread: usize,
    irn: usize,
    acc: Vec<u8>,
    bvec: Vec<u8>,
    tok: Token,
}

const P_NONE: u64 = 0x0001;
const P_DATA: u64 = 0x0002;
const P_START_TAG_IN: u64 = 0x0004;
const P_END_TAG_IN: u64 = 0x0008;

impl<R: Read> Parser<R> {
    fn new(reader: R) -> Parser<R> {
        let mut bvec = Vec::with_capacity(8192);
        unsafe {
            let c = bvec.capacity();
            bvec.set_len(c);
        }
        return Parser {
            bufr: reader,
            s: P_NONE,
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
                    Ok(c) => {
                        if c == 0 {
                            return None;
                        }
                        self.irn = 0;
                        self.nread = c - 1;
                    }
                    Err(e) => {
                        println!("err: {}", e);
                        return None;
                    }
                }
            }

            if self.nread > 0 {
                match self.parse_chunk() {
                    Some(t) => return Some(t),
                    _ => (),
                }
            } else {
                return None;
            }
        }
    }

    fn parse_chunk(&mut self) -> Option<Token> {
        while self.irn < self.nread {
            self.irn += 1;
            let b: u8 = self.bvec[self.irn - 1];
            let nb: u8 = self.bvec[self.irn];

            if b == '<' as u8 {
                if self.s & P_NONE > 0 {
                    if nb != '/' as u8 {
                        self.s = P_START_TAG_IN;
                        self.acc.clear();
                    }
                } else if self.s & P_DATA > 0 {
                    if nb == '/' as u8 {
                        self.s = P_END_TAG_IN;
                        self.tok.data.clear();
                        self.tok.data.append(&mut self.acc.clone());
                        return Some(self.tok.clone());
                    }
                    self.s = P_START_TAG_IN;
                    self.acc.clear();
                }
            } else if b == '>' as u8 {
                if self.s & P_START_TAG_IN > 0 {
                    self.s = P_DATA;
                    self.tok.tag.clear();
                    self.tok.tag.append(&mut self.acc.clone());
                    self.acc.clear();
                } else if self.s & P_END_TAG_IN > 0 {
                    self.s = P_NONE;
                }
            } else if (self.s & P_DATA | self.s & P_START_TAG_IN) > 0 {
                self.acc.push(b);
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
            Some(tok) => urls.push(tok.data),
            None => {
                println!("nothing");
                break;
            }
        }
    }
}
