/*
     동등조인 ( EQUI - JOIN ) == 내부조인 ( INNER JOIN )
     WHERE 절에 = 등호 연산자 사용
     A = B 공통된 값을 가진 행이 연결

*/
SELECT *
FROM 학생 a
    , 수강내역 b
WHERE a.학번 = b.학번; -- 학생테이블에 있는 학번이랑 수강내역테이블에 있는 학번을 조인함
/*만약 수강내역이 없는 학생도 조회 되어야 한다면
  외부조인 사용 (outer join)
 널값을 포함시킬 쪽에 (+)
 */

SELECT *
FROM 학생 a
    , 수강내역 b
WHERE a.학번 = b.학번(+) -- 학생테이블에 있는 학번이랑 수강내역테이블에 있는 학번을 조인함
AND a.이름 = '양지운';  -- 이렇게 양지운을 추가로 추출함

/*  sub query
    SQL문장 안에 보조로 사용되는 또는 또 다른 SELECT 문
    형태에 따라
    1. 일반 서브쿼리(스칼라 서브쿼리) : SELECT 절
    2. 인라인 뷰                      : FROM 절
    3. 중첩 쿼리                      : WHERE 절
*/

-- (1) select 절
SELECT a. emp_name
     , a. department_id
     , (SELECT department_name
        FROM departments
        WHERE department_id = a.department_id) as dep_nm
FROM employees a
    ,jobs b;

-- job 테이블의 타이틀을 출력하세요
SELECT a. emp_name
     , (SELECT department_name
        FROM departments
        WHERE department_id = a.department_id) as dep_nm
     , (SELECT job_title
        FROM jobs
        WHERE job_id = a.job_id) as job_title
FROM employees a;

--오류가 되는 경우
SELECT (SELECT emp_name
        FROM employees
        WHERE department_id = a.department_id) as emp_name
        -- 스킬라 서브 쿼리는 1=1 매핑이여야한다 1=m이면 오류
FROM departments a;

SELECT a. 이름
      ,b. 수강내역번호
      ,b. 과목번호  -- 과목번호를 사용하여 과목이름을 출력하세요
      , (SELECT 과목이름 -- 뭘 가져올거냐 
         FROM 과목 -- 어디서
         WHERE 과목번호 = b.과목번호) as 과목이름
FROM 학생 a
    ,수강내역 b
WHERE a.학번 = b.학번
AND   a. 이름 = '최숙경';

-- 의사 칼럼 ROWNUM
-- 테이블에는 없지만 있는것처럼 사용할수 있는,,
SELECT ROWNUM as rnum
     , a.*
FROM employees a;
WHERE ROWNUM <= 10; -- 몇건만 출력

-- (2) 인라인뷰 ( FROM절에 사용 SELECT문의 결과를 테이블처럼 사용)

SELECT *
FROM ( SELECT ROWNUM as rnum
                , a.*
       FROM employees a
        ) b
WHERE b.rnum BETWEEN 11 AND 20  -- between i and j 는 i ~j까지 출력
;


SELECT *
FROM ( 
     SELECT ROWNUM as rnum
            , a.*
       FROM (SELECT *
             FROM employees
             WHERE department_id = 50
             ORDER BY emp_name 
             ) a
     ) c
WHERE c.rnum BETWEEN 11 AND 20;
-- 특정테이블이 있는것처럼 사용되는거임 ,from 절이

-- 학생중 평점이 가장 높은 학생을 출력하세요
SELECT *
FROM (
    SELECT * 
    FROM 학생 
    ORDER BY 평점 DESC
         )
WHERE ROWNUM <= 1;


-- 학생 평점이 2번째로 높은 학생부터 ~ 4번째 학생까지 출력하세요
SELECT rnum, 이름, 평점
FROM (
        SELECT ROWNUM as rnum
         , a.*
        FROM (
                SELECT *
                FROM 학생
                ORDER BY 평점 DESC
                ) a
        ) b
WHERE rnum BETWEEN 2 AND 4;

-- (3) where 절
SELECT 이름, 평점
FROM 학생
WHERE 평점 >= (SELECT AVG(평점)
                FROM 학생);
-- 수강내역이 있는 학생을 조회하시오
SELECT 이름
FROM 학생
WHERE 학번 NOT IN(SELECT 학번
                  FROM 수강내역) ;

-- 직원의 평균 salary 보다 많이 받는 사원을 출력하세요

SELECT COUNT(*) as 사원수
FROM employees
WHERE salary >= (SELECT AVG(salary)
                 FROM employees);

--직원 요일별 입사인원수를 출력하세요
-- 월 화 수 목 금 토 일
-- 2  1  10 ...


SELECT NVL(년도, '합계') as 년도
     , SUM(일) as 일요일
     , SUM(월) as 월요일
     , COUNT(*) as 년도합계
FROM (
       SELECT TO_CHAR(hire_date, 'YYYY') as 년도
     , DECODE(TO_CHAR(hire_date, 'DAY'), '일요일', 1, 0) as 일
     , DECODE(TO_CHAR(hire_date, 'DAY'), '월요일', 1, 0) as 월
FROM employees
    )
GROUP BY ROLLUP(년도)
ORDER BY 1;


-- kor_loan_status 테이블을 활용하여
-- 년도별 기타대출 주택담보대출 년도합계를 출력하세요
SELECT NVL(년도, '합계') as 년도
     , COUNT(*) as 년도합계
     , SUM(loan_jan_amt)   as 대출합계
     
FROM (
        SELECT SUBSTR(period,1 ,4) as 년도
      , DECODE(SUBSTR(period,1 ,4), '기타대출', 1, 0) as 기타대출
      , DECODE(SUBSTR(period,1 ,4), '주택담보대출', 1, 0) as 기타대출
        FROM kor_loan_status
    )
GROUP BY SUBSTR(period,1 ,4);


SELECT NVL(년도, '합계') as 년도
     ,SUM(기타대출) as 기타대출합
     ,SUM(주택담보대출) as 주택담보대출합
     ,SUM(loan_jan_amt) as 년도합계
FROM (
        SELECT SUBSTR(period,1 ,4) as 년도
      , DECODE(gubun, '기타대출', loan_jan_amt, 0) as 기타대출
      , DECODE(gubun, '주택담보대출', loan_jan_amt, 0) as 주택담보대출
      , loan_jan_amt
        FROM kor_loan_status
     )
GROUP BY ROLLUP(년도)
ORDER BY 1;







