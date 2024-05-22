--(실습 - 2인 1조)
--학교 관리를 위하여 테이블 2개 이상으로 db를 구축하고 3개 이상 활용할 수 있는 case를 만드세요.
DROP TABLE SCHOOL;
DROP TABLE CLASS;
DROP TABLE PROFESSOR;
DROP TABLE STUDENTS;
DROP TABLE GRADE_1;
DROP TABLE GRADE_2;
--SCHOOL 테이블 생성
CREATE TABLE SCHOOL (
    sc_id       NUMBER PRIMARY KEY,
    sc_name     VARCHAR2(50) NOT NULL,
    sc_phone    VARCHAR2(50) DEFAULT '02-XXX-XXXX',
    location    VARCHAR2(100)
);
--CLASS 테이블 생성
CREATE TABLE CLASS (
    sc_id       NUMBER NOT NULL,
    cls_id      NUMBER PRIMARY KEY,
    cls_name    VARCHAR(20) NOT NULL,
    cls_major   VARCHAR2(50) NOT NULL,
    cls_phone   VARCHAR2(50) DEFAULT '02-XXX-XXXX',
    cls_loc     VARCHAR2(20) NOT NULL,
    FOREIGN KEY(sc_id) REFERENCES SCHOOL(sc_id) ON DELETE CASCADE
);
--PROFESSOR 테이블 생성
CREATE TABLE PROFESSOR (
    cls_id      NUMBER NOT NULL,
    pro_id      NUMBER(7) PRIMARY KEY,
    pro_name    VARCHAR2(50) NOT NULL,
    pro_phone   VARCHAR2(50) NOT NULL,
    FOREIGN KEY(cls_id) REFERENCES CLASS(cls_id) ON DELETE CASCADE
);
--STUDENTS 테이블 생성 
CREATE TABLE STUDENTS (
    cls_id      NUMBER NOT NULL,
    pro_id      NUMBER(7) NOT NULL,
    std_id      NUMBER(7) PRIMARY KEY,
    name        VARCHAR2(50) NOT NULL,
    sex         CHAR(6) DEFAULT '남자' CHECK(sex IN ('남자', '여자')),
    age         NUMBER NOT NULL,
    height      NUMBER(4,1),
    weight      NUMBER(4,1),
    phone       VARCHAR2(20) DEFAULT '010-xxxx-xxxx',
    enrollment  DATE,
    FOREIGN KEY(cls_id) REFERENCES CLASS(cls_id) ON DELETE CASCADE,
    FOREIGN KEY(pro_id) REFERENCES PROFESSOR(pro_id) ON DELETE CASCADE
);

--2023년 1학기 성적기록부
CREATE TABLE GRADE_1 (
    std_id       NUMBER(7) NOT NULL,
    name        VARCHAR2(50),
    math        NUMBER DEFAULT 0,
    english     NUMBER DEFAULT 0,
    science     NUMBER DEFAULT 0,
    music       NUMBER DEFAULT 0,
    social      NUMBER DEFAULT 0,
    FOREIGN KEY (std_id) REFERENCES students(std_id) ON DELETE CASCADE
);
--2023년 2학기 성적기록부
CREATE TABLE GRADE_2 (
    std_id       NUMBER(7) NOT NULL,
    name        VARCHAR2(50),
    math        NUMBER DEFAULT 0,
    english     NUMBER DEFAULT 0,
    science     NUMBER DEFAULT 0,
    music       NUMBER DEFAULT 0,
    social       NUMBER DEFAULT 0,
    FOREIGN KEY (std_id) REFERENCES students(std_id) ON DELETE CASCADE
);
--테이블 데이터타입 확인
DESC STUDENTS;
--SCHOOL 테이블 데이터
INSERT INTO SCHOOL VALUES (1, '서울대학교', '02-880-5114','서울특별시 관악구 관악로 1');
--CLASS 테이블 데이터
INSERT INTO CLASS VALUES (1, 1, '1-A', '수학과', '02-880-6001', '301호');
INSERT INTO CLASS VALUES (1, 2, '1-B', '수학과', '02-880-6002', '302호');
INSERT INTO CLASS VALUES (1, 3, '2-A', '수학과', '02-880-6003', '303호');
INSERT INTO CLASS VALUES (1, 4, '2-B', '수학과', '02-880-6004', '304호');
INSERT INTO CLASS VALUES (1, 5, '3-A', '수학과', '02-880-6005', '305호');
INSERT INTO CLASS VALUES (1, 6, '3-B', '수학과', '02-880-6006', '306호');
INSERT INTO CLASS VALUES (1, 7, '4-A', '수학과', '02-880-6007', '307호');
INSERT INTO CLASS VALUES (1, 8, '4-B', '수학과', '02-880-6008', '308호');
INSERT INTO CLASS VALUES (1, 9, '1-A', '컴퓨터공학과', '02-880-6009', '309호');
INSERT INTO CLASS VALUES (1, 10, '1-B', '컴퓨터공학과', '02-880-60010', '310호');
INSERT INTO CLASS VALUES (1, 11, '2-A', '컴퓨터공학과', '02-880-6011', '311호');
INSERT INTO CLASS VALUES (1, 12, '2-B', '컴퓨터공학과', '02-880-6012', '312호');
INSERT INTO CLASS VALUES (1, 13, '3-A', '컴퓨터공학과', '02-880-6013', '313호');
INSERT INTO CLASS VALUES (1, 14, '3-B', '컴퓨터공학과', '02-880-6014', '314호');
INSERT INTO CLASS VALUES (1, 15, '4-A', '컴퓨터공학과', '02-880-6015', '315호');
INSERT INTO CLASS VALUES (1, 16, '4-B', '컴퓨터공학과', '02-880-6016', '316호');

--PROFESSOR 테이블 데이터
INSERT INTO PROFESSOR VALUES (1, 1240301, '김수현', '010-2940-9985');
INSERT INTO PROFESSOR VALUES (2, 1240302, '수지', '010-5487-4566');
INSERT INTO PROFESSOR VALUES (3, 1240303, '강세훈', '010-5673-0166');
INSERT INTO PROFESSOR VALUES (4, 1240304, '정승효', '010-4489-5074');
INSERT INTO PROFESSOR VALUES (5, 1240305, '박민지', '010-7731-9246');
INSERT INTO PROFESSOR VALUES (6, 1240306, '이재현', '010-1692-8035');
INSERT INTO PROFESSOR VALUES (7, 1240307, '최지훈', '010-3126-7325');
INSERT INTO PROFESSOR VALUES (8, 1240308, '한영희', '010-8462-1853');
INSERT INTO PROFESSOR VALUES (9, 1240309, '이지수', '010-9085-6234');
INSERT INTO PROFESSOR VALUES (10, 1240310, '신영수', '010-7405-6857');
INSERT INTO PROFESSOR VALUES (11, 1240311, '김지민', '010-6317-2934');
INSERT INTO PROFESSOR VALUES (12, 1240312, '이준호', '010-4025-6708');
INSERT INTO PROFESSOR VALUES (13, 1240313, '김영희', '010-2875-3496');
INSERT INTO PROFESSOR VALUES (14, 1240314, '장현우', '010-5918-7264');
INSERT INTO PROFESSOR VALUES (15, 1240315, '박지영', '010-8352-1496');
INSERT INTO PROFESSOR VALUES (16, 1240316, '김태희', '010-1094-5685');

--STUDENTS 테이블 데이터 입력
INSERT INTO STUDENTS VALUES (1, 1240301, 2303001, '손경수', '남자', 21, 175.5, 68.2, '010-1234-5678', TO_DATE('2023-03-15', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303002, '홍길동', '남자', 22, 180.0, 70.5, '010-2345-6789', TO_DATE('2023-03-16', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303003, '김철수', '남자', 20, 172.0, 65.3, '010-3456-7890', TO_DATE('2023-03-17', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303004, '이영희', '여자', 21, 165.8, 55.9, '010-4567-8901', TO_DATE('2023-03-18', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303005, '박민지', '여자', 20, 167.5, 58.2, '010-5678-9012', TO_DATE('2023-03-19', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303006, '최지수', '여자', 22, 163.0, 50.6, '010-6789-0123', TO_DATE('2023-03-20', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303007, '강민호', '남자', 23, 178.3, 72.1, '010-7890-1234', TO_DATE('2023-03-21', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303008, '정수진', '여자', 20, 170.2, 60.5, '010-8901-2345', TO_DATE('2023-03-22', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303009, '이지은', '여자', 21, 166.7, 54.8, '010-9012-3456', TO_DATE('2023-03-23', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303010, '김민아', '여자', 22, 172.5, 63.4, '010-0123-4567', TO_DATE('2023-03-24', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303011, '박준호', '남자', 20, 177.8, 71.2, '010-1234-5678', TO_DATE('2023-03-25', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303012, '이수현', '여자', 21, 168.5, 57.3, '010-2345-6789', TO_DATE('2023-03-26', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303013, '최민서', '여자', 23, 164.0, 49.7, '010-3456-7890', TO_DATE('2023-03-27', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303014, '김지혜', '여자', 20, 169.2, 56.8, '010-4567-8901', TO_DATE('2023-03-28', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303015, '박은비', '여자', 21, 170.8, 59.2, '010-5678-9012', TO_DATE('2023-03-29', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303016, '이준서', '남자', 22, 176.3, 70.4, '010-6789-0123', TO_DATE('2023-03-30', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303017, '최지원', '여자', 20, 168.7, 58.1, '010-7890-1234', TO_DATE('2023-03-31', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303018, '김민수', '남자', 21, 180.5, 75.6, '010-8901-2345', TO_DATE('2023-04-01', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303019, '이지현', '여자', 22, 173.6, 62.5, '010-9012-3456', TO_DATE('2023-04-02', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303020, '박소연', '여자', 20, 165.4, 53.9, '010-0123-4567', TO_DATE('2023-04-03', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303021, '최준혁', '남자', 21, 179.2, 73.0, '010-1234-5678', TO_DATE('2023-04-04', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303022, '김지수', '여자', 22, 170.9, 61.7, '010-2345-6789', TO_DATE('2023-04-05', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303023, '이민호', '남자', 20, 175.0, 69.8, '010-3456-7890', TO_DATE('2023-04-06', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303024, '박지은', '여자', 21, 166.3, 55.6, '010-4567-8901', TO_DATE('2023-04-07', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303025, '최서윤', '여자', 22, 168.0, 57.2, '010-5678-9012', TO_DATE('2023-04-08', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303026, '김민지', '여자', 20, 171.5, 60.3, '010-6789-0123', TO_DATE('2023-04-09', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303027, '이준혁', '남자', 21, 177.4, 71.8, '010-7890-1234', TO_DATE('2023-04-10', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303028, '박지현', '여자', 22, 169.8, 57.5, '010-8901-2345', TO_DATE('2023-04-11', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303029, '최지민', '여자', 20, 165.0, 52.8, '010-9012-3456', TO_DATE('2023-04-12', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303030, '김수현', '남자', 21, 174.2, 67.1, '010-0123-4567', TO_DATE('2023-04-13', 'YYYY-MM-DD'));

insert into GRADE_1 values(2303001, '손경수', 0.0, 3.1, 2.3, 4.0, 3.5);
insert into GRADE_1 values(2303002, '홍길동', 3.2, 0.0, 3.3, 2.0, 1.5);
insert into GRADE_1 values(2303003, '김철수', 2.5, 3.2, 2.8, 3.6, 2.9);
insert into GRADE_1 values(2303004, '이영희', 3.1, 2.7, 3.5, 2.4, 3.2);
insert into GRADE_1 values(2303005, '박민지', 1.8, 2.9, 3.1, 3.0, 2.6);
insert into GRADE_1 values(2303006, '최지수', 2.7, 3.4, 2.5, 3.3, 3.1);
insert into GRADE_1 values(2303007, '강민호', 0.0, 2.6, 3.2, 2.8, 3.4);
insert into GRADE_1 values(2303008, '정수진', 3.4, 3.1, 0.0, 3.5, 2.7);
insert into GRADE_1 values(2303009, '이지은', 3.3, 2.5, 3.0, 2.6, 3.2);
insert into GRADE_1 values(2303010, '김민아', 2.8, 3.0, 2.7, 3.1, 2.9);
insert into GRADE_1 values(2303011, '박준호', 4.2, 3.8, 4.1, 3.9, 4.0);
insert into GRADE_1 values(2303012, '이수현', 3.6, 4.3, 3.8, 4.2, 3.8);
insert into GRADE_1 values(2303013, '최민서', 3.1, 2.7, 3.1, 2.9, 3.3);
insert into GRADE_1 values(2303014, '김지혜', 2.9, 3.0, 2.6, 3.4, 2.7);
insert into GRADE_1 values(2303015, '박은비', 3.4, 2.4, 3.2, 2.7, 3.1);
insert into GRADE_1 values(2303016, '이준서', 2.7, 3.1, 2.8, 3.0, 2.9);
insert into GRADE_1 values(2303017, '최지원', 3.0, 2.0, 3.3, 2.6, 3.2);
insert into GRADE_1 values(2303018, '김민수', 3.8, 4.2, 3.9, 4.1, 4.2);
insert into GRADE_1 values(2303019, '이지현', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_1 values(2303020, '박소연', 2.9, 3.0, 2.7, 3.3, 2.8);
insert into GRADE_1 values(2303021, '최준혁', 3.1, 2.8, 3.1, 2.5, 3.1);
insert into GRADE_1 values(2303022, '김지수', 2.7, 3.1, 2.6, 3.2, 2.9);
insert into GRADE_1 values(2303023, '이민호', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_1 values(2303024, '박지은', 2.8, 3.0, 2.8, 3.1, 2.8);
insert into GRADE_1 values(2303025, '최서윤', 4.1, 3.8, 4.2, 4.0, 4.1);
insert into GRADE_1 values(2303026, '김민지', 2.9, 3.0, 2.7, 3.2, 2.7);
insert into GRADE_1 values(2303027, '이준혁', 3.0, 2.8, 3.0, 2.6, 3.0);
insert into GRADE_1 values(2303028, '박지현', 2.8, 3.1, 2.7, 3.0, 2.8);
insert into GRADE_1 values(2303029, '최지민', 3.1, 2.7, 3.1, 2.5, 3.1);
insert into GRADE_1 values(2303030, '김수현', 2.9, 3.0, 2.6, 3.1, 2.9);

insert into GRADE_2 values(2303001, '손경수', 0.0, 3.1, 2.3, 4.0, 3.5);
insert into GRADE_2 values(2303002, '홍길동', 3.2, 0.0, 3.3, 2.0, 1.5);
insert into GRADE_2 values(2303003, '김철수', 2.5, 3.2, 2.8, 3.6, 2.9);
insert into GRADE_2 values(2303004, '이영희', 3.1, 2.7, 3.5, 2.4, 3.2);
insert into GRADE_2 values(2303005, '박민지', 1.8, 2.9, 3.1, 3.0, 2.6);
insert into GRADE_2 values(2303006, '최지수', 2.7, 3.4, 2.5, 3.3, 3.1);
insert into GRADE_2 values(2303007, '강민호', 0.0, 2.6, 3.2, 2.8, 3.4);
insert into GRADE_2 values(2303008, '정수진', 3.4, 3.1, 0.0, 3.5, 2.7);
insert into GRADE_2 values(2303009, '이지은', 3.3, 2.5, 3.0, 2.6, 3.2);
insert into GRADE_2 values(2303010, '김민아', 2.8, 3.0, 2.7, 3.1, 2.9);
insert into GRADE_2 values(2303011, '박준호', 4.2, 3.8, 4.1, 3.9, 4.0);
insert into GRADE_2 values(2303012, '이수현', 3.6, 4.3, 3.8, 4.2, 3.8);
insert into GRADE_2 values(2303013, '최민서', 3.1, 2.7, 3.1, 2.9, 3.3);
insert into GRADE_2 values(2303014, '김지혜', 2.9, 3.0, 2.6, 3.4, 2.7);
insert into GRADE_2 values(2303015, '박은비', 3.4, 2.4, 3.2, 2.7, 3.1);
insert into GRADE_2 values(2303016, '이준서', 2.7, 3.1, 2.8, 3.0, 2.9);
insert into GRADE_2 values(2303017, '최지원', 3.0, 2.0, 3.3, 2.6, 3.2);
insert into GRADE_2 values(2303018, '김민수', 3.8, 4.2, 3.9, 4.1, 4.2);
insert into GRADE_2 values(2303019, '이지현', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_2 values(2303020, '박소연', 2.9, 3.0, 2.7, 3.3, 2.8);
insert into GRADE_2 values(2303021, '최준혁', 3.1, 2.8, 3.1, 2.5, 3.1);
insert into GRADE_2 values(2303022, '김지수', 2.7, 3.1, 2.6, 3.2, 2.9);
insert into GRADE_2 values(2303023, '이민호', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_2 values(2303024, '박지은', 2.8, 3.0, 2.8, 3.1, 2.8);
insert into GRADE_2 values(2303025, '최서윤', 4.1, 3.8, 4.2, 4.0, 4.1);
insert into GRADE_2 values(2303026, '김민지', 2.9, 3.0, 2.7, 3.2, 2.7);
insert into GRADE_2 values(2303027, '이준혁', 3.0, 2.8, 3.0, 2.6, 3.0);
insert into GRADE_2 values(2303028, '박지현', 2.8, 3.1, 2.7, 3.0, 2.8);
insert into GRADE_2 values(2303029, '최지민', 3.1, 2.7, 3.1, 2.5, 3.1);
insert into GRADE_2 values(2303030, '김수현', 2.9, 3.0, 2.6, 3.1, 2.9);


SELECT * FROM CLASS;
SELECT * FROM PROFESSOR;
SELECT * FROM STUDENTS;
SELECT * FROM GRADE_1;
SELECT * FROM GRADE_2;















--BMI 계산기
SELECT std_id "학번", name "이름", height "키", weight "몸무게"
FROM STUDENTS
WHERE sex='남자' and std_id in (
    SELECT std_id 
    from students
    where weight / power(height/100, 2) between 15 and 40);







--졸업연월을 조회해주는 명령문
SELECT stdid "학번", name "이름", class, enrollment "입학날짜", TO_CHAR(ADD_MONTHS(enrollment, 3 * 12 + 11), 'YYYY-mm') "졸업연도"
FROM STUDENTS;

SELECT stdid "학번", name "이름", class, enrollment "입학날짜", TO_CHAR(ADD_MONTHS(enrollment, 3 * 12 + 11), 'YYYY-mm') "졸업연도"
FROM STUDENTS
WHERE name='박신혜';

SELECT 
    stdid "학번", name "이름", class, enrollment "입학날짜",
    TO_CHAR(ADD_MONTHS(enrollment, 3 * 12 + 11), 'YY-mm') "졸업연도"
FROM 
    STUDENTS
WHERE
    class='2-c';




INSERT INTO GRADE_2023_2 (stdid, name, math, english, science, music)
SELECT 
    s.stdid,
    s.name,
    ROUND(DBMS_RANDOM.VALUE(60, 100)),
    ROUND(DBMS_RANDOM.VALUE(60, 100)),
    ROUND(DBMS_RANDOM.VALUE(60, 100)),
    ROUND(DBMS_RANDOM.VALUE(60, 100))
FROM
    students s;

select * from students;
select * from grade_2023_1;
select * from grade_2023_2;


SELECT
    g1.name "이름",
    g1.math "수학",
    g1.english "영어",
    g1.science "과학",
    g1.music "음악"
FROM
    GRADE_2023_1 g1;



SELECT
    g1.name AS "이름",
    g1.math AS "1학기_수학",
    g1.english AS "1학기_영어",
    g1.science "1학기_과학",
    g1.music "1학기_음악",
    g2.math AS "2학기_수학",
    g2.english AS "2학기_영어",
    g2.science "2학기_과학",
    g2.music "2학기_음악"
FROM
    GRADE_2023_1 g1
JOIN
    GRADE_2023_2 g2
ON
    g1.name = g2.name
WHERE
    g1.name='김철수';
    
    

--활용 case1 : 입학날짜를 입력하면 졸업 날짜를 안내해준다.
--활용 case2 : F를 받은 과목을 찾아주어 재수강을 받을 수 있게 안내해준다.
--활용 case3 : 학생들의 간단한 인적사항과 시험 성적 조회 join