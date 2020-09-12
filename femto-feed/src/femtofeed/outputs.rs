use crate::entry::Entry;
use crate::errors::Error;

pub trait Output {
    fn header(&mut self) -> Result<(), Error>;
    fn entries(&mut self, entries: &Vec<Entry>) -> Result<(), Error>;
    fn footer(&mut self) -> Result<(), Error>;
}

pub struct HTML<B> {
    buf: B,
}

impl<B: std::io::Write> HTML<B> {
    pub fn new(buf: B) -> HTML<B> {
        HTML { buf: buf }
    }
}

impl<B: std::io::Write> Output for HTML<B> {
    fn header(&mut self) -> Result<(), Error> {
        self.buf.write(
            "<!DOCTYPE html>\
             <html>\
             <head>\
             <meta charset=\"utf-8\"/>\
             </head>\
             <body>\
             <table>"
                .as_bytes(),
        )?;

        Ok(())
    }
    fn entries(&mut self, entries: &Vec<Entry>) -> Result<(), Error> {
        for entry in entries {
            self.buf.write(format!("{}", entry).as_bytes())?;
        }
        Ok(self.buf.flush()?)
    }
    fn footer(&mut self) -> Result<(), Error> {
        self.buf.write("</table></body></html>".as_bytes())?;
        Ok(())
    }
}
