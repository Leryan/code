// _30_guessgame
extern crate rand;

use std::io;
use std::cmp::Ordering;
use rand::Rng;
//</> _30_guessgame

fn _30_guessgame() {

   println!("Guess the number!");

   let secret_number = rand::thread_rng().gen_range(1, 101);

   loop {
       println!("Please input your guess.");

       let mut guess = String::new();

       io::stdin().read_line(&mut guess)
           .expect("failed to read line");

       let guess: u32 = match guess.trim().parse() {
           Ok(num) => num,
           Err(_) => continue,
       };

       println!("You guessed: {}", guess);

       match guess.cmp(&secret_number) {
           Ordering::Less    => println!("Too small!"),
           Ordering::Greater => println!("Too big!"),
           Ordering::Equal   => {
               println!("You win!");
               break;
           }
       }
   }

}

fn _41_varbind() {
    println!("https://doc.rust-lang.org/book/variable-bindings.html");


    /* BASICS */
    // simple binding
    let _a = 1;

    // pattern
    let (_b, _c) = (2, 3);
    
    // type annotation
    let _d: i32 = 4;


    // immutability
    let _e = 5;
    // e = 6; -> fails because e is immutable


    // mutability
    let mut _f = 7;
    _f = 8;

    // init before use
    let _g: i32;
    // println!("G value: {}", _g); -> fails because not initialised



    /* SCOPE & SHADOWING */
    let _h: i32 = 9; // will be available from "sub-scopes"
    println!("_h value: {}", _h);
    {
        let _h: i32 = 10;
        println!("_h value: {}", _h);
        let _i: i32 = 20; // exists only here, not outside
    }
    println!("_h value: {}", _h);
    let _h = "Type changed";
    println!("_h value: {}", _h);

}


fn _42_functions() {
    println!("https://doc.rust-lang.org/book/functions.html");

    // parameters type must be given
    fn parameters(x: i32, y: u64) {
        println!("params: {} - {}", x, y);
    }

    // return type
    fn add_one(x: i32) -> i32 {
        // https://doc.rust-lang.org/book/functions.html#expressions-vs-statements
        x + 1 // no need for return keyword because this is an expression
    }

    fn _diverge() -> ! {
        panic!("I never return");
    }

    parameters(1, 2);

    let x = add_one(1);
    println!("added one to one: {}", x);

    // function pointer, explicit
    let _fp0: fn(i32) -> i32 = add_one;
    // function pointer, implicit
    let _fp1 = add_one;
    println!("fp1: {}", _fp1(2));
}

fn _43_primitive_types() {
    println!("https://doc.rust-lang.org/book/primitive-types.html");

    // booleans
    let _bt = true;
    let _bf = false;

    // char
    let _c = 'x';
    let _cu = '™';

    // numerics
    // https://doc.rust-lang.org/book/primitive-types.html#numeric-types

    // arrays
    // https://doc.rust-lang.org/std/primitive.array.html
    let _ai = [1, 2, 3]; // type: [i32, 3]
    let _af = [1.0, 2.0, 3.0]; // type: [f64, 3]
    let _aa = [0; 10]; // type: [i32, 10]

    println!("array _aa len: {}", _aa.len());
    println!("array _aa third value: {}", _aa[2]);

    let _names = ["bli", "bla", "blu"];
    println!("third name: {}", _names[2]);

    // array slicing
    let _av = [0, 1, 2, 3, 4, 5];
    let _as0 = &_av[0..2];
    let _as1 = &_av[3..5];


    // str
    // https://doc.rust-lang.org/book/strings.html
    let _str = "bla"; // type: &str

    // tuples
    let _t0 = (1, "blu", 3.0);

}

fn main() {
    _41_varbind();
    _42_functions();
    _43_primitive_types();
}
