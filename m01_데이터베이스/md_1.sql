CREATE TABLE BOOK (
bookid NUMBER(2) PRIMARY KEY,
bookname VARCHAR(40),
publisher VARCHAR(40),
price NUMBER(8)
);

INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '구의 역사', '포츠', 1000);
INSERT INTO Book VALUES(3, '의 역사', '굿스포', 17000);

SELECT * FROM BOOK;

commit;