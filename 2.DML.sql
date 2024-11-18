-- insert into : 테이블에 데이터 삽입
insert into 테이블명(컬럼명1, 컬럼명2, 컬럼명3) values(데이터1, 데이터2, 데이터3);

-- 문자열은 일반적으로 작은따옴표 ''를 사용
insert into 테이블명(id, name, email) values(3, 'kim', 'hong@naver.com');

-- select : 테이터 조회, * : 모든 컬럼을 의미
select * from author;
select name, email from author;

-- post 에 데이터 1줄 추가
insert into post(id, title, content, author_id) values(3, "벌써11월", "점심뭐먹을까", 3);

-- 테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'post';

-- insert 문을 통해 author데이터 2개정도 추가, post 데이터 2개 정도 추가(1개는 익명)
insert into author(id, name, email, password, address) values(4, "김철수", "철수@anver.com", 123, "한국");
insert into author(id, name, email, password, address) values(5, "이유리", "유리@anver.com", 123, "미국");

insert into post(id, title, contents, author_id) values(1, "미분당", "쌀국수", 1);
insert into post(id, title, contents, author_id) values(2, "코코", "돈부리", 2);
insert into post(id, title, contents, author_id) values(3, "육전국밥", "국밥", 3);
insert into post(id, title, contents) values(4, "포마토", "김밥");

-- update : 데이터 수정
-- where문을 빠뜨리게 될 경우, 모든 데이터에 update문이 실행됨에 유의
update author set name="홍길동" where id=1;
update author set name="홍길동2", email="hong@naver.com" where id=2;

-- delete : 데이터 삭제
-- where문을 빠뜨리게 될 경우, 모든 데이터가 삭제됨에 유의
delete from author where id=5;

-- select : 조회
select * from author; -- 어떠한 조회조건없이 모든 컬럼 조회
select * from author where id=1;
select * from author where name="홍길동";
select * from author where id > 3;
select * from author where id>3 and password=123;

select a.name from author a, post b where a.id = b.author_id; -- 글쓴 작가들 이름만 출력

-- distinct : 중복제거
select distinct name from author;

-- 정렬 : order by + 컬럼
-- 아무런 정렬조건 없이 조회 할 경우에는 pk기준으로 오름차순 정렬
-- asc : 오름차순, desc : 내림차순
select * from author order by name desc;

-- 멀티컬럼 order by : 여러 컬럼으로 정렬, 먼저쓴 컬럼 우선 정렬, 중복시, 그다음 정렬옵션 적용
select * from author order by name desc, email asc;

-- 결과값 개수 제한
select * from author where address is not null limit 2 ;

-- 별칭(alias)을 이용한 select 
select name as "이름", email as "이메일" from author;
select a.name, a.email from author as a;
select a.name, a.email from author a;

-- null을 조회조건으로 활용
select * from author where password is null;
select * from author where address is null;

-- 프로그래머스 sql문제풀이
-- 여러기준으로 정렬하기
-- 상위 n개 레코드