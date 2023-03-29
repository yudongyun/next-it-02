/* VIEW 객체

    단순뷰
        - 하나의 테이블로 생성
        - 그룹 함수 사용 불가
        - distinct 불가
        - insert / update / delete 가능
    복합뷰
        - 어러 개의 테이블로 생성
        - 그룹 함수 사용가능
        - insert / update / delete 불가 

*/

CREATE OR REPLACE VIEW emp_dep AS
SELECT a.employee_id
    , a.emp_name
    , b.department_name
FROM employees a
    , departments b -- 테이블 두개썼으니까 복합뷰임
WHERE a.department_id = b.department_id;
-- 뷰 생성 권한 부여( DBA권한 있는쪽에서 실행 )
-- GRANT CREATE VIEW TO java;

-- 계정 생성
CREATE USER study IDENTIFIED BY study;
GRANT RESOURCE, CONNECT TO study;



SELECT * 
FROM emp_dep;

-- java 계정에서 실행
GRANT SELECT ON emp_dep TO study;

-- study 계정에서 실행
SELECT *
FROM java.emp_dep;

/* 
    시노님 synunym '동의어'란 뜻으로
    객체 각자의 고유한 이름에 대한 동의어를 만드는 것
    PUBLIC 모든 사용자
    PRIVATE 특정 사용자
*/


-- DBA 권한 있는쪽에서 시노님 생성 권한 부여
GRANT CREATE SYNONYM TO java;

CREATE OR REPLACE SYNONYM emp_v1
FOR employees;

GRANT SELECT ON emp_v1 TO study;

-- public 시노님은 DBA 권한이 있는 쪽에서 생성, 삭제 가능
CREATE OR REPLACE PUBLIC SYNONYM emp_v2
FOR java.employees;

-- public 시노님은 삭제도 DBA 권한이 있는쪽에서 가능
DROP PUBLIC SYNONYM emp_v2; -- 삭제
SELECT *
FROM emp_v2;

-- private 은 만든쪽에서 삭제 가능
DROP SYNONYM emp_v1; -- 삭제
SELECT *
FROM emp_v1;

---
/* 시퀀스 자동 순번을 반환하는 객체 */

CREATE SEQUENCE my_seq1
INCREMENT BY        1 --증강 숫자
START WITH          1 -- 시작 숫자
MINVALUE            1-- 최소 값
MAXVALUE            100 -- 최대값
NOCYCLE             -- 디폴트 최대 or 최소 도달시 생성 중지
NOCACHE             -- 디폴트 값을 할당해 놓지 않음.
;

SELECT my_seq1.NEXTVAL  -- 다음 순번
FROM dual;

SELECT my_seq1.CURRVAL  -- 현재 시퀀스 값
FROM dual;

CREATE TABLE ex8_1 (
    col1 number
);
INSERT INTO ex8_1 VALUES(my_seq1.NEXTVAL);

-- 최소값 1000, 최대값 99999999, 1000부터 시작해서 2씩 증가하는 시퀀스를 만드세요

CREATE SEQUENCE my_seqq
INCREMENT BY        2 --증강 숫자
START WITH          1000 -- 시작 숫자
MINVALUE            1000-- 최소 값
MAXVALUE            99999999 -- 최대값
;

SELECT my_seqq.NEXTVAL
FROM dual;

SELECT my_seqq.CURRVAL
FROM dual;

DROP SEQUENCE my_seqq;


--
/* ANSI 조인 FROM절에 조인조건 들어감 */
-- 일반 조인
SELECT a.employee_id
     , b.department_name
FROM employees a
     , departments b
WHERE a.department_id = b.department_id;

-- ANSI 조인
SELECT a.emp_name
     , b.department_name
     , department_id -- USING 을 쓰면 테이블 alias 안됨
FROM employees a
INNER JOIN departments b
-- ON (a.department_id = b.department_id);
USING(department_id); -- 컬럼명 같을경우 USING 사용 가능

-- 학생, 수강내역, 과목 테이블 ANSI INNER JOIN 사용하여
-- 최숙경의 학번, 수강내역번호, 과목명을 출력하세요

SELECT a.이름
     , b.수강내역번호
     , c.과목이름
FROM 학생 a
INNER JOIN 수강내역 b
ON (a.학번 = b.학번)
INNER JOIN 과목 c
ON (b.과목번호 = c.과목번호)
WHERE a.이름 = '최숙경';

-- OUTER JOIN
-- 일반
SELECT *
FROM 학생, 수강내역, 과목
WHERE 학생.학번 = 수강내역.학번(+)
AND 수강내역.과목번호 = 과목.과목번호(+);

-- ANSI JOIN
SELECT *
FROM 학생
LEFT OUTER JOIN 수강내역
ON(학생.학번 = 수강내역.학번) -- USING (학번)
LEFT OUTER JOIN 과목
ON(수강내역.과목번호 = 과목.과목번호);  -- USING (과목번호 )

-- right // FROM절을 반대로 놓으면 된다. /보통 레프트 조인을 씀
SELECT *
FROM 수강내역
RIGHT OUTER JOIN 학생
ON(학생.학번 = 수강내역.학번); -- USING (학번)

SELECT *
FROM 학생, 수강내역
WHERE 학생.학번(+) = 수강내역.학번(+);

CREATE TABLE ex_a (
    emp_id number
);

CREATE TABLE ex_b (
    emp_id number
);
-- a
INSERT INTO ex_a VALUES(10);
INSERT INTO ex_a VALUES(20);
INSERT INTO ex_a VALUES(40);
-- b
INSERT INTO ex_b VALUES(10);
INSERT INTO ex_b VALUES(20);
INSERT INTO ex_b VALUES(30);
commit;

--a
SELECT *
FROM ex_a;

--b
SELECT *
FROM ex_b;

SELECT *
FROM ex_a, ex_b
WHERE ex_a.emp_id(+) = ex_b.emp_id; -- 기존에는 한쪽에만 (+) 사용이 가능한데

-- ANSI FULL OUTER JOIN 양쪽 널포함
SELECT *
FROM ex_a
FULL OUTER JOIN ex_b
ON(ex_a.emp_id = ex_b.emp_id);  -- 이러면 양쪽에 전체 행이 포함되어서 결과가 출력된다

-- '연도별' 이태리 최대매출액과 최대 매출을 올린 사원을 출력하세요
-- 세일즈, 엠플로이, 커스토머 테이블 사용
-- 임플로이 아이디 사용
-- 매출은 amount_sold 사용
-- 1. 년도별 직원별 매출합
-- 2. 1의 년도별 max(매출합)
-- 3. 1과 2조인

SELECT *
FROM sales a
    ,employees b
WHERE a.employee_id = b.employee_id;

--
SELECT SUBSTR(sales_month, 1, 4) as 년도
    , ROUND(SUM(a.amount_sold)) as 매출합
FROM sales a
    ,employees b
    ,countries c
    ,customers d
WHERE a.employee_id = b.employee_id
AND c.country_id = d.country_id
AND a.cust_id = d.cust_id
AND c.country_name LIKE '%Italy%'
GROUP by SUBSTR(sales_month, 1, 4);







