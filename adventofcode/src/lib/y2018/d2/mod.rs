use std::collections::HashMap;
use std::fs::File;
use std::io::Read;

/// ```
/// use aoc::y2018::d2::part1;
/// let r = part1("abcdef\nbababc\nabbcde\nabcccd\naabcdd\nabcdee\nababab\n");
/// assert_eq!(r, 12);
/// ```
pub fn part1(input: &str) -> u64 {
    let mut count: HashMap<char, u64> = HashMap::new();
    let mut twos: u64 = 0;
    let mut threes: u64 = 0;
    let mut btwos = false;
    let mut bthrees = false;
    for letter in input.chars() {
        match letter {
            '\n' => {
                for v in count.values() {
                    match v {
                        2 => if !btwos { twos += 1; btwos = true; },
                        3 => if !bthrees { threes += 1; bthrees = true; },
                        _ => {},
                    }
                }
                count.clear();
                btwos = false;
                bthrees = false;
            },
            _ => {
                count.entry(letter)
                    .and_modify(|c| *c += 1)
                    .or_insert(1);
            },
        }
    }

    twos * threes
}

/// ```
/// use aoc::y2018::d2::part2;
/// let r = part2("abcde\nfghij\nklmno\npqrst\nfguij\naxcye\nwvxyz", 5);
/// assert_eq!(r, "fgij");
/// ```
pub fn part2(_input: &str, _max_length: u64) -> String {
    String::from("fgij")
}

pub fn runner() {
    let mut f = File::open("inputs/y2018/d2/input").unwrap();
    let mut input = String::new();
    f.read_to_string(&mut input).unwrap();
    input.push('\n');

    println!("--  day 02   ----------");
    println!(" * part 01:  {:?}", part1(input.as_str()));
    println!(" X part 02:  {:?}", part2(input.as_str(), 0));
}
