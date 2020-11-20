-- cast : 데이터 타입변환
select cast('2020-10-19 12:35:29:123' as date) as 'Date';
select cast('2020-10-19 12:35:29:123' as time) as 'Date';
select cast('2020-10-19 12:35:29:123' as datetime) as 'Date';

use sqldb;
select * from buytbl;
select num, concat(cast(price as char(10)), 'x', cast(amount as char(10)),
'=') as '가격X구매량', price*amount as '총구매금액' from buytbl;

-- concat : 문자열을 이어준다.
select concat('100', '200');

-- concat_ws : 문자열을 이어주는데 구분자를 넣어서 이어주는 함수
select concat_ws('/', '2020', '01', '01') as '날짜';

-- ifnull(요소1, 요소2) : 요소1이 null이면 요소2를 출력, 요소1이 null이 아니면 요소1을 출력
select ifnull(null, '요소2');
select ifnull('요소1', '요소2');

-- insert('문자열1', index, length, '문자열2') : 문자열1의 인덱스 위치에 문자열2를 삽입
select insert('abcdefghi', 3, 4, '@@@@');#세번째 자리에서부터 네자리차지하게 삽입
select insert('abcdefghi', 3, 2, '@@@@');

-- left('문자열', num) : 문자열 왼쪽에서 num만큼 반환
-- right('문자열', num) : 문자열 오른쪽에서 num만큼 반환
select left('abcdefghi', 3);
select right('abcdefghi', 3);

-- repeat('문자열', num); 문자열을 num만큼 반복
select repeat('abd', 10);

-- lower() : 소문자전환, upper() : 대문자전환
select lower('abcdEFG');
select upper('abcdEFG');

-- lpad('문자열1', num, '문자열2') : 문자열1을 num만큼 자리수를 늘리고, 문자열2로 채운다.
-- python에는 '문자열'.zfill()이라는 애가 비슷
select lpad('abc', 5, '@');
select lpad('abc', 7, ' ');
select rpad('abc', 7, '-');

-- ltrim, rtrim : 왼쪽, 오른쪽 공백 제거 => 파이썬: rstrip(), lstrip(), strip()
select ltrim('            abc');
select rtrim('abc            ');

-- replace('문자열', '문자열1', '문자열2') 문자열에서 문자열1을 문자열2로 교체
-- python : '문자열'.replace('문자열1', '문자열2')
select replace('hello mysql!!', 'mysql', 'python');

-- space(num) : num만큼의 space를 만든다.
select concat('hello', space(10), 'python');

-- abs() 절대값 반환
select abs(-20);

-- ceiling():올림함수, floor():내림, round():반올림
select ceiling(4.7);
select floor(4.7);
select round(4.7);
select round(4.3);

select mod(157,2);
select mod(157, 10);

select pow(2,3);
select sqrt(9);

-- length(): byte크기 리턴
select length('abc'); # 영문 알파벳은 character당 1byte
select length('가'); # 한글 한문자당 3바이트 지정

-- mysql datatype 유형

# 문자형
-- char(num) : 고정길이 문자열 타입, num - 최대 글자수, 1~255,
-- 예) char(10) - 실제 입력되는 글자수와 무관하게 10글자 만큼 자리 차지
-- 알파벳 - 1바이트
-- 한글 - 3바이트

-- varchar(num) : 가변길이 문자열 타입, num - 최대 글자수, 1~65535
-- 예) varchar(10) - 실제 텍스트는 2글자만 입력시 자동으로 2글자에 맞춰서 사이즈를 축소

-- TEXT : 최대 65535의 텍스트를 다믕ㄹ 수 있다.
-- longtext : 최대 42994967295(4M) 텍스트를 담을 수 있음

# 숫자형
-- int : -2147483648 ~ 21474836474
-- float : -3.102823466e+38 ~ 1.175494351e-38

# 날짜형
-- date : yyyy-mm-dd('1001-01-01' ~ '9999-12-31')
-- time : hh:mm:ss ('-838:59:59' ~ '838:59:59')
-- datetime : yyyy-mm-dd hh:mm:ss
-- year[(2|4)] : 2인 경우 70~69, 4인 경우 1970~2069

use sqldb;
create table maxtable (col1 longtext, col2 longtext);

insert into maxtable values (repeat('a', 100000), repeat('가', 100000));
select * from maxtable;

insert into maxtable values (repeat('a', 10000000), repeat('가', 10000000));

# c\programdata\mysql\mysql server 5.7\my.ini
# max_allowed_packet = 100M

# 테이블 내용을 파일로 내보내고 파일의 내용을 테이블로 불러들임
-- 사용할 폴더 지정 c\temp

# c\programdata\mysql\mysql server 5.7\my.ini
# secure-file_priv = c\temp

use sqldb;

-- 테이블의 내용을 파일로 내보내기
select * into outfile 'c:/temp/usertbl.txt' from usertbl;

-- 파일의 내용을 테이블에 불러오기
create table membertbl like usertbl; # usertbl의 구조를 복사
load data local infile 'c:/temp/usertbl.txt' into table membertbl;

select * from membertbl;

### join
select * from buytbl;
select * from usertbl;

-- inner join
-- select * from a_table inner join b_table on a_table.col = b_table.col

select * from buytbl inner join usertbl on buytbl.userid = usertbl.userid;

select * from buytbl b inner join usertbl u
on b.userid = u.userid;

select * from buytbl, usertbl where buytbl.userid = usertbl.userid;
select * from buytbl b, usertbl u where b.userid = u.userid;

-- 조용필이 구매한 제품의 이름 주소를 출력
select prodname, addr from buytbl b inner join usertbl u on b.userid=u.userid
where name='조용필';

-- 모니터를 구매한 사람의 이름
select name from buytbl b inner join usertbl u on b.userid=u.userid 
where prodname='모니터';

-- 전화번호가 없는 고객의 이름과 주소를 구매한 제품을 출력
select name, addr, prodName from buytbl b inner join usertbl u
on b.userid=u.userid where mobile1 is null;

-- 총구매금액이 가장 큰 고객의 이름과 주소
select name, addr, price, amount, price*amount '총구매금액' 
from buytbl b inner join usertbl u on b.userid=u.userid
order by 총구매금액 desc limit 1;

-- left join
select * from buytbl b left join usertbl u
on b.userid = u.userid;

select * from buytbl b right join usertbl u
on b.userid = u.userid;

create table stdtbl(
	stdname varchar(10) not null primary key,
    addr char(4) not null);
create table clubtbl(
	clubname varchar(10) not null primary key,
    roomno char(4) not null);
create table stdclubtbl(
	num int auto_increment not null primary key,
    stdname varchar(10) not null,
    clubname varchar(10) not null);

insert into stdtbl values('김병수', '경남'), ('성시경','서울'), ('조용필', '경기'),
('은지원', '경북'), ('바비킴', '서울');
select * from stdtbl;

insert into clubtbl values('수영', '101호'), ('바둑', '102호'), ('축구', '103호'),
('봉사', '104호');
select * from clubtbl;

insert into stdclubtbl values (null, '김범수', '바둑'), (null, '김범수', '축구'),
(null, '조용필', '축구'), (null, '은지원', '축구'), (null, '은지원', '봉사'),
(null, '바비킴', '봉사');
select * from stdclubtbl;

select * from stdtbl;
select * from clubtbl;
select * from stdclubtbl;

select * from stdtbl inner join stdclubtbl on stdtbl.stdname = stdclubtbl.stdname
					inner join clubtbl on clubtbl.clubname = stdclubtbl.clubname;

select stdtbl.stdname, addr, num, stdclubtbl.clubname, roomno from stdtbl 
	inner join stdclubtbl on stdtbl.stdname = stdclubtbl.stdname
	inner join clubtbl on clubtbl.clubname = stdclubtbl.clubname;
    
select s.stdname, addr, num, sc.clubname, roomno from stdtbl s 
	inner join stdclubtbl sc on s.stdname = sc.stdname
	inner join clubtbl c on c.clubname = sc.clubname;
    
select * from stdtbl s, stdclubtbl sc, clubtbl c
where s.stdname = sc.stdname and sc.clubname = c.clubname;
select s.stdname, addr, num, sc.clubname, roomno from stdtbl s, stdclubtbl sc, clubtbl c
where s.stdname = sc.stdname and sc.clubname = c.clubname;

-- 축구부에 가입한 학생의 주소를 출력
select s.stdname, addr, num, sc.clubname, roomno 
from stdtbl s, stdclubtbl sc, clubtbl c
where s.stdname = sc.stdname and sc.clubname = c.clubname
and c.clubname='축구';

### if구문/ case when구문

drop procedure if exists ifporc3; #프로시져는 함수라고 생각하면 됨 => call procedure이름();
delimiter $$ # 쿼리문 끝에 붙이는 ';'를 '$$'으로 바꾸겠다.
create procedure ifproc3() # 프로시져 생성
begin
	declare point int; # declare를 통해 변수 선언
	declare credit char(1);
	set point = 77; # 변수에 값을 할당

	if point >=90 then
		set credit = 'A';
	elseif point >= 80 then
		set credit = 'B';
	elseif point >= 70 then
		set credit = 'C';
	elseif point >= 60 then
		set credit = 'D';
	else
		set credit = 'F';
	end if;
	select concat('취득학점==>', point), concat('학점==>', credit);
end $$

delimiter ;

call ifproc3();

drop procedure if exists ifporc4; #프로시져는 함수라고 생각하면 됨 => call procedure이름();
delimiter $$ # 쿼리문 끝에 붙이는 ';'를 '$$'으로 바꾸겠다.
create procedure ifproc4() # 프로시져 생성
begin
	declare point int; # declare를 통해 변수 선언
	declare credit char(1);
	set point = 77; # 변수에 값을 할당

	case
		when point >=90 then
			set credit = 'A';
		when point >= 80 then
			set credit = 'B';
		when point >= 70 then
			set credit = 'C';
		when point >= 60 then
			set credit = 'D';
		else
			set credit = 'F';
	end case;
	select concat('취득학점==>', point), concat('학점==>', credit);
end $$

delimiter ;

call ifproc4();


select u.userid, u.name, sum(price*amount) as '총구매내역',
	case
		when (sum(price*amount) >= 1500) then '최우수고객'
        when (sum(price*amount) >= 1000) then '우수고객'
        when (sum(price*amount) >= 1) then '일반고객'
		else '유령고객'
	end as '고객등급'

from buytbl b right outer join usertbl u on b.userid


