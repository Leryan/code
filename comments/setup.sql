create table comments (
    id INT NOT NULL PRIMARY KEY,
    create_ts int not null,
    uri text not null,
    author varchar(255) not null,
    comment text not null,
    hidden boolean default false,
    replies_to int null,
    foreign key (replies_to) references comments(id)
);

insert into comments values (1, 1, "bla", "test", "comment", 0, null);
insert into comments values (2, 2, "bla2", "test2", "comment2", 0, null);
insert into comments values (3, 3, "bla", "test3", "comment3", 0, 1);
insert into comments values (4, 4, "bla2", "test4", "comment4", 0, 2);
insert into comments values (5, 5, "bla", "test5", "comment5", 0, 3)
