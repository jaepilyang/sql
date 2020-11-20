
DROP DATABASE IF EXISTS sqlDB; -- 만약 sqlDB가 존재하면 우선 삭제한다.
CREATE DATABASE sqlDB;

USE sqlDB;
CREATE TABLE userTbl -- 회원 테이블
( userID   CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  name     VARCHAR(10) NOT NULL, -- 이름
  birthYear   INT NOT NULL,  -- 출생년도
  addr    CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1 CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2 CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height     SMALLINT,  -- 키
  mDate     DATE  -- 회원 가입일
);
CREATE TABLE buyTbl -- 회원 구매 테이블
(  num  INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID   CHAR(8) NOT NULL, -- 아이디(FK)
   prodName  CHAR(6) NOT NULL, --  물품명
   groupName  CHAR(4)  , -- 분류
   price      INT  NOT NULL, -- 단가
   amount     SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES userTbl(userID)
);

INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO userTbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO userTbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO userTbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO userTbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO userTbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO userTbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');
INSERT INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buyTbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);

SELECT * FROM userTbl;
SELECT * FROM buyTbl;

select * from usertbl where name='김경호';

select * from usertbl where birthyear >1970 and height >182;
select userid from usertbl where birthyear > 1970 and height >182;
select * from usertbl where birthyear >1970 or height >182;

select * from usertbl where height >180 and  height <183;
select * from usertbl where height between 180 and 183;

select name, addr from usertbl where addr='경남' or addr='전남' or addr='경북';
select name, addr from usertbl where addr in ('경남', '전남', '경북');

select * from usertbl where name like '김%';
select * from usertbl where name like '_종신';
select * from usertbl where height > 177;
select * from usertbl where height > (select height from usertbl where name='김경호');
select * from usertbl where birthyear < (select birthYear from usertbl where name='임재범');
select * from usertbl where addr = (select addr from usertbl where name='조용필');
select * from usertbl where height > all (select height from usertbl where addr ='경남');
select * from usertbl where height in (select height from usertbl where addr = '경남');

select * from usertbl order by birthyear desc;
select * from usertbl order by height desc;
select addr from usertbl;
select distinct addr from usertbl;
select count(distinct(addr)) from usertbl;

select * from usertbl limit 3;

show tables;
create table buytbl2(select * from buytbl);
select * from buytbl2;
create table buytbl3(select userid, prodName from buytbl);
select * from buytbl3;

select userid from buytbl group by userid;
select userid, sum(amount) from buytbl group by userid;

select userid, sum(amount*price) from buytbl group by userid;
select userid, sum(amount*price) as '총구매금액' from buytbl group by userid;

select userid, sum(amount*price) as '총구매금액' from buytbl group by userid order by 총구매금액 desc limit 2;

select userid, avg(amount*price) as '평균구매금액' from buytbl group by userid;

select userID, avg(amount) from buytbl group by userid;

select * from buytbl;

select name, height from usertbl where height in
((select max(height) from usertbl), (select min(height) from usertbl));

select * from buytbl group by userid having (price*amount) >= 1000;

select userid, sum(amount*price) as '총구매금액' from buytbl group by userid
having 총구매금액 >= 1000;

select userid, count(amount) as '총구매횟수' from buytbl group by userid having 총구매횟수 >= 2;

show databases;
use sqldb;

show tables;

#auto_increment : 값을 입력하지 않고 null을 입력하면 자동으로 순서값을 입력

#create table 테이블명(칼럼명 데이터타입 제약조건, ...)
create table testtbl2(
	id int auto_increment primary key, #프라이머리키는 이 칼럼이 식별자 역할을 한다.
    username char(7),
    age int
    
);

show tables;

#insert into 테이블명 values(값1, 값2, 값3)

insert into testtbl2 values (null, '지민', 25);
insert into testtbl2 values (null, '유나', 27);
insert into testtbl2 values (null, '유경', 35);

select * from testtbl2;

-- 테이블의 값을 복사해서 입력, 수정, 삭제
create table testtbl4 (id int, fname varchar(50), lname varchar(50));

use sqldb;
insert into testtbl4 select emp_no, first_name, last_name from employees.employees; #외부 디비 호출법

select * from testtbl4;

-- 테이블의 값을 수정 : update
select * from testtbl4 where fname='Aamer';
update testtbl4 set lname='없음' where fname='Aamer';
select * from testtbl4 where fname='Aamer';

-- buytbl에서 제품을 모두 20% 상승적용
select * from buytbl;
update buytbl set price = (price*1.2) where prodname = '운동화';

-- 데이터 삭제 : delete(데이터 지우기) drop(객체를 제거)
-- fname이 'Aamer'인 데이터를 10개만 지우기
select * from testtbl4 where fname='Aamer';

delete from testtbl4 where fname='Aamer' limit 10;

delete from testtbl4 where fname='Aamer';






