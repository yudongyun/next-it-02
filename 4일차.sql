SELECT *
FROM member;
/* member 테이블에서 대전 서구에 사는 여자들만 출력해라

SELECT mem_id
     ,mem_name
     ,mem_mail
     ,mem_add1
     , CASE WHEN SUBSTR(mem_regno2,1,1) = '1' THEN '남자'
            WHEN SUBSTR(mem_regno2,1,1) = '2' THEN '여자'
        END as gender
FROM member
WHERE mem_add1 LIKE '%대전%' 
AND   mem_add1 LIKE '%서구%' ;

/* 숫자함수 
*/
SELECT ROUND(10.5904, 2)  -- 반올림
     , ROUND(10.5904, 1)
     , ROUND(10.5904)
     , ROUND(16.5904, -1)  -- 소수점기준 왼쪽 반올림
     , TRUNC(10.5904, 1)   -- 버림
     , MOD(4, 2) -- 나머지 반환 
     , MOD(5, 2) -- 앞에 있는숫자를 뒤에 있는 숫자로 나눈 뒤 나머지 값
FROM dual;

/* 날짜 함수 */
SELECT SYSDATE  -- 현재시간
     , SYSTIMESTAMP   
     , SYSDATE + 1 -- 날짜 데이터  <-- 다음날의 날짜 데이터
FROM dual; 
-- ADD_MONTHS
SELECT ADD_MONTHS(SYSDATE, 1) -- 다음달 날짜 반환
     , ADD_MONTHS(SYSDATE, -1) -- 전달 날짜 반환
     , LAST_DAY(SYSDATE)     -- 해당월의 마지막 날짜 반환
FROM dual;

-- 이번달이 몇일 남았는지 출력 하시오
SELECT LAST_DAY(SYSDATE) - SYSDATE as 남은날짜ㅠㅠ
FROM dual;
-- NEXT_DAY
SELECT NEXT_DAY(SYSDATE, '목요일') -- 오늘이 목요일이면 다음주 목요일 반환함
     , NEXT_DAY(SYSDATE, '금요일')
FROM dual;

SELECT mem_name
     , mem_bir
     , ROUND((ROUND(SYSDATE) - mem_bir) / 365) AS 나이
FROM member
ORDER BY 3 ASC;

SELECT ROUND(SYSDATE, 'month')
     , ROUND(SYSDATE, 'year')
     , ROUND(SYSDATE, 'month')
     , ROUND(SYSDATE, 'day')
FROM dual;
/* 변환함수 TO_CHAR 문자타입 으로
            TO_NUMBER 숫자타입으로
            TO_DATE 날짜타입으로 변환
*/
SELECT TO_CHAR(123456789, '999,999,999')
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD' )
     , TO_CHAR(SYSDATE, 'YYYY*MM*DD' )
     , TO_CHAR(SYSDATE, 'YYYY' )
     , TO_CHAR(SYSDATE, 'YYYYMMDD HH24:MI:SS' )
     , TO_CHAR(SYSDATE, 'YYYYMMDD HH12:MI:SS' )
FROM dual;

SELECT TO_DATE('20220101', 'YYYYMMDD')
FROM dual;
CREATE TABLE ex4_1 (
     col1 VARCHAR2(1000)
);
INSERT INTO ex4_1 VALUES('111');
INSERT INTO ex4_1 VALUES('99');
INSERT INTO ex4_1 VALUES('1111');

SELECT *
FROM ex4_1
ORDER BY TO_NUMBER(col1) DESC;


-- 데이계산
CREATE TABLE tb_myday(
      mem_id VARCHAR2(100)
     ,d_title VARCHAR2(1000)
     ,d_day VARCHAR2(8)
);
INSERT INTO tb_myday VALUES('a001', '연인이 된날', '20170815');
INSERT INTO tb_myday VALUES('a001', '과정 시작일', '20230320');
-- 1. a001 회원의 과정 시작일로부터 100일의 날짜
-- 2. 1번의 결과(100일) 일자까지 몇일 남았는지
-- 3. 과정시작일 부터 몇일이 지났는지 출력하시오 (네이버 d-day 기준)
SELECT *
FROM tb_myday;

SELECT TO_DATE(d_day, 'YYYY-MM-DD' ) as 현재날짜
     , TO_CHAR(TO_DATE(d_day) + 99, 'YYYY.MM.DD') as 백일
     , TO_DATE(d_day) + 99 - ROUND(SYSDATE) as 남은날
     , ROUND(SYSDATE) - TO_DATE(d_day) as 지난날
FROM tb_myday
WHERE mem_id = 'a001'
AND d_title LIKE '%과정%';

/*NULL 관련 함수 NVL*/
SELECT emp_name
     , salary
     , NVL(commission_pct, 0) -- 값이 null일 경우 0 으로
     , salary + salary * NVL(commission_pct,0) as 이번상여금
FROM employees;

SELECT emp_name
     , NVL(commission_pct,0)
FROM employees
WHERE NVL(commission_pct,0) < 0.2;

/* 집계함수 AVG, MIN, MAX, SUM, COUNT*/
SELECT COUNT(*)   -- null 포함 // 전체 행수 ( 사원수 )
     , COUNT(department_id) -- default all ( 1개 행은 부서id가 없다는 뜻)
     , COUNT(ALL department_id) -- null 제외, 중복 포함
     , COUNT(DISTINCT department_id) -- 중복 제외 ( 11개의 부서가 있다.)
FROM employees;

SELECT SUM(salary)
     , ROUND(AVG(salary), 2)
     , MIN(salary)
     , MAX(salary)
FROM employees;

-- menber 테이블을 활용하여 회원의 수를 출력하시오
-- 평균 마일리지
SELECT COUNT(*) as 회원수
     , ROUND(AVG(mem_mileage), 1) as 평균마일리지
FROM member;

/*GROUP BY, HAVING*/
SELECT department_id
     , COUNT(*) as 사원수
FROM employees
WHERE department_id IS NOT NULL --( 널이 아닌것만 조회 )
GROUP BY department_id  -- 부서별
HAVING COUNT(*) >= 5    -- 집계결과에서 검색조건 (사원수가 5명 이상인)
ORDER BY 1; 

SELECT department_id
      ,job_id
      ,COUNT(*) as 사원수
FROM employees
GROUP BY department_id
        ,job_id  -- SELECT 절에 있는건 GROUP BY 절에 포함 되어야함
ORDER BY 1;

-- member 회원의 직업별 회원수와 평균 마일리지를 출력하세요

SELECT mem_job
      ,COUNT(mem_job) as 회원수
      ,ROUND(AVG(mem_mileage), 2) as 평균마일리지
FROM member
GROUP BY mem_job
HAVING COUNT(*) >= 3
ORDER BY 3 DESC;

-- 년도별 대출합계
SELECT SUBSTR(period,1 ,4) as 년도
     , SUM(loan_jan_amt)   as 대출합계
FROM kor_loan_status
GROUP BY SUBSTR(period,1 ,4)
ORDER BY 1;
-- 2013년도 지역별 대출합계
SELECT region
     , SUM(loan_jan_amt)
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY region;

-- emplyees 테이블
-- 직원의 고용년도별 사원수, 총급여를 출력하시오

SELECT TO_CHAR(hire_date, 'YYYY') as 년도
     , COUNT(emp_name) as 사원수
     , SUM(salary) as 총급여
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY 2 DESC;

-- emplyees 테이블
-- 3월에 고용된 직원 수 출력

--SELECT TO_char(hire_date, 'mm') as 월
SELECT  COUNT(emp_name) as 사원수
FROM employees
WHERE TO_CHAR(hire_date, 'mm') LIKE '03';
--WHERE SUBSTR(hire_date, 3, 4) LIKE '%03%'
--GROUP BY TO_CHAR(hire_date, 'mm');

-- customers 테이블 에서
-- cust_marital_status 별 고객수를 출력해주세요
-- cust_marital_status 널 제외

SELECT cust_marital_status
     , COUNT(*) as 사원수
FROM customers
WHERE cust_marital_status IS NOT NULL
GROUP BY cust_marital_status
ORDER BY 2 DESC;

-- product를 활용하여 카테고리, 서브카테고리별 상품수를 출력하시오
-- 상품수 3개 이상만 출력 ( 정렬 : 카테고리 오름차순)
SELECT prod_category
     , prod_subcategory
     , COUNT(*) as 상품수
FROM products
GROUP BY prod_category
     , prod_subcategory
HAVING COUNT(*) >= 3
ORDER BY 1 ASC;







