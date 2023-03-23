-- 문제 (1)
-- emplyees 테이블
-- 직원의 고용년도별 사원수, 총급여를 출력하시오

SELECT TO_CHAR(hire_date, 'YYYY') as 년도
     , COUNT(emp_name) as 사원수
     , SUM(salary) as 총급여
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY 2 DESC;

-- 문제 (2)
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

-- 문제 (3)
SELECT cust_marital_status
     , COUNT(*) as 사원수
FROM customers
WHERE cust_marital_status IS NOT NULL
GROUP BY cust_marital_status
ORDER BY 2 DESC;

-- 문제 (4)
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