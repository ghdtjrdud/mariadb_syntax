-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from author inner join post on author.id = post.author_id
select * from author a inner join post p on author.id = post.author_id

-- 출력순서만 달라질뿐 조회결과는 동일.
select * from post inner join author on author_id = post.author_id;

-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
-- post의 글쓴이가 없는데이터는 포함안됨, 글쓴이중에 글을 한번도 안쓴사람도 포함안됨
select a.email from post p inner join author a on p.author_id = a.id;

-- 글쓴이가 있는 글의 제목, 내용 그리고 글쓴이의 이메일을 출력하시오.
select p.title, p.contents, a.email from post p inner join author a on p.author_id = a.id;

-- 모든 글목록을 출력하고, 만약에 글쓴이가 있다면 이메일 정보를 출력
-- left outer join -> left join 으로 생략 가능
-- 글을 한번도 안쓴 author 의 정보 포함안됨
select p.*, a.email from post p left join author a on p.author = a.id;

-- 글쓴이를 기준으로 left join 할 경우, 글쓴이가 n개의 글을 쓸 수 있으므로 같은 글쓴이가 여러번
-- 출력될 수 있음.(1 : n 관계여서)
-- 글쓴이가 없는 post 정보 포함 안됨
select * from author a left join post p on a.id = p.author_id;

-- 글쓴이가 있는 글 중에서 글의 title 과 저자의 email 만을 출력하되, 저자의 나이가 30세 이상인 글만
select p.title, a.email
from post p inner join author a
on p.author_id = a.id
where a.age >= 30;

-- 글의 내용과 글의 저자가 이름이 있는 (not null), 글 목록을 출력하되
-- 2024-06 이후에 만들어진 글만 출력
select p.*
from post p inner join author a
on p.author_id = a.id
where date_fromat > '2024-06-01' and
p.name is not null;

-- union : 두 테이블의 select결과를 횡으로 결합(기본적으로 distinct 적용)
-- 컬럼의 개수와 컬럼의 타입의 같아야함에 유의
-- union all : 중복까지 모두 포함
select name, email form author union select title, contents from post;

-- 서브쿼리 : select문 안에 또다른 select문을 서브쿼리라 한다.
-- where 절
select a.* from author a inner join post p on a.id = p.author_id;
select* from author where id in(select author_id from post);

-- select 절
-- author의 email과 author별로 본인이 쓴 글의 개수를 출력
select a.email
from author a
where id in (select count(*) from post where author_id=a.id);

-- from 절
select a.name
from (select * from author)as a;

-- 집계함수
-- null은 count에서 제외
select count(*) from author;
select sum(*) from author;
select avg(*) from author;

-- 소수점 첫번째자리에서 반올림해서 소수점을 없앰.(0번째 자리로 만들기)
select round(avg(price), 0) from post;

-- group by : 그룹화된 데이터를 데이터 별로 취급.
-- author_id로 그룹핑 하였으면, 그 외의 컬럼을 조회하는 것은 적절치 않음.
select author_id from post group by author_id;

-- group by 와 집계함수 같이 사용하는 케이스가 많음.
-- 아래 쿼리에서 *은 그룹화된 데이터내에서의 개수
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price) from post group by author_id;

-- author의 email과 author 별로 본인이 쓴 글의 개수를 출력
select a.email, (select count(*) 
                from post 
                where author_id=a.id) 
from author a;

select a.email
from author a left join post p
on a.id = p.author_id
where a.id = p.author
group by a.email;

-- where 와 group by
-- 연도별 post 글의 개수 출력, 연도가 null 인 값은 제외
select date_format(create_time, '%Y'), count(*)
from post
where create_time in not null
group by create_time;

-- having : group by 를 통해 나온 집계값의 대한 조건
-- 글을 2개 이상 쓴사람에 대한 정보조회
select author_id from post group by author_id having count(*)>=2
select author_id count(*) as count from post group by author_id having count>=2;

