--Task1_0523. 
--orders라는 테이블을 생성하고, order_id, customer_id, order_date, amount, status라는 속성을 설정하세요.
--데이터를 5개 입력하세요.
--입력한 데이터 중 2개를 수정하세요.
--수정한 데이터를 취소하기 위해 롤백을 사용하세요.
--3개의 새로운 데이터를 입력하고, 그 중 마지막 데이터 입력만 취소한 후 나머지를 커밋하세요.
DROP TABLE orders CASCADE CONSTRAINTS PURGE;
CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    order_date DATE,
    amount NUMBER(10, 2),
    status VARCHAR(50)
);

INSERT INTO orders VALUES (1, 101, '2024-05-20', 50.00, 'Pending');
INSERT INTO orders VALUES (2, 102, '2024-05-21', 100.00, 'Processing');
INSERT INTO orders VALUES (3, 103, '2024-05-22', 150.00, 'Completed');
INSERT INTO orders VALUES (4, 104, '2024-05-23', 200.00, 'Pending');
INSERT INTO orders VALUES (5, 105, '2024-05-24', 250.00, 'Processing');

COMMIT;

UPDATE orders 
SET status = 'Cancelled' 
WHERE order_id IN (1, 2);

ROLLBACK;

INSERT INTO orders VALUES (6, 106, '2024-05-25', 300.00, 'Pending');
INSERT INTO orders VALUES (7, 107, '2024-05-26', 350.00, 'Processing');

SAVEPOINT before_last_data;

INSERT INTO orders VALUES (8, 108, '2024-05-27', 400.00, 'Completed');

ROLLBACK TO before_last_data;

COMMIT;

SELECT * FROM orders;