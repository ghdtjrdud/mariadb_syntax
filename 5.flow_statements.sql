-- case문 (case when then else)
select 컬럼1, 컬럼2, 컬럼3,
case 컬럼4
    when 비교값1 then 결과값1
    when 비교값2 then 결과값2
    else 결과값3
end
from 테이블명;

select id, name, email,
case 
    when name is null then "익명사용자"
    else name
end
 from author;

-- ifnull(a,b) -> a가 있으면 a 출력, null 이면 b 출력
select id, email, ifnull(name, "익명사용자") as '사용자명' from author;

-- if(a,b,c) : a조건이 참이면 b반환, a조건이 거짓이면 c반환
select id, email, if(name is null, '익명사용자', name) as '사용자명' from author;