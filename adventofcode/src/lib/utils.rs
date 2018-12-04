use std::fmt::Debug;

pub fn check_and_print<L: Debug + PartialEq>(part: u8, answer: L, control: Option<L>) {
    match control {
        Some(value) => {
            if answer == value {
                println!(" ✓ part {:02}:  {:?}", part, answer);
            } else {
                println!(" ✗ part {:02}:  {:?} (wants {:?})", part, answer, value);
            }
        },
        None => {
            println!(" ? part {:02}:  {:?}", part, answer);
        }
    }
}
