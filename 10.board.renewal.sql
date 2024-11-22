-- 여러 사용자가 1개의 글을 수정할 수 있다. 가정 후 db 리뉴얼
-- author 와 post 가 n:m 관계가 되어 관계테이블을 별도로 생성
create table author(
	id bigint primary key auto_increment,
    email varchar(255) not null unique,
    password varchar(255),
    name varchar(255),
    created_time datetime default current_timestamp
);

alter table author modify column email varchar(255) not null unique;

drop table author;

insert into author(email, password, name) values("1@naver.com", "1234", "일");

select * from post;
desc author;

create table post(
	id bigint primary key auto_increment,
    title varchar(255) not null,
    contents varchar(255),
    created_time datetime default current_timestamp
);

create table author_address(
	id bigint not null auto_increment,
    country varchar(255),
    city varchar(255),
    street varchar(255),
    created_time datetime default current_timestamp,
    author_id bigint not null, 
    primary key(id),
    foreign key(author_id) references author(id)
);

alter table author_address modify column author_id bigint not null unique;
desc author_address;

create table author_post(
	id bigint primary key auto_increment,
    post_id bigint not null,
    author_id bigint not null,
    created_time datetime default current_timestamp,
    foreign key(post_id) references post(id),
    foreign key(author_id) references author(id)
);

desc author_post;
select * from author_post;

insert into author(email, password, name) values("1@naver.com", "1234", "일");
insert into author(email, password, name) values("2@naver.com", "1234", "이");
insert into author(email, password, name) values("3@naver.com", "1234", "삼");

insert into author_address(country, city, street, author_id) values("대한민국", "서울", "동작구", 1);
insert into author_address(country, city, street, author_id) values("미국", "뉴욕", "뉴뉴욕", 2);
insert into author_address(country, city, street, author_id) values("일본", "오사카", "돈키호테", 3);

insert into post(title, contents) values("신나는 금요일", "점심은 뭐먹을까요");
insert into post(title, contents) values("신나는 토요일", "카공족");
insert into post(title, contents) values("우울한 일요일", "내일 등원");

insert into author_post(post_id, author_id) values(1, 1);
insert into author_post(post_id, author_id) values(2, 2);
insert into author_post(post_id, author_id) values(3, 3);

-- 복합키로 author_post 2 생성
create table author_post2(
    auhtor_id bigint not null,
    post_id bigint not null,
    primary key(author_id, post_id),
    foreign key(post_id) references post(id),
    foreign key(author_id) references author(id)
);

-- 내 id로 내가 쓴 글 조회
select * 
from post p inner join autho_post ap
on p.id = ap.post_id
where ap.author_id = 1;