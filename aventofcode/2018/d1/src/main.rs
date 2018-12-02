use std::fs::File;
use std::io::Read;
use std::collections::HashSet;

fn part1(input: &String) {
    let mut acc: i64 = 0;
    for line in input.lines() {
        acc += line.parse::<i64>().unwrap();
    }

    println!("part1: {:?}", acc);
}

fn part2(input: &String) {
    let mut acc: i64 = 0;
    let mut freqs: HashSet<i64> = HashSet::new();
    let mut rep: i64 = 0;
    let mut found = false;

    freqs.insert(acc);
    while !found {
        for line in input.lines() {
            let num = line.parse::<i64>().unwrap();
            acc += num;
            if freqs.contains(&acc) {
                rep = acc;
                found = true;
                break;
            }
            freqs.insert(acc);
        }
    }

    println!("part2: {:?}", rep);
}

fn main() {
    let mut f = File::open("input").unwrap();
    let mut input = String::new();
    f.read_to_string(&mut input).unwrap();
    part1(&input);
    part2(&input);
}
