-- 이것이 주석!
use shopdb;
show tables;
select * from usertbl;
select * from buytbl;
desc usertbl;
desc buytbl;

-- 01 select
select * from usertbl;
select userid, birthyear from usertbl;
select userid as '아이디', birthyear as '생년월일' from usertbl;
select
userid as '아이디', birthyear as '생년월일', concat(mobile1,'-', mobile2) as '연락처'
from usertbl;

-- 02 select where(조건절)
-- 동등 비교 연산자(=)
select * from usertbl where name='김경호'; 
select * from usertbl where userId='LSG';
-- 대소 비교 연산자(<, <=, >, >=)
select * from usertbl where birthyear >= 1960;
select * from usertbl where height <= 170;

-- 03 select where(조건절 + 논리 연산자)
-- and연산자(true and true)
select * from usertbl where birthyear >= 1970 and height >= 180;
-- or연산자(true or false, false or true, true or true) 
select * from usertbl where birthyear >= 1970 or height >= 180;

select * from usertbl where height>=170 and height<=180;
select * from usertbl where height between 170 and 180;

-- in(포함문자열 - 완성된 문자열), like(포함문자열 - 미완성 문자열 필터링 가능)
select * from usertbl where addr in ('서울','경남');
select * from usertbl where addr='경남' or addr='서울';
select * from usertbl where name='김범수';
select * from usertbl where name like '김%'; -- 길이제한 없는 모든 문자
select * from usertbl where name like '%수'; -- 길이제한 없는 모든 문자
select * from usertbl where name like '김_'; -- _ 개수만큼의 길이제한이 있는 모든 문자
select * from usertbl where name like '%경%';

-- problem
-- 01
select * from buytbl where amount >= 5;
-- 02
select userid, prodname from buytbl where price between 50 and 500;
-- 03
select * from buytbl where amount>=10 or price>=100;
-- 04
select * from buytbl where userid = 'K%';
-- 05
select * from buytbl where groupname in ('서적', '전자');
-- 06
select * from buytbl where prodname='책' or userid='%W';
-- 07
select * from buytbl where groupname!='null';

-- 04 select 조건절 - 서브쿼리
select height from usertbl where name='김경호'; -- 김경호의 키
-- 김경호보다 큰 키를 가지는 모든 열의 값
select * from usertbl where height>(select height from usertbl where name='김경호');
-- 성시경보다 나이가 많은 모든 열의 값 출력
select * from usertbl where birthyear < (select birthyear from usertbl where name='성시경');
-- 지역이 '경남'인 height보다 큰 행 출력
-- all(모든 조건을 만족하는)
select * from usertbl where height > all(select height from usertbl where addr='경남');
-- any(어느 조건이든 하나 이상 만족)
select * from usertbl where height > any(select height from usertbl where addr='경남');

-- 문제 buytbl
-- 1
select * from buytbl where price > (select price from buytbl where amount=10);
-- 2
select * from buytbl where amount > any(select amount from buytbl where userid='K%');
-- 3
select * from buytbl where price > all(select price from buytbl where amount=5);

-- 05 select order by
use shopdb;
select * from usertbl order by mDate asc; -- 오름차순
select * from usertbl order by mDate desc; -- 내림차순
select * from usertbl where birthyear >= 1970 order by mDate;
select * from usertbl order by height, name; -- height값이 같은 경우에 name 값 기준으로 재정렬

-- 06 distinct
select distinct addr from usertbl; -- 같은 값 생략

-- 07 limit
select * from usertbl limit 3; -- 0번 index부터 3개 출력
select * from usertbl limit 2, 3; -- index번호에서 3개 출력

-- 08 복사(테이블 복사)
-- 08-01 구조+값 복사()
create table tbl_buy_copy(select * from buytbl);
select * from tbl_buy_copy;
desc tbl_buy_copy;
desc buytbl;

create table tbl_buy_copy2(select userid,prodname, amount from buytbl);
desc tbl_buy_copy2;

-- 08-02 구조 복사(값 X, PK O, FK X)
create table tbl_buy_copy3 like buytbl;
select * from tbl_buy_copy3;
desc tbl_buy_copy3;

-- 08-03 데이터만 복사
insert into tbl_buy_copy3 select * from buytbl where amount >= 3;
select * from tbl_buy_copy3;

-- 문제
-- 01
select * from usertbl order by userid asc;
-- 02
select * from buytbl order by price desc;
-- 03
select * from buytbl order by amount asc, prodname desc;
-- 04
select distinct prodname from buytbl order by prodname asc;
-- 05
select * from usertbl where (select distinct userid from usertbl);
-- 06
select * from buytbl where amount>=3 order by prodname desc;
-- 07
create table CUsertbl (select addr from usertbl where addr in ('서울', '경기'));

-- 09 group by

-- Userid별 amount 총합
select userid, sum(amount) as '총 구매 수량' from buytbl group by userid;
-- userid별 amout*price 의 총합(sum)
select userid, sum(amount*price) as '구매 총액' from buytbl group by userid;
-- average 함수
select userid, avg(amount) as '구매 평균 수량' from buytbl group by userid;
select userid, truncate(avg(amount*price),2) as '구매 평균액' from buytbl group by userid;
-- max(), min()
select max(height) from usertbl;
select min(height) from usertbl;

-- 가장 큰 키를 가지는 user의 모든 열의 값 확인
select * from usertbl where height=(select max(height) from usertbl);
-- 가장 작은 키를 가지는 user의 모든 열의 값 확인
select * from usertbl where height=(select min(height) from usertbl);
-- 가장 큰 키와 가장 작은 키의 값만 확인
select * from usertbl where height = (select max(height) from usertbl) or height = (select min(height) from usertbl);
select * from usertbl where height in ((select max(height) from usertbl),(select min(height) from usertbl));

-- 문제
use shopdb;
-- 01
select userid, sum(amount) from buytbl group by userid;
-- 02
select avg(height) from usertbl group by (select height from usertbl);
-- 03
select userid, max(amount) as '최대 구매량', min(amount) as '최소 구매량' from usertbl group by userid;
-- 04
use classicmodels;
	-- 01
select city, avg(creditLimit) from customers group by city;
	-- 02
select ordernumber, sum(quantityOrdered) from orderdetails group by ordernumber;
	-- 03
select productvendor, sum(quantityInStock) from products group by productvendor;

-- 10 group by + having
use shopdb;
select userid, sum(amount) as '총 구매 수량' from buytbl group by userid having sum(amount)>5; -- O
select userid, sum(amount) as '총 구매 수량' from buytbl group by userid having '총 구매 수량'>5; -- X

select userid, truncate(avg(amount*price),2) as '구매 평균 금액'
from buytbl
group by userid
having truncate(avg(amount*price),2)>50;

-- 11 select + group by + rollup
select * from buytbl;
select num,groupname,sum(price*amount) from buytbl group by groupname,num with rollup;
select groupname,sum(price*amount) from buytbl group by groupname with rollup;
select userid, addr, avg(height) from usertbl group by addr, userid with rollup;

-- 문제
-- 01
select userid, prodname, sum(price*amount) from buytbl group by prodname, userid;
-- 02
select userid, prodname, sum(price*amount) from buytbl group by prodname, userid having sum(price*amount)>=1000;
-- 03
select userid, prodname, price from buytbl where price=(select max(price) from buytbl) or price = (select min(price) from buytbl);
-- 04
select * from buytbl where groupname !='null';
-- 05
select * from buytbl;
select prodname, amount from buytbl group by prodname, amount with rollup;