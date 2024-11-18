-- tinyint는 -128~127까지 표현(1byte 할당)
-- author테이블에 age컬럼 추가
alter table author add column age tinyint;

alter table author modify column age tinyint unsigned;
insert into author(id, age) values (7, 200);

-- decimal 실습
-- decimal (정수부, 소수부)
alter table post add column price decimal(10. 3)

-- decimal 소수점 초과 후 값 짤림 현상
insert into post(id,title, price) values(6, "오늘은 월요일", 10.33412);

-- 문자열 실습
alter table author add column self_introduction text;

insert into author(id, self_introduction) values(7, "안녕하세요 ?");

-- blob(바이너리테이터)(2진법 상태의 데이터) 타입 실습
alter table author add  column profile_image longblob;
insert into author (id, profile_image) values (8, LOAD_FILE('C:\\Users\Playdata\Desktop\myimage.png'))

-- blob 데이터 넣기
alter table author add  column profile_image longblob;
insert into author (id, profile_image) values (10, LOAD_FILE('C:\\myimage.png'))

-- enum : 삽일될 수 있는  데이터의 종류를 한정하는 데이터 타입
-- role 컬럼 추가
alter table author add column role enum('user', 'admin')not null default 'user';

-- user값 세팅 후 insert
insert into author(id, role) value(11, 'admin'); -- 정상

-- user값 세팅 후 insert(잘못된 값)
insert into author(id, role) value(12, 'member'); -- 오류

-- 아무것도 안넣고 insert(default 값)
insert into author(id) value(13); -- 정상

-- datetime은 입력, 수정, 조회시에 문자열 형식을 활용
update post set create_time = "2024-10-18 17:12:23" where id=7;


-- date : 날짜, datetime : 날짜 및 시분초(microseconds)
alter table post add column create_time datetime default current_timestamp();

-- 조회 시 비교연산자
select * from author where id >= 2;
select * from author where id between 2 and 4; -- 2 3 4 로 2, 4 둘다 포함
select * from author where id not(id<2 or id > 4); -- 2 3 4 로 2, 4 둘다 포함
select * from author where id in(2,3,4)
select * from author where id not in(1,5) -- 전체 데이터 1~5까지의 가정 하에
