use std::collections::HashSet;
use std::fs::File;
use std::io::Read;

use utils::check_and_print;

/// ```
/// use aoc::y2018::d1::part1;
/// let numbers = vec![1, -2, 2];
/// assert_eq!(part1(&numbers), 1);
/// ```
pub fn part1(numbers: &Vec<i64>) -> i64 {
    let mut acc: i64 = 0;
    for num in numbers {
        acc += num;
    }
    acc
}

/// ```
/// use aoc::y2018::d1::part2;
/// let numbers = vec![1, 2, -5];
/// assert_eq!(part2(&numbers), 1);
/// ```
pub fn part2(numbers: &Vec<i64>) -> i64 {
    let mut acc: i64 = 0;
    let mut freqs = HashSet::new();

    freqs.insert(acc);

    loop {
        for num in numbers {
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

    let numbers: Vec<i64> = input.lines().map(
        |line| line.parse().unwrap()
    ).collect();

    println!("--  day 01   ----------");
    check_and_print(1, part1(&numbers), Some(553));
    check_and_print(2, part2(&numbers), Some(78724));
}
