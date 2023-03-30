
SELECT department_id
    , parent_id
    , LPAD(' ' , 3 * (LEVEL -1)) || department_name as 부서명
    , LEVEL -- 가상-열트리 내에서 더떤 단계(level)에 있는지 나타내는 정수 값
FROM departments
START WITH parent_id is NULL
CONNECT BY PRIOR department_id = parent_id;

-- 부서테이블에 department_id ; 280
--              부서명 : DB팀
--              상위부서 : IT 헬프데스크
--              데이터를 삽입하고 출력하세요

INSERT INTO departments (department_id, parent_id, department_name)
VALUES (280, 230, 'DB팀');
COMMIT;

-- employee_id 와 manager_id 를 이용하여
-- 직원의 계층관계를 출력하세요
-- 최상위 직원은 스티븐 킹

SELECT employee_id
    , manager_id
    , LPAD(' ' , 3 * (LEVEL -1)) || a.emp_name as 이름
    , LEVEL -- 가상-열트리 내에서 더떤 단계(level)에 있는지 나타내는 정수 값
    , CONNECT_BY_ISLEAF as leaf -- 마지막 노드면 1, 자식이 있으면 0
    , SYS_CONNECT_BY_PATH(emp_name, '|') as depth
FROM employees a
START WITH a.manager_id is NULL
CONNECT BY PRIOR a.employee_id = a.manager_id;

/*
     테이블을 생성하고
     데이터를 입력하여
     아래와 같이 출력하도록 계층형 쿼리를 만들어 출력하세요 
     이름      직책      레벨
     이사장  사장         1
     김부장    부장       2
     서차장     차장      3
     장과장      과장     4
     이대리       대리    5
     박과장      과장     4
     김대리       대리    5
     강사원         사원  6

*/
SELECT *
FROM ex9_1;

DROP TABLE ex9_1;


CREATE TABLE ex9_1 (
         이름 VARCHAR2(10)
       , 직책 VARCHAR2(10)
       , m_id VARCHAR2(10)
       , em_id VARCHAR2(10));
INSERT INTO ex9_1(이름, 직책, m_id, em_id) VALUES('이사장', '사장', 10, null);
INSERT INTO ex9_1(이름, 직책, m_id, em_id) VALUES('김부장', '부장', 20, 10);
INSERT INTO ex9_1(이름, 직책, m_id, em_id) VALUES('서차장', '차장', 30, 20);
INSERT INTO ex9_1(이름, 직책, m_id, em_id) VALUES('장과장', '과장', 40, 30);
INSERT INTO ex9_1(이름, 직책, m_id, em_id) VALUES('이대리', '대리', 50, 40);
INSERT INTO ex9_1(이름, 직책, m_id, em_id) VALUES('박과장', '과장', 60, 30);
INSERT INTO ex9_1(이름, 직책, m_id, em_id) VALUES('김대리', '대리', 70, 40);
INSERT INTO ex9_1(이름, 직책, m_id, em_id) VALUES('강사원', '사원', 80, 50);
INSERT INTO ex9_1(이름, 직책, m_id, em_id) VALUES('최사원', '사원', 90, 50);
INSERT INTO ex9_1(이름, 직책, m_id, em_id) VALUES('하사원', '사원', 100, 50);

SELECT 이름
    , LPAD(' ' , 3 * (LEVEL -1)) || 직책 as 직책명
    , LEVEL -- 가상-열트리 내에서 더떤 단계(level)에 있는지 나타내는 정수 값
FROM ex9_1
START WITH em_id is NULL
CONNECT BY PRIOR m_id = em_id;

--
SELECT '2013' || LPAD(LEVEL, 2, '0') as 월
FROM dual
CONNECT BY LEVEL <= 12;

SELECT period
    , SUM(loan_jan_amt) as amt
FROM kor_loan_status
WHERE period LIKE '%2013%'
GROUP BY period;

-- 데이터 값 넣기
SELECT a.월
     , NVL(b.amt, 0) as amt
FROM (SELECT '2013' || LPAD(LEVEL, 2, '0') as 월
        FROM dual
        CONNECT BY LEVEL <= 12) a  --201301 ~ 201312 생성한 년월
    ,(SELECT period
            , SUM(loan_jan_amt) as amt
            FROM kor_loan_status
            WHERE period LIKE '%2013%'
            GROUP BY period) b
WHERE a.월 = b.period(+)            -- 201310, 201311년월 밖에 없음
ORDER BY 1;                         -- 년월에 null 값이 있는쪽에 아우터 조인

-- 이번달 1일부터 ~ 마지막날 까지 출력하세요
-- 20230301 ~ 20230331

SELECT TO_CHAR(LAST_DAY(TO_DATE(:months, 'YYYYMM')), 'DD')
FROM dual;

SELECT TO_DATE(:months, 'YYYYMM')
FROM dual;

SELECT :months || LPAD(LEVEL, 2, '0') as 일자
FROM dual
CONNECT BY LEVEL <= 31;

SELECT :months ||LPAD(LEVEL, 2, '0')
FROM dual
CONNECT BY LEVEL <= 
    TO_CHAR(LAST_DAY(TO_DATE(:months, 'YYYYMM')), 'DD');
    -- 1. 입력값이 문자열 YYYYMM -> DATE 타입으로 변환
    -- 2. DATE 타입은 LAST_DAY로 월 마지막날을 구할수 있음
    -- 3. 마지막 날짜의 DATE타입에서 TO_CHAR로 일자를 구할수있음

-- customer 테이블의 cust_year_of_birth를 활용하여
-- 10대 20대 ~~ 의 인원수를 구하시오
-- 1. 나이계산
-- 2. 나이로 10대 20대 ~ 를 구별할수 있도록 데이터 만들기
-- 3. 2로 인원수 집계
-- 4. level이용하여 10대부터 출력

-- 나이
SELECT trunc(TO_CHAR((2023 - cust_year_of_birth) / 10)) || '0대'as 나이
     , COUNT(*) 인원수
FROM customers 
GROUP BY trunc(TO_CHAR((2023 - cust_year_of_birth) / 10));

SELECT RPAD(LEVEL, 2, '0') || '대'
FROM dual
CONNECT BY LEVEL <= 2;

SELECT a. 대 || '0대' as 년도
     , NVL(b. 인원수, 0)  as 인원
FROM ( SELECT LEVEL as 대
       FROM dual
       CONNECT BY LEVEL <= 11
       )  a
   , (SELECT trunc(TO_CHAR((2023 - cust_year_of_birth) / 10)) as 년대
             , COUNT(*) 인원수
        FROM customers 
        GROUP BY trunc(TO_CHAR((2023 - cust_year_of_birth) / 10))
        )  b
WHERE a.대 = b.년대(+)
order by a.대;





