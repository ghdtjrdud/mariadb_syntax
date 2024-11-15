-- mariadb 서버 접속
mariadb -u root -p

-- 스키마(database) 목록 조회
show databases;

-- 데이터베이스 생성
create database board;

-- 데이터베이스 삭제
drop database board;

-- 데이터베이스 생성
use board;

-- 테이블 목록조회
show tables;

-- 문자 인코딩(문자체계) 조회
show variables like 'character_set_server';

-- 문자 인코딩 변경
ALTER DATABASE board DEFAULT CHARACTER SET = utf8;

-- 테이블 생성
create table author(
    id int primary key,
    name varchar(255),
    email varchar(255),
    password varchar(255)
);

-- 테이블 컬럼 상세조회
show full columns from author;

-- 테이블 생성 명령문 조회
show create table author;

-- post 테이블 신규 생성(id, title, content, author_id)
create table post(
    id int primary key,
    title varchar(255),
    content varchar(255),
    author_id int foreign key(author_id) references author(id)
);

-- 테이블 index(성능향상 옵션) 조회
show index from author;

-- alter문 : 테이블의 구조를 변경
-- 테이블의 이름 변경
alter table post rename posts;

-- 테이블 컬럼 추가
alter table post add column age int;

-- 테이블 컬럼 삭제
alter table post drop column age;

-- 테이블 컬럼명 변경
alter table post change column content contents varchar(255);

-- 테이블 컬럼 타입과 제약조건 변경 => 덮어 쓰기 됨에 유의
alter table author modify column email varchar(100) not null;

-- 실습 : author 테이블에 address컬럼추가. varchar 255
alter table author add column address varchar(255);

-- 실습 : post 테이블에 title 은 not null로 변경, contents 3000자로 변경
alter table post modify column title varchar(255) not null;
alter table post modify column contents varchar(3000);

-- 테이블 삭제
show create table post;
drop table post;