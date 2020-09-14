extern crate clap;
extern crate cursive;
extern crate reqwest;
extern crate rocket;

use clap::{App, Arg};

use cursive::direction::Orientation;
use cursive::event::Event;
use cursive::event::Key;
use cursive::menu::MenuTree;
use cursive::view::ScrollStrategy;
use cursive::views::*;
use cursive::Cursive;
use rocket::chat::Chat;

fn main() {
    let args = App::new("RocketChat")
        .arg(
            Arg::with_name("user")
                .short("u")
                .value_name("user")
                .required(true),
        )
        .arg(
            Arg::with_name("password")
                .short("p")
                .value_name("password")
                .required(true),
        )
        .arg(
            Arg::with_name("url")
                .short("U")
                .value_name("url")
                .required(true),
        )
        .get_matches();

    let mut client = Chat::new(
        None,
        args.value_of("url").unwrap(),
        args.value_of("user").unwrap(),
        args.value_of("password").unwrap(),
    );

    let mut siv = Cursive::default();

    siv.menubar().add_subtree(
        "Paper - Esc to access menu",
        MenuTree::new().leaf("Quit", |s| s.quit()),
    );
    siv.set_autohide_menu(false);
    siv.add_global_callback(Key::Esc, |s| s.select_menubar());

    siv.add_global_callback(Event::CtrlChar('l'), |s| {
        s.call_on_id("input", |view: &mut EditView| {
            view.set_content("");
        });
    });
    let tchatview = ScrollView::new(IdView::new("tchat", TextView::empty()))
        .scroll_strategy(ScrollStrategy::StickToBottom);
    let inputview = IdView::new("input", EditView::new().on_submit(input_text));
    siv.add_fullscreen_layer(BoxView::with_full_screen(
        LinearLayout::new(Orientation::Vertical)
            .child(tchatview)
            .child(inputview),
    ));

    siv.run();
}

fn input_text(s: &mut Cursive, content: &str) {
    s.call_on_id("tchat", |view: &mut TextView| match content {
        "" => {}
        _ => {
            view.append(content);
            view.append("\n");
        }
    });
    s.call_on_id("input", |view: &mut EditView| {
        view.set_content("");
    });
}
