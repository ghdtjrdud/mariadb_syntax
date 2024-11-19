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

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select* from post where title like '%h' -- h로 끝나는 title검색
select* from post where title like 'h%' -- h로 시작하는 title검색
select* from post where title like '%h%' -- 단어의 중간에 h라는 키워드가 있는 경우 검색(단어가 포함이면 가능)

-- regexp : 정규표현식을 활용한 조회
select * from post where title regexp '[a-z]'; -- 하나라도 알파벳 소문자가 들어잇으면
select * from post where title regexp '[가-힣]'; -- 하나라도 한글이 들어잇으면

-- 타입변환 ==> cast 날짜 변환, convert 숫자 ->날짜, 문자 -> 날짜
select cast(20241119 as date);
select cast("20241119" as date);
select convert(20241119 as date);
select convert("20241119" as date);

-- 문자 -> 숫자 변환 
select cast('12' as unsigned)

-- 날짜 -> 시간을 숫자로 뽑아내기
cast(date_format(created_time, '%h') as unsigned)

-- 날짜조회 방법 : like패턴, 부등호 활용, date_format
select * from post where created_time like '2024-11%'; -- 문자열 조회
select * from post where created_time >= '2024-01-01' and create_time < "2025-01-01";

-- date_format 활용
select date_format(created_time, "%Y-%m-%d") from post;
select date_format(created_time, "%H-%i-%s") from post;
select * from post where date_format(create_time, "%Y")='2024;'
select * from post cast(data_format(create_time, "%Y")='2024' as unsigned) = 2024;

-- 현재 날짜와 시간
select now();