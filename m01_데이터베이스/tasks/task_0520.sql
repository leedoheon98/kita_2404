--Task1_0520. 10 개의 속성으로 구성되는 테이블 2개를 작성하세요. 단 FOREIGN KEY 를 적용하여 한쪽 테이블의 데이터를
--삭제 시 다른 테이블의 관련되는 데이터도 모두 삭제되도록 하세요. (모든 제약조건을 사용)
--단, 각 테이블에 5개의 데이터를 입력하고 두 번째 테이블에 첫 번째 데이터를 참조하고 있는 속성을 선택하여 데이터 삭제
create table SINBONG(
name        varchar2(20) not null,
serial_num  number(6) primary key,
phone       varchar2(50) default ' ',
address     varchar2(100) default ' ',
sex         char(6) default '남자' check(sex in ('남자','여자'))
);
create table SUNGBOK (
stdid       number(3) primary key,
rank        number(3) default 999,
name        varchar2(20) not null,
serial_num  number not null,
class_num   char(10) default ' ',
foreign key(serial_num) references sinbong(serial_num) on delete cascade
);

insert into sinbong values ('나도현', 981203, '010-8606-0136', '신봉 자이 1차', '남자');
insert into sinbong values ('강세돌', 980504, '010-5673-0566', '동부 센트레빌', '남자');
insert into sinbong values ('김랑엽', 980218, '010-8941-8467', '우남 하이빌', '남자');
insert into sinbong values ('김수현', 980626, '010-7579-9763', '신봉 자이 1차', '여자');
insert into sinbong values ('권쑤쑤', 980709, '010-2573-5456', '동일 하이빌', '여자');
insert into sinbong (name, serial_num) values ('정릉효', 981224);

insert into sungbok values (1, 11, '나도현', 981203, '11반');
insert into sungbok values (2, 2, '김수현', 980626, '4반');
insert into sungbok values (3, 40, '강세돌', 980504, '7반');
insert into sungbok values (4, 23, '권쑤쑤', 980709, '12반');
insert into sungbok values (5, 9, '김랑엽', 980218, '9반');
insert into sungbok (stdid, name, serial_num) values (6, '정릉효', 981224);

select * from sinbong;
select * from sungbok;

alter table sungbok drop column serial_num;

select * from sungbok;

--Task2_0520. Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
select * from customer;
update customer
set address = ( select address from customer where name='김연아' )
where name='박세리';

--Task3_0520.도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록, 가격을 보이시오.
--select * from book;
update book
set bookname='농구'
where bookname like '%야구%';
select bookid, bookname, price from book;
--강사님풀이 select 문에 replace 가능 (컬럼명, 바꿀 데이터, 데이터)
select bookid, replace(bookname, '야구', '농구') bookname, publisher, price
from book;

--Task4_0520. 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
--substr(name, 1, 1) 함수는 문자열 name의 첫 번째 글자부터 시작하여 한 글자를 반환
--select * from customer;
select substr(name,1,1) 성, count(*) 인원
from customer
group by substr(name,1,1);

--Task5_0520. 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
select orderid, orderdate as 주문일, orderdate +10 as 확정일자
from orders;
--2개월 후
SELECT ORDERDATE "주문 일자", add_months(ORDERDATE, 2) "확정 일자" FROM ORDERS;

--Task6_0520.마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 
--단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.
select orderid 주문번호, to_char(orderdate, 'YYYY-mm-dd day') 주문일, custid 고객번호, bookid 도서번호
from orders
where orderdate = '2020-07-07';
desc orders;

--Task7_0520. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
select * from orders;

select orderid, saleprice
from orders
where saleprice <= ( select avg(saleprice) from orders );
--서브쿼리를 o2 라는 별칭으로 지정, saleprice의 평균 값을 avg_saleprice 로 계산
SELECT o1.orderid, o1.saleprice
FROM orders o1
JOIN (SELECT AVG(saleprice) AS avg_saleprice FROM orders) o2
ON o1.saleprice < o2.avg_saleprice;

--Task8_0520. 대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
select * from orders;
select sum(saleprice) as "총 판매액"
from orders
where custid in (select custid from customer where address like '%대한민국%');