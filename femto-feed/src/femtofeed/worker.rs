use crate::entry::Entry;
use crate::errors::Error;
use feed_rs::parser;
use std::io::BufReader;
use std::sync::mpsc::{Receiver, Sender};

pub struct Worker {
    jobs: Receiver<Option<String>>,
    results: Sender<Entry>,
}

impl Worker {
    pub fn new(results: Sender<Entry>, jobs: Receiver<Option<String>>) -> Worker {
        Worker {
            jobs: jobs,
            results: results,
        }
    }
    pub fn run(&mut self) -> Result<(), Error> {
        loop {
            match self.jobs.recv()? {
                Some(feed_url) => self.handle(feed_url.as_str()),
                None => break,
            };
        }

        Ok(())
    }

    fn handle(&mut self, feed_url: &str) {
        println!(
            "{}: {:?}",
            feed_url,
            self.fetch_feed(feed_url).and_then(|feed| self.adapt(feed))
        );
    }

    fn fetch_feed(&mut self, feed_url: &str) -> Result<feed_rs::Feed, Error> {
        let mut response = reqwest::get(feed_url)?;
        let text = response.text()?;
        let mut buf = BufReader::new(text.as_str().as_bytes());
        parser::parse(&mut buf).ok_or(Error::Parse(String::from("nothing parsed")))
    }

    fn adapt(&mut self, feed: feed_rs::Feed) -> Result<(), Error> {
        let feed_title = feed.title.unwrap_or(String::from("unknown")).clone();
        for entry in feed.entries {
            self.results.send(Entry::with(entry, feed_title.as_str()))?;
        }

        Ok(())
    }
}
