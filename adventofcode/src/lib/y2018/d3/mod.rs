use std::fs::File;
use std::io::Read;
use std::str::FromStr;

#[derive(Debug)]
pub enum Error {
    ParseClaim(String),
}

impl From<std::num::ParseIntError> for Error {
    fn from(error: std::num::ParseIntError) -> Self {
        Error::ParseClaim(error.to_string())
    }
}

#[derive(Debug)]
pub struct Claim {
    pub x: u64,
    pub y: u64,
    pub w: u64,
    pub h: u64,
}

impl FromStr for Claim {
    type Err = Error;

    /// ```
    /// use aoc::y2018::d3::*;
    /// let data = "#1 @ 2,3: 4x5";
    /// let claim: Claim = data.parse().unwrap();
    /// let ref_claim = Claim{
    ///     x: 2,
    ///     y: 3,
    ///     w: 4,
    ///     h: 5,
    /// };
    /// assert_eq!(claim, ref_claim);
    /// ```
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let cleaned = s.replace(":", "");
        let elements: Vec<&str> = cleaned.split(" ").collect();
        if elements.len() != 4 {
            return Err(Error::ParseClaim(String::from("bad format")));
        }

        let position: Vec<&str> = elements[2].split(",").collect();
        if position.len() != 2 {
            println!("{:?}", elements);
            return Err(Error::ParseClaim(String::from("bad position")));
        }

        let dimensions: Vec<&str> = elements[3].split("x").collect();
        if dimensions.len() != 2 {
            return Err(Error::ParseClaim(String::from("bad dimensions")));
        }

        Ok(Claim{
            x: position[0].parse()?,
            y: position[1].parse()?,
            w: dimensions[0].parse()?,
            h: dimensions[1].parse()?,
        })
    }
}

impl PartialEq for Claim {
    fn eq(&self, other: &Claim) -> bool {
        self.x == other.x && self.y == other.y && self.w == other.w && self.h == other.h
    }
}

pub fn part1(_claims: &Vec<Claim>) -> u64 {
    0
}

pub fn runner() {
    let mut f = File::open("inputs/y2018/d3/input").unwrap();
    let mut input = String::new();
    f.read_to_string(&mut input).unwrap();

    let mut claims: Vec<Claim> = Vec::new();

    for claim in input.lines() {
        claims.push(claim.parse().unwrap());
    }

    println!("--  day 03   ----------");
    println!(" X part 01:  {:?}", part1(&claims));
}
