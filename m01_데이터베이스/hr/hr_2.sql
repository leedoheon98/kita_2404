SELECT * FROM EMPLOYEES;

--Q. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력.
SELECT E.employee_id 사번, E.first_name 성, E.last_name 이름, E.job_id 업무, J.job_title 업무명
FROM employees E
INNER JOIN jobs J ON E.job_id=J.job_id
WHERE E.employee_id = 120;

--FIRST_NAME || ' ' || LAST_NAME AS 이름: FIRST_NAME과 LAST_NAME을 공백으로 연결하여
--하나의 문자열로 합치고, 이 결과의 별칭을 '이름'으로 지정
SELECT
    E.employee_id 사번, E.first_name || ' ' || E.last_name as 이름,
    J.job_id 업무, J.job_title
FROM
    EMPLOYEES E, JOBS J
WHERE
    E.employee_id = 120 AND e.Job_id = J.job_id;
    
--오라클에서 문자열을 합치기 위해서는 CONCAT 함수 또는 "||" 파이프 두개를 사용한다.
--SELECT CONCAT('가나다', '라마바') FROM DUAL;



--Q. 2005년 상반기에 입사한 사람들의 이름(Full name)과 입사일만 출력.
SELECT first_name||' '||last_name "이름(Full name)", hire_date "입사일"
FROM employees
WHERE TO_CHAR(hire_date, 'YY/MM') BETWEEN '05/01' AND '05/06';

-- "_" 를 와일드카드가 아닌 문자로 취급하고 싶을 때 escape 옵션을 사용
SELECT * FROM EMPLOYEES WHERE job_id LIKE '%\_A%';      -- escape 적용을 해줘야함.
SELECT * FROM EMPLOYEES WHERE job_id LIKE '%\_A%' escape '\';
SELECT * FROM EMPLOYEES WHERE job_id LIKE '%#_A%' escape '#';

-- IN : OR 대신 사용
SELECT * FROM EMPLOYEES WHERE manager_id=101 or manager_id=102 or manager_id=103;
SELECT * FROM EMPLOYEES WHERE manager_id in ( 101, 102, 103 );

--Q. 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
SELECT * FROM EMPLOYEES
WHERE job_id IN ('SA_MAN', 'IT_PROG', 'ST_MAN');

--IS NULL / IS NOT NULL
--null 값 인지를 확인할 경우 = 비교 연산자를 사용하지 않고 is null 을 사용한다.
SELECT * FROM EMPLOYEES WHERE commission_pct is null;
SELECT * FROM EMPLOYEES WHERE commission_pct is not null;

--ORDER BY
--ORDER BY 컬럼명 [ ASC | DESC ]
SELECT * FROM EMPLOYEES ORDER BY salary asc;
SELECT * FROM EMPLOYEES ORDER BY salary desc;
SELECT * FROM EMPLOYEES ORDER BY salary asc, last_name desc;

--DUAL 테이블
--mod 나머지
SELECT * FROM EMPLOYEES WHERE mod( employee_id, 2 ) = 1;
SELECT mod( 10 , 3 ) FROM DUAL;

--round()
SELECT round( 355.95555 ) from DUAL;
SELECT round( 355.95555, 2 ) from DUAL;
SELECT round( 355.95555, -2 ) from DUAL;

--trunc() : 버림 함수. 지정한 자리수 이하를 버린 결과 제공
SELECT trunc( 45.5555, 1 ) FROM DUAL;

--ceil() 무조건 올리고 정수 반환, 자리 지정 못함
SELECT ceil( 45.111 ) FROM DUAL;

--Q. HR EMPLOYEES 테이블에서 이름, 급여, 10% 인상된 급여를 출력하세요.
SELECT last_name 이름, salary 급여, salary*1.1 "인상된 급여"
FROM EMPLOYEES;

--Q. EMPLOYEE_ID가 홀수인 직원의 EMPLOYEE_ID와 LAST_NAME을 출력하세요.
SELECT employee_id, first_name||' '||last_name "Full name"
FROM EMPLOYEES
WHERE mod(employee_id, 2) = 1;
--서브쿼리를 사용해서도 가능
SELECT employee_id, first_name||' '||last_name "Full name"
FROM EMPLOYEES
WHERE employee_id IN ( SELECT employee_id FROM employees WHERE mod(employee_id, 2) = 1 );

--Q. EMPLOYEES 테이블에서 commission_pct의 null 값 개수를 출력하세요.
SELECT COUNT(*) FROM EMPLOYEES WHERE commission_pct IS NULL;

--Q. EMPLOYEES 테이블에서 department_id가 없는 직원을 추출하여 position을 '신입'으로 출력하세요. (position 열을 추가)
SELECT employee_id, first_name, last_name, '신입' position
FROM EMPLOYEES WHERE department_id IS NULL;

--날짜 관련
SELECT sysdate FROM dual;
SELECT sysdate + 1 FROM dual;
SELECT sysdate - 1 FROM dual;

--근무한 날짜 계산
SELECT first_name||' '||last_name as "FULL_NAME", hire_date, sysdate, trunc(sysdate-hire_date) duration
FROM EMPLOYEES;

--add_months()      특정 개월 수를 더한 날짜를 구한다.
SELECT last_name, hire_date, add_months ( hire_date, 6 ) revised_date
FROM EMPLOYEES;

--last_day()      해당 월의 마지막 날짜를 반환하는 함수
SELECT last_name, hire_date, last_day(hire_date) FROM EMPLOYEES;
SELECT last_name, hire_date, last_day(add_months(hire_date, 1)) FROM EMPLOYEES;

--next_day()      요일을 명시하면 ('일'~'토' or 1 ~ 7 로 표현 ) 해당 날짜 이후 가장 처음으로 명시된 요일이 오는 날짜 반환.
----------------- ※ 단, 인자로 사용된 날짜는 결과에 포함될 수 없음. 일주일 뒤의 같은 요일에 해당하는 날짜가 출력.
SELECT hire_date, next_day(hire_date, '월') FROM EMPLOYEES;
SELECT hire_date, next_day(hire_date, 2 ) FROM EMPLOYEES;

--months_between()        날짜와 날짜 사이의 개월 수를 구한다. (개월 수를 소수점으로 표현)
SELECT hire_date, months_between(sysdate, hire_date) FROM EMPLOYEES;

--to_date()       '문자열'을 날짜 타입으로 변환
SELECT to_date('2023-01-01', 'YYYY-MM-DD') "문자 -> 날짜" FROM EMPLOYEES;
--to_char()       날짜를 문자로 변환
SELECT to_char(sysdate, 'yy/mm/dd') "날짜 -> 문자" FROM dual;

--형식
--YYYY    네 자리 연도
--YY      두 자리 연도
--YEAR    연도 영문 표기
--MM      월을 숫자로
--MON     월을 알파벳으로
--DD      일을 숫자로
--DAY     요일 표현
--DY      요일 약어 표현
--D       요일 숫자 표현
--AM 또는  PM   오전 오후
--HH 또는  HH12   12시간
--HH24    24시간
--MI      분
--SS      초

----Q. 현재 날짜 (sysdate)를 'YYYY/MM/DD' 형식의 문자열로 변환하세요.
SELECT to_char(sysdate, 'YYYY/MM/DD HH24\:MI:SS') FROM DUAL;
----Q. '01-01-2023' 이라는 문자열을 날짜 타입으로 변환하세요.
SELECT to_date('01-01-2023', 'MM-DD-YYYY') FROM DUAL;
----Q. 현재 날짜와 시간(sysdate)을 'YYYY-MM-DD HH24:MI:SS' 형식의 문자열로 변환하세요.
SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
----Q. '2023-01-01 15:30:00'이라는 문자열을 날짜 및 시간 타입으로 변환하세요.
SELECT to_date('2023-01-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

--to_char( 숫자 )   숫자를 문자로 변환
--9      한 자리의 숫자 표현      ( 1111, ‘99999’ )       1111   
--0      앞 부분을 0으로 표현     ( 1111, ‘099999’ )      001111
--$      달러 기호를 앞에 표현    ( 1111, ‘$99999’ )      $1111
--.      소수점을 표시           ( 1111, ‘99999.99’ )     1111.00
--,      특정 위치에 , 표시      ( 1111, ‘99,999’ )       1,111
--MI     오른쪽에 - 기호 표시    ( 1111, ‘99999MI’ )      1111-
--PR     음수값을 <>로 표현      ( -1111, ‘99999PR’ )     <1111>
--EEEE   과학적 표현             ( 1111, ‘99.99EEEE’ )   1.11E+03
--V      10을 n승 곱한값으로 표현 ( 1111, ‘999V99’ )      111100
--B      공백을 0으로 표현       ( 1111, ‘B9999.99’ )     1111.00
--L      지역통화               ( 1111, ‘L9999’ )

SELECT salary, to_char( salary, '0999999' ) FROM EMPLOYEES;
SELECT salary, to_char( -salary, '99999PR' ) FROM EMPLOYEES;
--1111 -> 1.11E+03
SELECT to_char( 11111, '9.999EEEE' ) FROM DUAL;
SELECT to_char( -1111111, '9999999MI' ) FROM DUAL;

--width_bucket()   ( 지정값, 최소값, 최대값, bucket 개수 )
SELECT width_bucket( 92, 0, 100, 10 ) FROM DUAL;        -- 0부터 100까지 10개의 구간으로 나오면 92는 10번째 구간에 속함.
SELECT width_bucket( 100, 0, 100, 10 ) FROM DUAL;       -- 0부터 100까지 10개의 구간으로 나눈 구간에 100은 들어갈 수 없으니 
                                                        -- 100부터의 임의의 새로운 bucket 에 담김.



SELECT * FROM EMPLOYEES;
--Q. EMPLOYEES 테이블의 salary를 5개 등급으로 표시하세요.
SELECT min(salary), max(salary) FROM EMPLOYEES;
SELECT first_name||' '||last_name, salary, width_bucket(salary, 2100, 24001, 5) as grade
FROM EMPLOYEES
ORDER BY GRADE DESC;

--Q. last_name이 Seo인 직원의 last_name 과 salary를 구하세요. (Seo, SEO, seo 모두 검출)
SELECT last_name, salary
FROM EMPLOYEES
WHERE last_name in ('Seo', 'SEO', 'seo');
-----------------------     강사님 풀이  lower()
SELECT last_name, salary FROM EMPLOYEES WHERE lower(last_name) = 'seo';
-----------------------     initcap()  첫글자만 대문자
SELECT job_id, initcap( job_id ) FROM EMPLOYEES;
-----------------------     length()  문자열의 길이
SELECT job_id, length( job_id ) FROM EMPLOYEES;
-----------------------     instr()  문자열, 찾을 문자, 시작 위치(역순 o), 찾은 문자 중 몇 번째
SELECT instr( 'Hello World', 'l', -1, 3 ) FROM DUAL;
-----------------------     substr()  문자열, 시작위치(역순 x), 개수
SELECT substr( 'Hello World', 3, 3 ) FROM DUAL;
SELECT substr( 'Hello World', 9, 3 ) FROM DUAL;
SELECT substr( 'Hello World', -3, 3 ) FROM DUAL;

-----------------------     lpad()      오른쪽 정렬 후 왼쪽에 문자를 채움.
SELECT lpad( 'Hello World', 20, '#' ) FROM DUAL;
-----------------------     rpad()      왼쪽 정렬 후 오른쪽에 문자를 채움.
SELECT rpad( 'Hello World', 20, '#' ) FROM DUAL;
-----------------------     ltrim()
SELECT ltrim( 'aaaHello Worldaaa', 'a') FROM DUAL;
SELECT ltrim( '   Hello World   ') FROM DUAL;
-----------------------     rtirm()
SELECT rtrim( 'aaaHello Worldaaa', 'a') FROM DUAL;
SELECT rtrim( '   Hello World   ') FROM DUAL;
-----------------------     trim
SELECT trim( '   Hello World    ') FROM DUAL;
-----------------------     앞뒤의 특정 문자제거
SELECT last_name, trim('A' from last_name) FROM EMPLOYEES;

-- nvl()  null을 0 또는 다른 값으로 변환하는 함수
SELECT last_name, manager_id,
nvl( to_char( manager_id ), 'CEO' ) revised_id from EMPLOYEES;

--decode()    if문이나 case문과 같이 여러 경우를 선택할 수 있도록 하는 함수
--DECODE 함수는 단순한 조건에 기반하여 값을 반환합니다. 구문은 DECODE(expression, search1, result1, ..., searchN, resultN, default) 
--여기서 expression은 검사할 값을 나타내고, search와 result는 각각 조건과 해당 조건이 참일 때 반환할 값
--default는 모든 search 조건이 거짓일 때 반환할 기본 값 출력
SELECT last_name, department_id,
decode(department_id,
    90, '경영지원실',
    60, '프로그래머',
    100, '인사부', '기타') 부서
FROM EMPLOYEES;

--Q. EMPLOYEES 테이블에서 commission_pct가 null이 아닌경우, 'A' null인 경우 'N'을 표시하는 쿼리를 작성
SELECT commission_pct as commission
    , decode(commission_pct, null, 'N', 'A') as 변환
FROM EMPLOYEES
ORDER BY 변환 desc;

--case()
--decode() 함수와 유사하나 decode() 함수는 단순한 조건 비교에 사용되는 반면
--case() 함수는 다양한 비교연산자로 조건을 제시할 수 있다.
--CASE 문은 조건에 따라 다른 값을 반환하는 데 사용되며, DECODE보다 복잡한 조건을 표현할 수 있다. 
--구문은 CASE WHEN condition THEN result ... ELSE default END이다. 
SELECT last_name, department_id,    -- CASE 칼럼을 새로 만드는 것이므로 쉼표(,)
    CASE
        WHEN department_id=90 then '경영지원실'      -- VALUES
        WHEN department_id=60 then '프로그래머'
        WHEN department_id=100 then '인사부'
        ELSE '기타'
    END AS 소속           -- 칼럼명
FROM EMPLOYEES;

--Q. EMPLOYEES 테이블에서 salary가 20000 이상이면 'a', 10000과 20000 미만 사이면 'b', 그 이하면 'c'로 표시하는 쿼리를 작성하시오. (case)
SELECT last_name, salary,
    CASE
        WHEN salary >= 20000 THEN 'a'
        WHEN salary > 10000 and salary < 20000 THEN 'b'
        ELSE 'c'
    END AS 등급
FROM EMPLOYEES;

--INSERT
--테이블에 데이터를 입력하는 방법은 두 가지 유형이 있으며 한 번에 한 건만 입력된다.
--a. INSERT INTO 테이블명 (COLUMN_LIST) VALUES (COLUMN_LIST에 넣을 VALUE_LIST);
--b. INSERT INTO 테이블명 VALUES (전체 COLUMN에 넣을 VALUE_LIST);

-- concatenation : 콤마 대신에 사용하면 문자열이 연결되어 출력된다.
SELECT last_name, 'is a ', job_id FROM EMPLOYEES;
SELECT last_name || 'is a ' || job_id FROM EMPLOYEES;

--UNION
--UNION(합집합) INTERSECT(교집합) MINUS(차집합) UNION ALL(중복 포함)
--두 개의 쿼리문을 사용해야 한다. 데이터 타입을 일치 시켜야 한다.
SELECT first_name 이름, salary 급여 FROM EMPLOYEES
WHERE salary < 5000
UNION
SELECT first_name 이름, salary 급여 FROM EMPLOYEES
WHERE hire_date < '99/01/01' ;

SELECT first_name 이름, salary 급여, hire_date FROM EMPLOYEES
WHERE salary < 5000
MINUS
SELECT first_name 이름, salary 급여, hire_date FROM EMPLOYEES
WHERE hire_date < '05/01/01' ;

SELECT first_name 이름, salary 급여, hire_date FROM EMPLOYEES
WHERE salary < 5000
INTERSECT
SELECT first_name 이름, salary 급여, hire_date FROM EMPLOYEES
WHERE hire_date < '05/01/01' ;

SELECT first_name 이름, salary 급여 FROM EMPLOYEES
WHERE salary < 5000
UNION ALL
SELECT first_name 이름, salary 급여 FROM EMPLOYEES
WHERE hire_date < '99/01/01' ;

--CREATE VIEW 명령어는 오라클 SQL에서 테이블의 특정 부분이나 조인된 결과를 논리적인 뷰(view)로 만들 때 사용
--뷰는 데이터를 요약하거나 복잡한 조인을 단순화하며, 사용자에게 필요한 데이터만을 보여주는 데 유용
--뷰는 실제 테이블 데이터를 저장하지 않고, 대신 쿼리문 자체를 저장
--뷰의 주요 특징
--쿼리 단순화: 복잡한 쿼리를 뷰로 저장함으로써 사용자는 복잡한 쿼리문을 반복해서 작성할 필요 없이 간단하게 뷰를 참조할 수 있다.
--데이터 추상화: 뷰는 기본 테이블의 구조를 숨기고 사용자에게 필요한 데이터만을 보여줄 수 있어, 데이터 추상화를 제공.
--보안 강화: 뷰를 사용하면 특정 데이터에 대한 접근을 제한할 수 있으며, 사용자가 볼 수 있는 데이터의 범위를 제어할 수 있다.
--데이터 무결성 유지: 뷰를 사용하여 데이터를 수정하더라도, 이 변경사항이 기본 테이블의 데이터 무결성 규칙을 위반하지 않도록 관리할 수 있다.

CREATE VIEW EMPLOYEE_DETAILS AS
SELECT employee_id, last_name, department_id
FROM EMPLOYEES;

SELECT * FROM EMPLOYEE_DETAILS;

--Q. EMPLOYEES 테이블에서 salary가 10000원 이상인 직원만을 포함하는 뷰 special_employee를 생성하는 SQL 명령문을 작성하시오.
CREATE VIEW SPECIAL_EMPLOYEE AS
SELECT first_name||' '||last_name as Full_name, salary 급여
FROM EMPLOYEES
WHERE salary >= 10000
ORDER BY salary DESC;

SELECT * FROM SPECIAL_EMPLOYEE;

--Q. EMPLOYEES 테이블에서 각 부서별 직원 수를 포함하는 뷰를 생성하세요.
CREATE VIEW DEPARTMENT_EMPLOYEES AS
SELECT D.department_id "부서 no.", D.department_name "부서 이름", count(E.employee_id) "직원 수"
FROM DEPARTMENTS D
LEFT OUTER JOIN EMPLOYEES E ON D.department_id = E.department_id
GROUP BY D.department_id, D.department_name
ORDER BY "직원 수" DESC;

DROP VIEW DEPARTMENT_EMPLOYEES;

CREATE VIEW DEPARTMENT_EMPLOYEES AS
SELECT department_id, COUNT(*) AS 부서별_직원수
FROM EMPLOYEES
GROUP BY department_id
ORDER BY 부서별_직원수 ;

SELECT * FROM DEPARTMENT_EMPLOYEES;

--Q. EMPLOYEES 테이블에서 근속기간이 10년 이상인 직원을 포함하는 뷰를 생성하세요.
CREATE VIEW old_hand AS
SELECT last_name, trunc(sysdate-hire_date) AS 근속기간
FROM EMPLOYEES
WHERE trunc(sysdate-hire_date) > 365*10
ORDER BY 근속기간 DESC;

DROP VIEW old_hand;

SELECT * FROM old_hand;

--TCL (Transaction Control Language)
--COMMIT: 현재 트랜잭션 내에서 수행된 모든 변경(INSERT, UPDATE, DELETE 등)을 데이터베이스에 영구적으로 저장.
--COMMIT 명령을 실행하면, 트랜잭션은 완료되며, 그 이후에는 변경 사항을 되돌릴 수 없다.
--ROLLBACK: 현재 트랜잭션 내에서 수행된 변경들을 취소하고, 데이터베이스를 트랜잭션이 시작하기 전의 상태로 되돌린다. 
--오류가 발생했거나 다른 이유로 트랜잭션을 취소해야 할 경우에 사용된다.
--SAVEPOINT: 트랜잭션 내에서 중간 체크포인트를 생성합니다. 오류가 발생할 경우, ROLLBACK을 사용하여 최근의 SAVEPOINT까지 되돌릴 수 있다.
--트랜잭션을 콘트롤하는 TCL(TRANSACTION CONTROL LANGUAGE)

-- MEMBERS 테이블 생성
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS (
    member_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    join_date DATE,
    status VARCHAR2(20)
);

INSERT INTO members (member_id, name, email, join_date, status) VALUES (1, 'John Doe', 'john@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (2, 'Jane Doe', 'jane@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (3, 'Mike Smith', 'mike@example.com', SYSDATE, 'Inactive');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (4, 'Alice Johnson', 'alice@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (5, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (6, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');

SELECT * FROM MEMBERS;

SAVEPOINT sp1;
INSERT INTO members (member_id, name, email, join_date, status) VALUES (7, 'Bob Kim', 'bob@example.com', SYSDATE, 'Inactive');

ROLLBACK TO sp1;
COMMIT;



--팀 구성 및 연차별 salary
--각 부서마다 팀원은 몇 명이고 어떤 포지션들이 있고 구성은 어떻게 되는지
--ROLLUP() 은 다차원적인 집계 결과를 도출 : 사용 각 부서 및 직무별 직원 수를 집계
SELECT E.department_id, D.department_name, nvl(E.job_id, 'Total') job_id, count(*) 직원수
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D ON E.department_id = D.department_id
GROUP BY ROLLUP((E.department_id, D.department_name), E.job_id)
ORDER BY E.department_id;

--job_id 별 몇년차는 얼마 받는지 각 연차별로 salary 평균
SELECT job_id, 연차, round(avg(salary)) 평균급여
FROM ( SELECT job_id, floor(months_between(sysdate, hire_date)/12) AS 연차, salary FROM employees )
GROUP BY job_id, 연차
ORDER BY job_id, 연차;