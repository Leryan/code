use std::collections::HashSet;
use std::fs::File;
use std::io::Read;

/// ```
/// use aoc::y2018::d1::part1;
/// let mut input = String::new();
/// input.push_str("+1\n");
/// input.push_str("-1\n");
/// assert_eq!(part1(&input), 0);
/// ```
pub fn part1(input: &String) -> i64 {
    let mut acc: i64 = 0;
    for line in input.lines() {
        acc += line.parse::<i64>().unwrap();
    }
    acc
}

/// ```
/// use aoc::y2018::d1::part2;
/// let mut input = String::new();
/// input.push_str("+1\n");
/// input.push_str("+2\n");
/// input.push_str("-5\n");
/// assert_eq!(part2(&input), 1);
/// ```
pub fn part2(input: &String) -> i64 {
    let mut acc: i64 = 0;
    let mut freqs: HashSet<i64> = HashSet::new();
    freqs.insert(acc);
    loop {
        for line in input.lines() {
            let num = line.parse::<i64>().unwrap();
            acc += num;
            if freqs.contains(&acc) {
                return acc;
            }
            freqs.insert(acc);
        }
    }
}

pub fn runner() {
    let mut f = File::open("inputs/y2018/d1/input").unwrap();
    let mut input = String::new();
    f.read_to_string(&mut input).unwrap();
    println!("---- day 01    ------");
    println!(" * part 01: {:?}", part1(&input));
    println!(" * part 02: {:?}", part2(&input));
}
