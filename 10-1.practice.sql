-- - (실습)주문(order) ERD 설계 및 DB 구축
--     - 서비스 요구사항
--         - 회원가입
--             - 판매자, 일반사용자 구분 필요
--         - 상품 등록
--             - 재고 컬럼은 필수, 판매자 정보 기록 필요
--         - 주문하기
--             - 한번에 여러상품을 여러개 주문할수 있는 일반적인 주문서비스
--         - 그외
--             - 상품정보 조회, 주문상세조회 등
--     - 주의사항
--         - user테이블(사용자), order테이블(주문), product테이블(상품) 등 컬럼, 테이블 설계 추가 자유
--         - 실제 웹서비스를 제공한다 가정하고 추가, 조회 값에 적절한 값 세팅 필요
--         - 각 서비스 단계별로 테스트 쿼리 생성 필요

create database orders_system;
use orders_system;

create table user(
    id bigint primary key auto_increment,
    user_id varchar(255) not null,
    password varchar(255) not null,
    name varchar(255) not null,
    birth datetime,
    created_time datetime not null default current_timestamp
);

insert into user(user_id, password, name) values("1", "1234", "일");
insert into user(user_id, password, name) values("2", "1234", "이");
insert into user(user_id, password, name) values("3", "1234", "삼");
insert into user(user_id, password, name) values("4", "1234", "사");
insert into user(user_id, password, name) values("5", "1234", "오");

create table seller(
    id bigint primary key auto_increment,
    seller_id varchar(255) not null,
    password varchar(255) not null,
    name varchar(255) not null,
    birth datetime,
    created_time datetime not null default current_timestamp
);

insert into seller(user_id, password, name) values("6", "5678", "육");
insert into seller(user_id, password, name) values("7", "5678", "칠");
insert into seller(user_id, password, name) values("8", "5678", "팔");
insert into seller(user_id, password, name) values("9", "5678", "구");
insert into seller(user_id, password, name) values("10", "5678", "십");

create table user_address(
    id bigint primary key auto_increment,
    user_id bigint not null,
    city varchar(255) not null,
    village varchar(255) not null,
    foreign key(user_id) references user(id)
);

insert into user_address(user_id, city, village) values("5", "대한민국", "서울");
insert into user_address(user_id, city, village) values("4", "미국", "뉴욕");
insert into user_address(user_id, city, village) values("3", "일본", "도쿄");
insert into user_address(user_id, city, village) values("2", "중국", "북경");
insert into user_address(user_id, city, village) values("1", "프랑스", "파리");

create table orders(
    id bigint primary key auto_increment,
    user_id bigint not null,
    orders_time datetime not null default current_timestamp,
    foreign key(user_id) references user(id)
);

insert into orders(user_id) values("5");
insert into orders(user_id) values("4");
insert into orders(user_id) values("3");
insert into orders(user_id) values("2");
insert into orders(user_id) values("1");

create table product(
    id bigint primary key auto_increment,
    seller_id bigint not null,
    name varchar(255) not null,
    price bigint not null,
    created_time datetime not null default current_timestamp,
    foreign key(seller_id) references seller(id)
);

alter table product add column price bigint not null;

insert into product(seller_id, name, price) values("5", "풍선", 1000);
insert into product(seller_id, name, price) values("4", "과자", 2000);
insert into product(seller_id, name, price) values("3", "텀블러", 3000);
insert into product(seller_id, name, price) values("2", "핸드폰", 4000);
insert into product(seller_id, name, price) values("1", "노트북", 5000);
insert into product(seller_id, name, price) values("1", "아메리카노", 7000);
insert into product(seller_id, name, price) values("2", "카페라떼", 3500);
insert into product(seller_id, name, price) values("3", "메이플", 50000);
insert into product(seller_id, name, price) values("4", "초콜렛", 500);
insert into product(seller_id, name, price) values("5", "시럽", 1500);
insert into product(seller_id, name, price) values("4", "무지개", 500000);
insert into product(seller_id, name, price) values("3", "옷", 75000);
insert into product(seller_id, name, price) values("1", "아이폰", 100);
insert into product(seller_id, name, price) values("1", "마우스", 5000);

create table product_stock(
    id bigint primary key auto_increment,
    product_id bigint not null,
    count bigint not null,
    foreign key(product_id) references product(id)    
);

insert into product_stock(product_id, count) values(2, 50);
insert into product_stock(product_id, count) values(3, 40);
insert into product_stock(product_id, count) values(4, 30);
insert into product_stock(product_id, count) values(5, 20);
insert into product_stock(product_id, count) values(6, 10);

create table orders_detail(
    id bigint primary key auto_increment,
    orders_id bigint not null,
    product_id bigint not null,
    amount bigint not null,
    foreign key(orders_id) references orders(id),
    foreign key(product_id) references product(id)       
);

insert into orders_detail(orders_id, product_id, amount) values(1, 2, 1);
update product_stock set count= (count-1) where product_id = 2;

insert into orders_detail(orders_id, product_id, amount) values(1, 3, 2);
update product_stock set count= (count-2) where product_id = 3;

insert into orders_detail(orders_id, product_id, amount) values(1, 4, 3);
update product_stock set count= (count-3) where product_id = 4;

insert into orders_detail(orders_id, product_id, amount) values(2, 2, 1);
update product_stock set count= (count-1) where product_id = 2;

insert into orders_detail(orders_id, product_id, amount) values(2, 6, 4);
update product_stock set count= (count-4) where product_id = 6;

insert into orders_detail(orders_id, product_id, amount) values(3, 5, 7);
update product_stock set count= (count-7) where product_id = 5;

insert into orders_detail(orders_id, product_id, amount) values(4, 5, 16);
update product_stock set count= (count-16) where product_id = 5;

insert into orders_detail(orders_id, product_id, amount) values(5, 6, 18);
update product_stock set count= (count-18) where product_id = 6;

-- 1번 유저가 주문한 상품들? 노트북
select id from orders where user_id = 1;  -- 주문번호 5 번
select product_id from orders_detail where orders_id = 5; -- 상품번호 6번
select name from product where id = 6; -- 노트북

select p.name from orders o inner join orders_detail od on o.id=od.orders_id 
inner join product p on od.product_id=p.id where o.user_id=1;

select p.name from orders o inner join orders_detail od on o.id=od.orders_id 
inner join product p on od.product_id=p.id where o.user_id=5;

-- 돈을 가장 많이 쓴 유저
