/* 정규표현식
    .(dot) 임의의 1글자를 의미함
    [] <-- 임이의 1글자를 의미함
    '^' <-- 시작
    [^] <-- not 
    ? 0 or 1 회
    + 1회 이상
    * 0회 이상
*/
-- REGEXP_LIKE (대상문자열, 정규표현식)
SELECT mem_hometel
FROM member
WHERE REGEXP_LIKE(mem_hometel, '...-9');

--시작 숫자 2자리- <-- 출현하는 전화번호 고객을 조회하세요

SELECT mem_hometel
FROM member
WHERE REGEXP_LIKE(mem_hometel, '^..-');

-- {n} 정확히 n회 매치
-- {n,} n회 이상
-- {n, m} n ~ m 매치

-- mem_mail이 소문자 3자리@ ex)abc@gmail.com 인 회원을 조회

SELECT mem_mail
    ,  mem_name
FROM member
WHERE REGEXP_LIKE(mem_mail, '^[a-z]{3}@');

-- $<-- 끝을 의미함
-- () <-- 패턴 그룹
-- | < -- 또는

WITH T1 AS(
        SELECT '(02)456-1234' as nums 
        FROM dual
        UNION
        SELECT '(042)456-1234' as nums 
        FROM dual
        UNION
        SELECT '(0700)456-1234' as nums 
        FROM dual
        UNION
        SELECT '010-456-1234' as nums 
        FROM dual
) -- (숫자2) or (숫자3) 패턴인 데이터만 조회하시오 ( <-- 포함
SELECT *
FROM t1
WHERE REGEXP_LIKE(nums, '\([0-9]{2,3}\)');
--WHERE REGEXP_LIKE(nums, '(\([0-9]{2}\))|(\([0-9]{3}\))'); -- 둘다 가능함

-- 숫자와 -만 있는 데이터를 출력하세요
SELECT mem_name, mem_add2
FROM member
--WHERE REGEXP_LIKE(mem_add2, '^[0-9]{1,}-[0-9]{1,}+$'); -- 이거도 가능
WHERE NOT REGEXP_LIKE(mem_add2, '^[0-9\-]+$'); -- NOT 도 가능

-- 한글만 있는 회원
SELECT mem_name, mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '^[가-힣]+$'); -- NOT 도 가능

-- 한글 - 공백 - 숫자 패턴을 조회하세요
SELECT mem_name, mem_add2
FROM member
WHERE REGEXP_LIKE(mem_add2, '[가-힣] [0-9]'); -- NOT 도 가능

-- D로 시작하며 세번째 문자가 u or n 인 직원을 출력하세요
SELECT emp_name
FROM employees
WHERE REGEXP_LIKE(emp_name, '^D.(u|n)', 'i'); -- NOT 도 가능 --뒤에 i를 넣으면 대소문자 구별없이 조회가능 / 디폴트는 구별함

-- REGEXP_SUBSTR
SELECT REGEXP_SUBSTR(mem_mail, '[^@]+', 1, 1) as id
    ,  REGEXP_SUBSTR(mem_mail, '[^@]+', 1, 2) as domain
FROM member;

    --( 대상문자, 패턴, 시작위치, 매칭순번)
SELECT REGEXP_SUBSTR('A-01-02', '[^-]+', 1, 1) as a1
    ,  REGEXP_SUBSTR('A-01-02', '[^-]+', 1, 2) as a2 
    ,  REGEXP_SUBSTR('A-01-02', '[^-]+', 1, 3) as a3
FROM dual;

-- member mem_add1 에서 첫번째 단어만 출력하세요
-- SELECT REGEXP_SUBSTR(mem_add1, '[^ ]*') as a1
SELECT REGEXP_SUBSTR(mem_add1, '[^ ]+', 1, 1) as a1
FROM member;

-- REGEXP_REPLACE
SELECT REGEXP_REPLACE('Ellen Hildi Smith','(.*) (.*) (.*)','\3, \1 \2') as text1
    ,  REGEXP_REPLACE('Joe      Smith', '( ){2,}',' ') as text2
    ,  REPLACE('Joe      Smith','  ', ' ') as text3
FROM dual;

-- member 테이블에서 mem_add1 대전이 포함되어 있는 주소를 
-- 대전으로 표기해주세요 (대전광역이 -> 대전, 대전시 -> 대전)

SELECT mem_id
    , mem_add1
    , REGEXP_REPLACE(mem_add1, '^[(대전)가-힣]{1,}+','대전') as 대전
FROM member
WHERE mem_add1 LIKE '%대전%'
AND mem_id != 'p001';



























