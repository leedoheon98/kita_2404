-----------------------------------------------------------------------------------------------------------
--                       [ 실습 ]

-- * 현재 hr에 있는 7개 테이블들을 분석해서 인사관리에 의미있는 인사이트 5개 이상을 기술하세요.
-- * 인사관리 개선을 위한 KPI 2개를 설정하고 이것들을 테이블들의 데이터에 반영한 후 다시 분석해서 반영 여부를 검증

-----------------------------------------------------------------------------------------------------------

--KPI NO.1
--COMMISSION_PCT가 있는 직원 중에
--해당 직무의 MIN_SALARY MAX_SALARY 의 평균 중에 어느 정도 구간에 속하는지 (WIDTH_BUCKET)
--상위 10퍼

--KPI NO.2
--(SYSDATE-HIREDATE) 의 평균, 그리고 직무의 (MIN_SALARY MAX_SALARY) 의 평균에 비해 어느정도 높거나 낮은지

--KPI NO.3
--JOB_HISTORY 를 이용하여 BETWEEN ST_DATE AND END_DATE 직원수/ 총 직원수 * 100 으로 이직률을 추출 후 10% 이하인지 확인.


--------------------------------------    CASE 1. 부서 별, 직무 별, 직원 조회

-- 각 부서 이름과 부서 별 직원 조회
SELECT
    D.department_id,
    D.department_name, 
    E.first_name||' '||last_name "Full name"
FROM
    DEPARTMENTS D
LEFT OUTER JOIN EMPLOYEES E
    ON D.department_id=E.department_id;

-- 각 직무 이름과 직무 별 직원 조회
SELECT
    J.job_id,
    J.job_title, 
    E.employee_id,
    E.first_name||' '||last_name "Full name"
FROM
    JOBS J
LEFT OUTER JOIN EMPLOYEES E
    ON J.job_id=E.job_id;

    

--------------------------------------    CASE 2. 부서 별, 직무 별, 직원 수
SELECT
    D.department_id AS dept_id,
    D.department_name as dept_name,
    COUNT(E.employee_id) AS count
FROM
    DEPARTMENTS D
LEFT OUTER JOIN EMPLOYEES E 
    ON D.department_id = E.department_id
GROUP BY
    D.department_id, D.department_name
ORDER BY dept_id;

SELECT
    J.job_id,
    J.job_title,
    COUNT(E.employee_id) AS count
FROM
    JOBS J
LEFT OUTER JOIN EMPLOYEES E 
    ON J.job_id = E.job_id
GROUP BY
    J.job_id, J.job_title
ORDER BY job_id;



--------------------------------------    CASE 3. 부서를 할당받지 않은 신입에게 적합한 부서 배정하기

-- department_id 가 null인 직원을 조회할 수 있는 뷰 생성.
DROP VIEW dept_id_null;
CREATE VIEW dept_id_null AS
SELECT *
FROM EMPLOYEES
WHERE department_id IS NULL;


SELECT * FROM dept_id_null;

-- null 값을 바꿔주기 전에 원본 데이터 보존을 위해 SAVEPOINT 설정.
SAVEPOINT before_replace_null;

-- UPDATE 문을 사용하여 job_id 에 맞는 department_id 로 설정
UPDATE EMPLOYEES
SET department_id = (
    SELECT department_id
    FROM JOB_HISTORY
    WHERE job_id in ( SELECT job_id FROM dept_id_null )
)
WHERE department_id IS NULL;

-- 뷰 조회
SELECT * FROM dept_id_null;
-- EMP_ID 170 ~ 180 까지 변경된 테이블 조회
SELECT employee_id, first_name, job_id, department_id 
FROM EMPLOYEES 
WHERE employee_id between 170 and 180
ORDER BY employee_id;

-- 원본 테이블로 다시 롤백해주고 한번 더 뷰랑 테이블 확인해보기
ROLLBACK TO before_replace_null;




--------------------------------------    CASE 4. 지사별 인건비 지출

SELECT  d.department_name AS "부서명", l.city AS 도시, l.location_id AS "지사 No", SUM(e.salary) as "인건비 지출"
FROM departments d
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN employees e ON d.department_id = e.department_id
--WHERE D.location_id = '1700' --지사 No 입력.
GROUP BY d.department_name, l.city, l.location_id; 




--------------------------------------    CASE 5. 부서별 성과 분석
--Employees 테이블과 Departments 테이블을 활용하여 부서별 평균 근속 연수, 평균 급여 등을 분석합니다.

SELECT
    d.department_id,
    d.department_name,
    TRUNC(AVG(MONTHS_BETWEEN(SYSDATE, e.hire_date) / 12)) AS avg_tenure_years,
    TRUNC(AVG(e.salary)) AS avg_salary
FROM
    Employees e
JOIN
    Departments d ON e.department_id = d.department_id
GROUP BY
    d.department_id,
    d.department_name;









---------------------------     KPI NO.1  연차 대비 연봉이 얼마나 높은가를 통하여
---------------------------------         해당 직원이 얼마나 좋은 성과를 보이는가를 평가.


WITH Avg_Job_Stats AS (      -- 직무 별 평균 연차와 평균 연봉을 EMPLOYEES 테이블에서 추출하는 쿼리
    SELECT 
        job_id, 
        AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))) AS avg_tenure, 
        AVG(SALARY) AS avg_salary
    FROM 
        EMPLOYEES
    GROUP BY 
        job_id
),
-- 평균연차와 평균연봉을 JOIN 시켜 비율을 구한 뒤
-- 연봉은 평균에 비해 높을수록 연차는 평균에 비해 낮을수록 좋은 형태로 score 칼럼 저장
Employee_Scores AS (    
    SELECT 
        E.EMPLOYEE_ID,
        E.JOB_ID,
        E.FIRST_NAME || ' ' || E.LAST_NAME AS FULL_NAME,
        TRUNC(MONTHS_BETWEEN(SYSDATE, E.HIRE_DATE)) AS tenure,
        E.SALARY,
        (TRUNC(MONTHS_BETWEEN(SYSDATE, E.HIRE_DATE)) - AJS.avg_tenure) AS tenure_diff,
        (E.SALARY - AJS.avg_salary) AS salary_diff,        
        ((E.SALARY - AJS.avg_salary) / AJS.avg_salary - 
         (TRUNC(MONTHS_BETWEEN(SYSDATE, E.HIRE_DATE)) - AJS.avg_tenure) / AJS.avg_tenure) AS score
    FROM 
        EMPLOYEES E
    JOIN 
        Avg_Job_Stats AJS ON E.JOB_ID = AJS.JOB_ID
),
-- 각 직무 별 상위 10%를 도출하기 위해 percent_rank() 함수 사용
Ranked_Employees AS (
    SELECT 
        ES.*,
        PERCENT_RANK() OVER (PARTITION BY ES.JOB_ID ORDER BY ES.score DESC) AS percentile_rank
    FROM 
        Employee_Scores ES
)
SELECT 
    EMPLOYEE_ID,
    JOB_ID,
    FULL_NAME,
    trunc(tenure/12) AS "연차(년)",
    TO_CHAR(SALARY, 'L999,999') AS "연봉",
    round(score, 2) AS "점수",
    round(percentile_rank, 2) AS "상위"
FROM 
    Ranked_Employees
WHERE 
    percentile_rank <= 0.1;

