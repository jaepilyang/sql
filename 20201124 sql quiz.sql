create table purchase_tran (

id int,

purchase_amt int,

purchase_cnt int,

last_amt int,

last_cnt int);

 

insert into purchase_tran values 
(145, 2000000, 12, 1231000, 21),
(455, 1273100, 1, 2237230, 22),
(463, 111463, 3, 214047, 1),
(324, 154769, 3, 7474663, 13),
(568, 25786652, 47, 1000047, 3),
(662, 106868, 1, 277763, 1),
(871, 9694470, 123, 798874, 2),
(460, 65650000, 1200, 6557741, 320),
(277, 5766300, 470, 57663000, 444),
(309, 5579800, 415, 2333000, 135);
 

 
/*
1. 올해 구매금액이 1백만원 이상인 고객의 고객번호와 올해 구매금액을 추출하시오.
2. 작년 구매금액이 1백만원 이상 5천만원 이하인 고객의 고객 번호와 작년 구매금액을 출력하시오.
3. 올해 구입건수가 작년 구입건수 보다 많은 고객들의 고객번호, 올해구입건수, 작년구입건수를 출력하고 올래구입건수를 기준으로 오름차순 정렬하시오.
4. 올해 건당 구입금액을 구하고 이름을 평균구매금액으로 출력하시오.
5. 올해와 작년의 구매건수 당 평균 구매금액을 구하시오
*/

select * from purchase_tran where purchase_amt >= 1000000;

select * from purchase_tran where last_amt between 1000000 and 50000000;

select * from purchase_tran where last_cnt < purchase_cnt;

select (purchase_amt/purchase_cnt) '평균구매금액' from purchase_tran;

select (purchase_amt/purchase_cnt) '평균구매금액' from purchase_tran;


create table ins_info (
id int,
cnrt_no int,
cnrt_dt date,
cnrt_cd int,
prdt_nm char(15),
cncl_dt date,
cnrt_amt int);

insert ignore into ins_info values
(224, 2533274, '2013-07-01', 1,'다이렉트자동차보험', null, 1000000),
(224, 6111075, '2012-08-07', 2, '5년만기저축보험', '2014-01-21', 300000),
(684, 4447330, '2014-06-12', 1, '다이렉트자동차보험', null, 100000),
(233, 4932004, '2011-11-23', 3, '자동차보험', null, 200000),
(762, 9633703, '2013-05-31', 2, '10년만기저축보험', '2013-11-03', 700000),
(789, 1378934,    '2013-01-12', 2, '3년만기저축보험', null, 5000001),
(183, 3701447, '2010-05-05', 1, '다이렉트자동차보험', null, 900000),
(183, 6678966, '2011-12-08', 3, '10년만기저축보험', null, 10000000),
(831, 8463112, '2013-04-16', 1, '다이렉트자동차보험', '2013-08-11', 1000000);

select * from ins_info;

/*
 
1. 가입금액이 1백만원 이상인 고객들의 고객번호, 계약번호, 가입금액을 추출하시오.
2. 다이렉트자동차보험 가입 고객들의 고객번호, 상품명, 계약일을 계약일 오름차순으로 출력하시오
3. 상품계약일이 2013년 4월 16일 이후인 고객들의 고객번호, 계약일, 상품명을 고객번호 오름차순으로 출력하시오.
4. 보험 계약을 해지한 고객의 고객번호를 출력하시오.
5. 계약 종류 별 평균가입금액과 가입수를 추출하시오.
6. 계약이 해지된 계약의 종류와 수를 추출하시오
7. 2013년에 가입한 계약의 수와 평균 가입금액을 추출하시오
8. 살아있는 계약의 고객번호, 상품명, 가입금액을 추출하시오*/

select * from ins_info where cnrt_amt >=1000000;

select * from ins_info order by cnrt_dt;

select * from ins_info where cnrt_dt > '2013-04-16';

select * from ins_info where cncl_dt is not null;

select count(cnrt_no), avg(cnrt_amt), year(cnrt_dt) cnrt_year 
from ins_info where cnrt_year='2013';

select cnrt_no, prdt_nm, cnrt_amt from ins_info where cncl_dt is null;

CREATE TABLE CASA_201312
(
CUST_ID CHAR(13) PRIMARY KEY NOT NULL,
CUST_SEG CHAR(10) NOT NULL,
BALANCE_201311 DECIMAL(15,0),
BALANCE_201312 DECIMAL(15,0)
);


INSERT INTO CASA_201312 VALUES ('54560', 'SILVER', 1000000, 2000000);
INSERT INTO CASA_201312 VALUES ('68477', 'GOLD', 112000, 3500);
INSERT INTO CASA_201312 VALUES ('96147', 'SILVER', 300000, 1000010);
INSERT INTO CASA_201312 VALUES ('32134', 'GOLD', 2354000, 3200000);
INSERT INTO CASA_201312 VALUES ('12478', 'DIAMOND', 6015000, 5800000);
INSERT INTO CASA_201312 VALUES ('54789', 'SILVER', 200000, 300000);
INSERT INTO CASA_201312 VALUES ('34181', 'GOLD', 4200000, 4100000);
INSERT INTO CASA_201312 VALUES ('23458', 'DIAMOND', 5000000, 6200000);
INSERT INTO CASA_201312 VALUES ('12344', 'SILVER', 210000, 200000);

select * from casa_201312;

 

/*
11월과 12월의 고객별 수신잔고 평균
1. 11월 캠페인결과 잔고증가율이 10%이상인 고객은 1, 아니면 0으로 
    캠페인 성공 여부를 새로운 칼럼으로 표시하시오
2. 캠페인 성공률을 계산하시오
3. 캠페인의 결과로 증가된 수신고 순 증가분을 구하시오
4. 캠페인 결과 수신고 증가율을 구하시오 

*/