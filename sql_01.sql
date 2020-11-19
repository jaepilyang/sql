#use new_schema;
-- 한줄 주석
# 이것도 주석
/*
이거슨 여러줄 주석
*/
-- select 컬럼명 from 테이블명;
#select 칼럼1, 칼럼2 from 테이블명;
#select 칼럼2 from 테이블명 where 조건;
#select * from 테이블명;
#show tables; 테이블 목록을 확인하는 명령
#show databases; 테이블 목록을 확인하는 명령

#shopdb의 product_table 모든 칼럼을 가져와라
#show tables;membertblmembertbl

#select * from product_table;
#select * from user_table;

#ctrl+shift+enter => 전체실행 또는 블록실행
#crtl+enter => 지정한 라인 쿼리만 실행

#1. 디비 생성
#2. 테이블생성
#3. 테이블 값 입력

#drop database if exists sqldb;
create database sqldb;

use sqldb;

#테이블생성
#create table 테이블명(칼럼, 데이터타입, 제약조건)
create table usertbl(
	userid char(8) not null primary key, 
    name varchar(10) not null,
    birthyear int not null,
    addr char(2) not null,
    mobile1 char(3),
    mobile2 char(8),
    height smallint,
    mdate date
);

#값을 입력
#=> insert into 테이블명 values(값1, 값2, 값3...)
insert into usertbl values('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
insert into usertbl values('KBS', '김범수', 1971, '경남', '011', '2222222', 173, '2012-4-4');
insert into usertbl values('KKH', '김경호', 1971, '전남', '011', '3333333', 177, '2008-7-7');

#usertbl의 모든 데이터를 출력
select * from usertbl;

