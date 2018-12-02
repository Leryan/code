extern crate avent_of_code;

use std::fs::File;
use std::io::Read;

use avent_of_code::y2018::d1::{part1, part2};

fn main() {
    let mut f = File::open("input").unwrap();
    let mut input = String::new();
    f.read_to_string(&mut input).unwrap();
    println!("part1: {:?}", part1(&input));
    println!("part2: {:?}", part2(&input));
}
