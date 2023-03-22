/*
 수식 연산자 +-* / 숫자 데이터 타입에 사용가능
*/
SELECT employee_id
     , emp_name
     , salary / 30          AS 일당
     , salary /             AS 월급
     , salary - salary * 01 AS 실수령액
     , salary * 12          AS 연봉
FROM employees;
/* 논리 연산자 > < >= <= != <> ^= */
SELECT * FROM employees WHERE salary = 2600; -- 같다
SELECT * FROM employees WHERE salary <>2600; -- 같지 않다
SELECT * FROM employees WHERE salary != 2600; -- 같지 않다
SELECT * FROM employees WHERE salary ^= 2600; -- 같지 않다
SELECT * FROM employees WHERE salary < 2600; -- 미만
SELECT * FROM employees WHERE salary > 2600; -- 초과
SELECT * FROM employees WHERE salary <= 2600; -- 이하
SELECT * FROM employees WHERE salary >= 2600; -- 이상
-- 직원중에 30, 50번 부서가 아닌 직원만 출력하시오

SELECT emp_name
     , department_id
FROM employees
WHERE department_id != 30
AND department_id != 50;


/* IN 조건식
*/
SELECT *
FROM employees
WHERE department_id IN (30, 50, 60); -- 포함하는 (and)

-- NOT 논리 조건식
SELECT *
FROM employees
WHERE department_id NOT IN (30, 50, 60); -- 미 포함하는 (and)

/* 표현식 특정조건일때 표현을 바꾸는
*/

-- 5000 이하 'c등급', 5000초과 15000 이하 'b등급' 
-- 그 밖에 'a등급'
SELECT employee_id
     , emp_name
     , salary
     , CASE WHEN salary <= 5000 THEN 'c등급'
            WHEN salary > 5000 AND salary >= 15000 THEN 'b등급'
           ELSE 'a등급'     
        END as grade
FROM employees;

-- CUSTOMER 테이블에서 성별 정보 F -> '여자' M -> '남자' 로
-- 표현식을 사용하여 출력하시오

SELECT cust_name
     , cust_gender
     , CASE WHEN cust_gender ='F' THEN '여자'
            WHEN cust_gender ='M' THEN '남자'
       END as gender
FROM customers;

/* LIKE 조건식 (많이사용)  */
SELECT emp_name
FROM employees
-- WHERE emp_name LIKE 'A%'   --- A로 시작하는 ~ // %가 앞에있으면 A로 끝나는 ~ //  %가 앞뒤에있으면 A가 포함된 ~
WHERE emp_name LIKE '%'||:a||'%' -- 바인드 테스트
;

CREATE TABLE ex3_1(
    nm VARCHAR2(100)
);
INSERT INTO ex3_1 VALUES ('홍길');
INSERT INTO ex3_1 VALUES ('홍길동');
INSERT INTO ex3_1 VALUES ('홍길동님');

SELECT *
FROM ex3_1
WHERE nm LIKE '홍___';  -- LIKE 길이 정확히 일치 _ <- 사용

--tb_info 에서 김씨만 조회

SELECT nm
FROM TB_INFO
WHERE nm LIKE '%윤';

---------------------------------------------------------
/* 문자함수 : 문자 함수는 연산 대상이 문자이며 반환 값은
             함수에 따라 문자 or 숫자를 반환
*/
-- UPPER(char) 대문자로
-- LOWER(char) 소문자로
SELECT emp_name
     , UPPER(emp_name) as 대문자
     , UPPER('hi')
     , LOWER(emp_name) as 소문자
FROM employees;
-- 검색조건으로 대문자 or 소문자가 들어와도 검색이 되게 하려면 ?
SELECT emp_name
FROM employees
WHERE UPPER(emp_name) = UPPER('DOUglas grant');

SELECT emp_name
FROM employees
WHERE UPPER(emp_name) LIKE '%'||UPPER(:nm)||'%';

-- SUBSTR 문자열 자르기
-- SUBSTR(char, pos, len) 대상 문자열 char 를 pos 번째 부터
--                        len 길이 만큼 자른뒤 반환
--                        pos 값으로 0 이오면 디폴트 1(첫번째 문자열)
--                                  음수가 오면 뒤에서 부터
--                        len 값이 생략되면 pos 번째 부터 끝까지
SELECT emp_name
     , SUBSTR(emp_name, 10, 2)
     , SUBSTR(emp_name, 4)
     , SUBSTR(emp_name, -4, 1)
FROM employees;

/* INSTR 위치 반환
   INSTR(char, n, pos, len) char 대상문자열부터 n을 찾음
                            pos 부터 len 번째 대상의 시작 위치를 반환
                            pos, len 디폴트 1
*/
SELECT INSTR('abcabc', 'b', 1,1 ) -- 1번째 위치에서 첫번째 b를 반환해라
     , INSTR('abcabc', 'b', 1,2)
     , INSTR('abcabc', 'b')
     , INSTR('abcabc', 'b', 3,1 )
FROM DUAL; ---테스트 테이블
-- TB_INFO 의 email 컬럼에서 @의 위치를 출력하세요
-- 1번의 위치값을 활용하여 id와 domain 정보를 출력해라

SELECT EMAIL
     , SUBSTR(EMAIL, 1,INSTR(EMAIL, '@') -1 )  as ID
     , SUBSTR(EMAIL, INSTR(EMAIL, '@')+1) as DOMAIN
     , INSTR(EMAIL, '@') -1 as 골뱅이위치
FROM TB_INFO;

/* REPLACE 치환 */ -- 특정문자열을 바꾸는 기능
   -- REPLACE(char, n, m) 대상 문자열 char에서 n을 찾아서 m으로 변경
   
   
SELECT REPLACE('abcd', 'a', 'A')
FROM DUAL;
/* TRIM 공백제거 LTRIM : 왼쪽, RTRIM : 오른졲 */
SELECT TRIM(' hi ')
     , LTRIM(' hi ') -- 왼쪽만
     , RTRIM(' hi ') -- 오른쪽만
FROM DUAL;

/* LPAD : 왼쪽채움  RPAD : 오른쪽채움
   LPAD(char, 5, '0')   -->> char를 5자리로 만듬( 0 을채워서)
*/
SELECT LPAD('a',5,'0')
      ,LPAD('ab',5,'0')
      ,RPAD('ab',5,'0')
FROM DUAL;

-- LENGTH <-- 문자열 길이 반환
SELECT emp_name
     , LENGTH(emp_name) -- 문자열 길이
FROM employees;     



-- CUSTOMERS 테이블에서 cust_main_phone_number 컬럼의
-- 데이터를 *로 마스킹처리하고 뒤 2자리만 출력되게 하세요

SELECT cust_main_phone_number
     ,LPAD(SUBSTR(cust_main_phone_number, 11, 12), 12, '*') as 숨긴번호
     ,LENGTH(cust_main_phone_number)
FROM customers;
























