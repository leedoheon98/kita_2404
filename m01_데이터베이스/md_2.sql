SELECT * FROM BOOK;
SELECT bookid,price FROM BOOK;

SELECT * FROM CUSTOMER;
SELECT * FROM IMPORTED_BOOK;
SELECT * FROM ORDERS;

--중복없이 출력 : DISTINCT
SELECT DISTINCT publisher FROM BOOK;

--Q. 가격이 10,000원 이상인 도서를 검색
SELECT * FROM BOOK
WHERE price >= 10000;

--Q. 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오. (2가지 방법)
SELECT * FROM BOOK
WHERE price >= 10000 and price <= 20000;

SELECT * FROM BOOK
WHERE price BETWEEN 10000 and 20000;

--Task1_0517. 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오. (3가지 방법)
SELECT * FROM BOOK
WHERE (publisher='굿스포츠') or (publisher='대한미디어');

SELECT * FROM BOOK
WHERE publisher IN ('굿스포츠', '대한미디어');


--Task2_0517. 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색하시오.
SELECT * FROM BOOK
WHERE (publisher!='굿스포츠') AND (publisher!='대한미디어');

--LIKE는 정확히 '축구의 역사'와 일치하는 행만 선택
SELECT bookname, publisher FROM BOOK
WHERE bookname LIKE '축구의 역사';

--'축구'가 포함된 출판사
SELECT bookname, publisher FROM BOOK
WHERE bookname LIKE '%축구%';

--도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서
SELECT bookname, publisher FROM BOOK
WHERE bookname LIKE '_구%';

--Task3_0517. 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT * FROM BOOK
WHERE price >= 20000 AND bookname LIKE '%축구%';

--정렬 (DEFAULT = 올림차순)
SELECT * FROM BOOK
ORDER BY price;

--정렬 (내림차순 = DESC)
SELECT * FROM BOOK
ORDER BY price DESC;

--Q. 도서를 가격 순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT * FROM BOOK
ORDER BY price, bookname;

--컬럼의 연산
SELECT SUM(saleprice) AS "총 판매액"
FROM ORDERS
WHERE CUSTID = 2;

SELECT * FROM ORDERS
ORDER BY custid, saleprice;

--GROUP BY : 데이터를 특정 기준에 따라 그룹화하는데 사용. 이를 통해 집계 함수 (SUM, AVG, MAX, MIN, COUNT)
SELECT SUM(saleprice) AS total,
AVG(saleprice) AS average,
MIN(saleprice) AS minimum_price,
MAX(saleprice) AS max_price
FROM ORDERS;

--총 판매액을 custid 기준으로 그룹화
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM ORDERS
GROUP BY custid;

--bookid가 5보다 큰 조건
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM ORDERS
WHERE bookid > 5
GROUP BY custid;

-- +도서수량이 2 이상인 조건
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM ORDERS
WHERE bookid > 5
GROUP BY custid
HAVING COUNT(*) >= 2;

--Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
select C.name, O.bookid, B.bookname, O.saleprice
from customer C, book B, orders O
where O.bookid = B.bookid and C.custid = O.custid
order by C.name;

select customer.name, book.bookname
from orders
inner join customer on orders.custid = customer.custid
inner join book on orders.bookid = book.bookid;

--Q. 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
select C.name, B.bookname, O.saleprice
from customer C, book B, orders O
where O.custid = C.custid and O.bookid = B.bookid and O.saleprice = 20000;

--JOIN은 두 개 이상의 테이블을 연결하여 관련된 데이터를 결합할 때 사용

--내부 조인 (INNER JOIN)  = 교집합
select customer.name, orders.saleprice
from customer
inner join orders on customer.custid=orders.custid
order by customer.name;

--외부 조인 (OUTER JOIN)  = 합집합
--왼쪽 외부 조인 (Left Outer Join) : . 두 번째 테이블에 일치하는 데이터가 없는 경우 NULL 값이 사용
SELECT CUSTOMER.NAME, ORDERS.SALEPRICE
FROM CUSTOMER
LEFT OUTER JOIN ORDERS ON CUSTOMER.CUSTID=ORDERS.CUSTID;

--오른쪽 외부 조인 (Right Outer Join) : 첫 번째 테이블에 일치하는 데이터가 없는 경우 NULL 값이 사용
SELECT CUSTOMER.NAME, ORDERS.SALEPRICE
FROM CUSTOMER
RIGHT OUTER JOIN ORDERS ON CUSTOMER.CUSTID=ORDERS.CUSTID;

--FULL OUTER JOIN : 일치하는 데이터가 없는 경우 해당 테이블에서는 NULL 값이 사용
SELECT CUSTOMER.NAME, ORDERS.SALEPRICE
FROM CUSTOMER
FULL OUTER JOIN ORDERS ON CUSTOMER.CUSTID=ORDERS.CUSTID;

--CROSS JOIN : 두 테이블 간의 모든 가능한 조합을 생성
SELECT CUSTOMER.NAME, ORDERS.SALEPRICE
FROM CUSTOMER
CROSS JOIN ORDERS;

--Q. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오. (2가지 방법, where, join)
select customer.name, orders.saleprice
from customer, orders
where customer.custid = orders.custid(+)
order by customer.name;

select customer.name, orders.saleprice
from customer
left outer join orders on customer.custid=orders.custid
order by customer.name;

--서브쿼리 (Sub Query)
select name
from customer
where custid in (select custid from orders);

--Q. ‘대한미디어’에서 출판한 도서를 구매한 고객의 이름을 보이시오.
select C.name, B.publisher, B.bookname
from customer C, book B
where C.custid in (select custid from orders) and B.publisher='대한미디어';

select name
from customer
where custid in (select custid from orders
where bookid in (select bookid from book
where publisher = '대한미디어'));

select * from book;
select avg(price) from book where publisher in (select publisher from book group by publisher);

--Q. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
select b1.bookname, b1.price, b1.publisher
from book b1
where b1.price > (select avg(b2.price)
from book b2
where b2.publisher = b1.publisher);

--GROUP BY를 사용해서
SELECT b1.bookname, b1.price, b1.publisher
FROM book b1
JOIN (
    SELECT publisher, AVG(price) AS avg_price
    FROM book
    GROUP BY publisher
) b2 ON b1.publisher = b2.publisher
WHERE b1.price > b2.avg_price;

--Q. 도서를 주문하지 않은 고객의 이름을 보이시오.
select name
from customer
where custid not in (select custid from orders);

--Q. 주문이 있는 고객의 이름과 주소를 보이시오.
select name 고객이름, address 주소
from customer
where custid in (select custid from orders);