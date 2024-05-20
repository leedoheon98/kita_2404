--Task1_0517. 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오. (3가지 방법)
SELECT * FROM BOOK
WHERE (publisher='굿스포츠') or (publisher='대한미디어')
order by publisher, bookid;

select * from book
where publisher in ('굿스포츠', '대한미디어')
order by publisher, bookid;

select * from book
where publisher=any('굿스포츠', '대한미디어')
order by publisher, bookid;

--Task2_0517. 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색하시오.
SELECT * FROM BOOK
WHERE (publisher!='굿스포츠') AND (publisher!='대한미디어');

--Task3_0517. 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT * FROM BOOK
WHERE price >= 20000 AND bookname LIKE '%축구%';

--Task4_0517. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT orders.custid, customer.name, sum(orders.saleprice) as "총 판매액"
from orders, customer
where orders.custid = 2 and orders.custid=customer.custid
group by orders.custid, customer.name;

--JOIN 활용하기 + 개수 구하기
select orders.custid, customer.name, count(orders.orderid) as "도서수량", sum(orders.saleprice) as "총 판매액"
from orders inner join customer on orders.custid = customer.custid
where orders.custid = 2
group by customer.name, orders.custid;

--Task5_0517. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 
--단, 두 권 이상 구매한 고객만 구하시오.
SELECT custid, COUNT(*) AS "도서수량", SUM(saleprice) AS "총 구매액"
FROM ORDERS
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >= 2
ORDER BY custid;

--Task6_0517. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT CUSTOMER.name AS "고객 이름", ORDERS.bookid, ORDERS.saleprice AS "판매가격"
FROM CUSTOMER JOIN ORDERS
USING(custid)
ORDER BY custid;

select name, saleprice
from customer, orders
where customer.custid = orders.custid;

--Task7_0517. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
select custid, sum(saleprice) "총 판매액"
from orders
group by custid
order by custid;

select name, sum(saleprice) as "총 판매액"
from customer c, orders o
where c.custid = o.custid
group by c.name
order by c.name;