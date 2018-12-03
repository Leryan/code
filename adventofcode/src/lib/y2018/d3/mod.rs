use std::fs::File;
use std::io::Read;
use std::str::FromStr;
use std::collections::HashSet;
use std::hash::{Hash, Hasher};

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
        self.x == other.x &&
            self.y == other.y &&
            self.w == other.w &&
            self.h == other.h
    }
}

#[derive(Copy, Clone)]
pub enum Occupied {
    None,
    Once,
    Overlap,
}

pub struct FabricPoint {
    x: u64,
    y: u64,
    occupied: Occupied,
}

impl PartialEq for FabricPoint {
    fn eq(&self, other: &FabricPoint) -> bool {
        self.x == other.x &&
            self.y == other.y
    }
}

impl Eq for FabricPoint {
}

impl Hash for FabricPoint {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.x.hash(state);
        self.y.hash(state);
    }
}

pub struct Fabric {
    fab: HashSet<FabricPoint>,
}

impl Fabric {
    pub fn new() -> Self {
        Fabric{
            fab: HashSet::new(),
        }
    }

    pub fn push(&mut self, claim: &Claim) {
        for x in claim.x..claim.x+claim.w {
            for y in claim.y..claim.y+claim.h {
                let fp = FabricPoint{
                    x: x,
                    y: y,
                    occupied: Occupied::Once,
                };

                let mut fabfp = self.fab.take(&fp);
                match fabfp {
                    None => {
                        self.fab.insert(fp);
                    },
                    Some(ffp) => {
                        let mut nfabfp = FabricPoint{
                            x: ffp.x,
                            y: ffp.y,
                            occupied: ffp.occupied,
                        };
                        match ffp.occupied {
                            Occupied::None => nfabfp.occupied = Occupied::Once,
                            Occupied::Once => nfabfp.occupied = Occupied::Overlap,
                            _ => {},
                        }
                        self.fab.insert(nfabfp);
                    },
                }
            }
        }
    }

    pub fn overlap_surface(&self) -> u64 {
        self.fab.iter().filter(
            |fp| match fp.occupied {
                Occupied::Overlap => true,
                _ => false,
            }
        ).count() as u64
    }
}

pub fn runner() {
    let mut f = File::open("inputs/y2018/d3/input").unwrap();
    let mut input = String::new();
    f.read_to_string(&mut input).unwrap();

    let mut fabric = Fabric::new();

    for claim in input.lines() {
        fabric.push(&claim.parse().unwrap());
    }

    println!("--  day 03   ----------");
    println!(" * part 01:  {:?}", fabric.overlap_surface());
}
