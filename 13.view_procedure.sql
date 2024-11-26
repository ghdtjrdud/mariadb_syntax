-- view : 실제 데이터를 참조만 하는 가상의 테이블
-- 사용목적
-- 1. 복잡한 쿼리 대신한다.
-- 2. 테이블의 컬럼까지 권한  분리

-- view 생성
create view author_for_marketing as select name, email from author;

select * from author_for_marketing;

-- view 권한 부여
grant select on board.author_for_marketing to '계정명'@'localhost';

-- view 삭제
drop view author_for_marketing;

-- 프로시저 생성
DELIMITER //
create procedure hello_procedure()
begin
    select 'hello world';
end
//DELIMITER ;

-- 프로시저 호출
call hello_procedure();

-- 프로시저 삭제
drop procedure hello_procedure;

-- 게시글 목록조회 프로시저 생성
DELIMITER //
create procedure 게시글목록조회()
begin
    select * from post;
end
//DELIMITER ;

call 게시글목록조회();

-- 게시글 단건조회
DELIMITER //
create procedure 게시글id단건조회(in postid bigint)
begin
    select * from post
    where id = postid;
end
//DELIMITER ;

call 게시글id단건조회(1);

-- 게시글목록조회 by email (본인이 쓴 글 목록조회, 본인의 eamil을 입력값으로 조회) 목록조회의 결과는 *
DELIMITER //
create procedure 게시글목록조회byemail(in inputEmail varchar(255))
begin
    select p.id, p.title, p.contents
    from post p inner join author_post ap
    on p.id = ap.post_id inner join author a
    on ap.author_id = a.id
    where email = inputEmail;
end
//DELIMITER ;

-- 글쓰기
-- post 테이블에 insert
-- author_post 테이블 insert : author_id, post_id
DELIMITER //
create procedure 글쓰기(in inputTitle varchar(255), in inputContents varchar(255), in inputEmail varchar(255)
begin
    declare authorId bigint;
    declare postId bigint;
    insert into post(title, contents) valuse(inputTitle, inputContents);
    select id into postId from post order by id desc limit 1;
    select id into authorId from author where email = inputEmail;
    insert into author_post(author_id, post_id) values(authorId,postId);
end
//DELIMITER ;

-- 글삭제(글id 와 본인 email 받아서 삭제)
DELIMITER //
create procedure 글삭제(in inputPostId bigint, in inputEmail varchar(255))
begin
    declare authorPostCount bigint;
    declare authorId bigint;
    select count(*) into authorPostCount from author_post where post_id = inputPostId;
    select id into authorId from author where email = inputEmail;
    if authorPostCount >= 2 then
    -- elseif 까지 사용가능
        delete from author_post where post_id = inputPostId and author_id = authorId;
    else 
        delete from author_post where post_id = inputPostId and author_id = authorId;
        delete from post where id = inputPostId;
    end if;    
end
//DELIMITER ;

-- 반복문을 통해 post대량생성 : title, 글쓴이 email
DELIMITER //
create procedure 글도배(in count int, in inputEmail varchar(255))
begin
    declare authorId bigint;
    declare postId bigint;
    declare countValue int default 0;
    while countValue < count        
        insert into post(title) valuse("안녕하세요");
        select id into postId from post order by id desc limit 1;
        select id into authorId from author where email = inputEmail;
        insert into author_post(author_id, post_id) values(authorId,postId);
        set countValue += 1;
    end while        
end
//DELIMITER ;