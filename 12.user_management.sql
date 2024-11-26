-- 사용자 관리
-- 사용자 목록조회
select * from mysql.user;

-- 사용자생성
create user '계정명'@'localhost' identified by '4321';

-- 원격 접속 가능한
create user '계정명'@'localhost%' identified by '4321';

-- 사용자에게 select 권한 부여
grant select on board.author to '계정명'@'localhost';

-- 사용자 권한 회수
revoke select on board.author from '계정명'@'localhost';

-- 계정 삭제
drop user '계정명'@'localhost';