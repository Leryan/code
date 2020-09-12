use chrono::NaiveDateTime;
use std::cmp::Ordering;
use std::fmt;

pub struct Entry {
    pub link: String,
    pub title: String,
    pub created: NaiveDateTime,
    pub from: String,
}

impl fmt::Display for Entry {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(
            f,
            "<tr><td>{}</td><td>{}</td><td><a href=\"{}\">{}</a></td>\n",
            self.created, self.from, self.link, self.title
        )
    }
}

impl Entry {
    /// # Arguments
    ///  * entry: feed entry
    ///  * from: feed id/name
    pub fn with(entry: feed_rs::entry::Entry, from: &str) -> Entry {
        Entry {
            title: entry.title.unwrap_or(String::from("no title")),
            link: entry.alternate[0].href.clone(),
            created: entry.published,
            from: String::from(from),
        }
    }
}

impl PartialEq for Entry {
    fn eq(&self, other: &Entry) -> bool {
        self.created == other.created
    }
}

impl Eq for Entry {}

impl Ord for Entry {
    fn cmp(&self, other: &Entry) -> Ordering {
        self.created.cmp(&other.created)
    }
}

impl PartialOrd for Entry {
    fn partial_cmp(&self, other: &Entry) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}
