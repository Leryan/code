use std::collections::HashSet;

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

    rep
}
