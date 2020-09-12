use crate::entry::Entry;
use crate::errors::Error;
use std::sync::mpsc;

pub mod outputs;
mod worker;

pub struct FemtoFeed<O, F> {
    out: O,
    feeds: F,
    threads: u64,
}

impl<O: outputs::Output, F: std::io::BufRead> FemtoFeed<O, F> {
    /// # Arguments
    ///  * output: outputs::Output implementor to write the feed entries
    ///  * feeds: file path to
    pub fn new(output: O, feeds: F, threads: u64) -> Result<FemtoFeed<O, F>, Error> {
        Ok(FemtoFeed {
            out: output,
            feeds: feeds,
            threads: threads,
        })
    }

    pub fn run(&mut self) -> Result<(), Error> {
        let mut entries: Vec<Entry> = Vec::new();
        let (ressend, resrecv) = mpsc::channel();
        let mut workers = Vec::new();
        let mut jobqs = Vec::new();

        for _ in 0..self.threads {
            let (jobsend, jobrecv) = mpsc::channel();
            let mut worker = worker::Worker::new(ressend.clone(), jobrecv);
            let child = std::thread::spawn(move || {
                match worker.run() {
                    Err(err) => println!("worker error: {:?}", err),
                    _ => {}
                };
            });
            workers.push(child);
            jobqs.push(jobsend);
        }

        let mut feed = String::new();
        let mut worker_idx = 0;
        while self.feeds.read_line(&mut feed)? > 0 {
            jobqs[worker_idx].send(Some(String::from(feed.trim())))?;
            worker_idx = (worker_idx + 1) % self.threads as usize;
            feed.clear();
        }

        // send None to stop workers
        for jqs in jobqs {
            jqs.send(None)?;
        }

        for worker in workers {
            match worker.join() {
                Ok(_) => {}
                Err(e) => println!("error joining thread: {:?}", e),
            };
        }

        loop {
            let res = resrecv.try_iter().next();
            match res {
                Some(entry) => entries.push(entry),
                None => break,
            };
        }

        entries.sort();
        entries.reverse();

        self.out.header()?;
        self.out.entries(&entries)?;
        self.out.footer()?;

        Ok(())
    }
}
