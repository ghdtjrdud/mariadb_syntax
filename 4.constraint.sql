-- not null 제약조건 추가
alter table author modify colum email varchar(255) not null;

-- uique 제약조건 추가
alter table author modify colum email varchar(255) uique;
alter table author modify colum email varchar(255) not null unique;

-- foreign key 제약조건 삭제 및 추가
-- 제약조건의 이름 확인 후 삭제 및 추가 가능
-- 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'post';

-- 제약조건 삭제
alter table post drop foreign key post_ibfk_1;

-- 제약조건 추가(추가할 때는 이름을 명시해줘야함. 자동으로 안됨)
alter table post add constraint post_author_fk foreign key(author_id) references author(id);

-- delete , update 관련 제약조건 테스트
-- on delete cascade 테스트
-- 제약조건 삭제
alter table post drop constraint post_author_fk;

--  on delete cascade 추가, set null 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id)
on delete cascade;

alter table post add constraint post_author_fk foreign key(author_id) references author(id)
on delete on update set null;

-- ddfault 옵션
alter table author modify column name varchar(255) default 'anonymous';

-- auto_increment
alter table author modify column id bigint auto_increment;
alter table post modify column id bigint auto_increment;