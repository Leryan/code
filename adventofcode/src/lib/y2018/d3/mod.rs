use std::fs::File;
use std::io::Read;
use std::str::FromStr;
use std::collections::HashMap;
use std::hash::{Hash, Hasher};

use utils::check_and_print;

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

        Ok(Claim {
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

#[derive(Copy, Clone)]
pub enum Occupied {
    Once,
    Overlap,
}

pub struct FabricPoint {
    x: u64,
    y: u64,
}

impl PartialEq for FabricPoint {
    fn eq(&self, other: &FabricPoint) -> bool {
        self.x == other.x && self.y == other.y
    }
}

impl Eq for FabricPoint {}

impl Hash for FabricPoint {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.x.hash(state);
        self.y.hash(state);
    }
}

pub struct Fabric {
    fab: HashMap<FabricPoint, Occupied>,
}

impl Fabric {
    pub fn new() -> Self {
        Fabric { fab: HashMap::new() }
    }

    pub fn push(&mut self, claim: &Claim) {
        for x in claim.x..claim.x + claim.w {
            for y in claim.y..claim.y + claim.h {
                let fp = FabricPoint { x: x, y: y };

                self.fab
                    .entry(fp)
                    .and_modify(|occupied| *occupied = Occupied::Overlap)
                    .or_insert(Occupied::Once);
            }
        }
    }

    pub fn overlap_surface(&self) -> u64 {
        self.fab
            .iter()
            .filter(|(_, occupied)| match occupied {
                Occupied::Overlap => true,
                _ => false,
            })
            .count() as u64
    }

    pub fn clear_surface(&mut self, claim: &Claim) -> bool {
        for x in claim.x..claim.x + claim.w {
            for y in claim.y..claim.y + claim.h {
                let fp = FabricPoint { x: x, y: y };

                let mut fabfp = self.fab.get_mut(&fp);
                match fabfp {
                    Some(occupied) => {
                        match occupied {
                            Occupied::Overlap => return false,
                            _ => {}
                        }
                    }
                    _ => {}
                }
            }
        }

        return true;
    }

    pub fn find_clear_claim_id(&mut self, claims: &Vec<Claim>) -> Option<u64> {
        let mut id: u64 = 0;
        for claim in claims {
            if self.clear_surface(&claim) {
                return Some(id + 1);
            }
            id += 1;
        }

        None
    }
}

pub fn runner() {
    let mut f = File::open("inputs/y2018/d3/input").unwrap();
    let mut input = String::new();
    f.read_to_string(&mut input).unwrap();

    let mut fabric = Fabric::new();
    let mut claims: Vec<Claim> = Vec::new();

    for claim in input.lines() {
        claims.push(claim.parse().unwrap());
    }

    for claim in &claims {
        fabric.push(&claim);
    }

    println!("--  day 03   ----------");
    check_and_print(1, fabric.overlap_surface(), Some(105231));
    check_and_print(2, fabric.find_clear_claim_id(&claims).unwrap(), Some(164));
}
