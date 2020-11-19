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

#sqldb로 sql 쿼리 활용
-- select : 가져올 칼럼 지정
-- from : 테이블 지정
-- where : 조건지정
-- 김경호의 데이터를 출력
select * from usertbl where name='김경호';

-- 출생년도가 1970년 이후 동시에 키가 182 이상인 회원을 출력
select * from usertbl where birthyear >1970 and height >=182;

-- 출생년도가 1970년 이후 동시에 키가 182 이상인 회원의 userid를 출력
select userid from usertbl where birthyear>1970 and height>=182;

-- 출생년도가 1970년 이후이거나 키가 182 이상인 회원을 출력
select * from usertbl where birtyyear>1970 or height>=182;

-- 키가 180 이사이고 183 이하인 회원의 이름을 출력
select * from usertbl where height >=180 and height <=183;
select * from usertbl where height between 180 and 183;

-- 출생지가 경남 또는 전남 또는 경북인 회원의 이름과 주소를 출력
select name, addr from usertbl where addr='경남' or addr='전남' or addr='경북';
select name, addr from usertbl where addr in('경남', '전남', '경북');

-- 텍스트 검색 키워드 like
-- 성이 '김'인 사람의 데이터를 출력
select * from usertbl where name like '김%';

-- 이름이 종신인 사람의 데이터를 출력 성은 무관
select * from usertbl where name like '_종신';

-- 키가 177이상인 고객데이터만 추출
select * from usertbl where height>=177;

-- 김경호 보다 키가 큰 사람의 데이터를 출력
-- subquery 하나의 쿼리 안에 다른 쿼리가 포함된 경우
select * from usertbl where height>(select height from usertbl where name='김경호');

-- 임재범 보다 나이가 많은 사람의 데이터를 출력
select * from usertbl where birthYear < (select birthyear from usertbl where name='임재범');

-- 김범수와 출생지역이 동일한 사람의 데이터를 출력
select * from usertbl where addr=(select addr from usertbl where name='김범수');

-- 경남에 사는 사람보다 키가 큰 사람들의 데이터를 출력
-- 서브쿼리 결과값이 복수라서 비교연산에서 오류 발생
select * from usertbl where height > (select height from usertbl where addr = '경남');
-- 오류 수정 어느 하나에 커도 좋은 경우(any), 모든 요소에 대해 커야 하는 경우(all)
select * from usertbl where height > all (select height from usertbl where addr = '경남');

-- 경남사람의 키와 동일한 키인 사람들의 데이터를 출력
select * from usertbl where height in (select height from usertbl where addr='경남');

-- 정렬 order by

-- 나이 기준으로 오름차순 정렬해서 출력
select * from usertbl order by birthyear;
select * from usertbl order by birthyear desc;

-- 키가 큰 순서대로 정렬 출력 키가 작은 순서대로 정렬 출력
select * from usertbl order by height desc;

-- 주소출력
select addr from usertbl;

-- 중복없는 값을 출력 : distinct
select distinct addr from usertbl;

-- row의 갯수를 출력 : count()
-- 중복없는 주소의 갯수를 출력
select count(distinct(addr)) from usertbl;

-- limit 숫자 : 출력 갯수를 지정
select * from usertbl limit 3;

-- 테이블 생성 create table 테이블명 (칼럼명, 칼럼데이터타입, 제약조건...);
-- 테이블 복사해서 사용 서브쿼리 활용

use sqldb;
create table buytbl2 (select * from buytbl);
select * from buytbl2;

create table buytbl3 (select userid, prodname from buytbl);
select * from buytbl3;

-- group by => 데이터가 묶여서 그룹이 생성
-- 그룹별 출력 값 => 집계함수

select userid from buytbl group by userid;
select userid, sum(amount) from buytbl group by userid;

-- user별로 총구매금액
select userid, sum(amount*price) from buytbl group by userid;
select userid, sum(amount*price) as '총구매금액' from buytbl group by userid;

-- user별 총구매금액 상위 2명의 유저아이디 출력alter
select userID , sum(amount*price) as '총구매금액' from buytbl group by userid order by 총구매금액 desc limit 2;

-- user별 평균구매 금액
select userid, avg(amount*price) '평균구매금액' from buytbl group by userid;

-- user별 평균구매 횟수
select userid, count(amount) '구매횟수' from buytbl group by userid;

-- usertbl에서 키가 가장 큰 사람과 가장 작은 사람의 이름과 키를 출력
select name, height from usertbl where height =  (select max(height) from usertbl);
select name, height from usertbl where height =  (select min(height) from usertbl);

select name, height from usertbl where height in ((select min(height) from usertbl), (select max(height) from usertbl));

select name, height from usertbl where height = (select min(height) from usertbl) or height = (select max(height) from usertbl);

-- 사용자별 총구매금액이 1000 이상인 고객의 데이터를 출력
-- group by 구문에서 조건은 wherer이 아닌 having 사용
select userid, sum(amount*price) as '총구매금액' from buytbl group by userid
having 총구매금액 >= 1000;

-- userid별 총구매 횟수가 2회 이상인 userid와 구매횟수 출력
select userid, count(amount) '총구매횟수' from buytbl group by userid having 총구매횟수 >=2;