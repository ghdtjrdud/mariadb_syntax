-- read uncommited 에서 발생할 수 있는 dirty read 실습
-- 실습방법 : 워크밴치에서 auto_commit 해제 후 udate, commit 하지 않음
--           터미널을 열어 select 햇을 때 위 변경사항이 읽히는지 확인(transaction2)
-- 결론 : mariadb는 기본이 repeqtable read 이므로 commit 되기전에 조회되는 dirty read 발생하지 않음

-- read committed에서 발생할 수 있는 phantom read(또는 non-repeatable read) 실습
-- 아래 코드는 워크벤치에서 실행
start transaction;
select count(*) from author;
do sleep(15);
select count(*) from author;
commit;

-- 아래코드는 터미널에서 실행
insert into author(email) values('fffff');

-- 결론 : mariadb는 기본이 repeatable read 이므로 phantom read 발생하지 않음

-- repeatable read에서 발생할 수 있는 lost update 실습
-- lost update 해결을 위한 베타적 lock 워크벤치 실행
start transaction;
select post_count from author where id =4 for update;
do sleep(10);
update author set post_count = (select post_count from author where id =4)-1 where id =4 ;
commit;

-- lost update 해결을 위한 공유 lock 터미널에서 실행
update author set post_count = (select post_count from author where id =4)-1 where id =4 ;

-- lost update 해결을 위한 공유 lock / 워크밴치에서 실행
start transaction;
select post_count from author where id = 4 lock in share mode;
dㅐ sleep(10);
commit;

-- 터미널 실행
select post_count from author where id = 4 lock in share mode;

