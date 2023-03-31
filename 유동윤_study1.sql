/*
 STUDY 계정에 create_table 스크립트를 실해하여 
 테이블 생성후 1~ 5 데이터를 임포트한 뒤 
 아래 문제를 출력하시오 
 (문제에 대한 출력물은 이미지 참고)
 모든 문제 풀이 시작시간과 종료시간을 작성해 주세요 
*/
-----------1번 문제 ---------------------------------------------------
--1988년 이후 출생자의 직업이 의사,자영업 고객을 출력하시오 (어린 고객부터 출력)
--시작시간 :  2023-03-31 14:23:50
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 시작시간 FROM DUAL;
--종료시간 : 2023-03-31 14:24:07
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 종료시간 FROM DUAL;
/* 작성 쿼리 */

SELECT *
FROM customer
WHERE SUBSTR(birth, 1, 4) >= 1988
AND (job LIKE '%자영업%' or job LIKE '%의사%')
ORDER BY birth DESC;

---------------------------------------------------------------------
-----------2번 문제 ---------------------------------------------------
--강남구에 사는 고객의 이름, 전화번호를 출력하시오 

--시작시간 :  2023-03-31 14:24:38
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 시작시간 FROM DUAL;
--종료시간 : 2023-03-31 14:25:29
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 종료시간 FROM DUAL;

SELECT customer_name as 이름
     , phone_number as 전화번호
     , a.address_detail as 사는곳
FROM address  a
    ,customer b
WHERE a.zip_code = b.zip_code
AND a.address_detail = '강남구';
---------------------------------------------------------------------
----------3번 문제 ---------------------------------------------------
--CUSTOMER에 있는 회원의 직업별 회원의 수를 출력하시오 (직업 NULL은 제외)

--시작시간 :  2023-03-31 14:25:55
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 시작시간 FROM DUAL;
--종료시간 : 2023-03-31 14:31:48
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 종료시간 FROM DUAL;

-- NULL 값 제외
SELECT job
    , count(ALL job)
FROM customer
WHERE job IS NOT NULL
GROUP BY job
ORDER BY 2 DESC;
---------------------------------------------------------------------
----------4-1번 문제 ---------------------------------------------------
-- 가장 많이 가입(처음등록)한 요일과 건수를 출력하시오 

--시작시간 :  2023-03-31 14:33:15
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 시작시간 FROM DUAL;
--종료시간 : 2023-03-31 14:58:30
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 종료시간 FROM DUAL;

SELECT *
FROM (SELECT TO_CHAR(first_reg_date, 'day') as 가입일
            , COUNT(*) as 건수
        FROM customer
        GROUP BY  TO_CHAR(first_reg_date, 'day')
        ORDER BY 2 DESC
    )
WHERE ROWNUM <= 1;


---------------------------------------------------------------------
----------4-2번 문제 ---------------------------------------------------
-- 남녀 인원수를 출력하시오 

--시작시간 :  2023-03-31 14:58:48
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 시작시간 FROM DUAL;
--종료시간 : 2023-03-31 15:17:06
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 종료시간 FROM DUAL;

SELECT COUNT(*) as 인원수 
      , CASE WHEN sex_code = 'F' THEN '여자'
        WHEN sex_code = 'M' THEN '남자'
        ELSE '미등록' 
        END
FROM customer
GROUP BY CASE WHEN sex_code = 'F' THEN '여자'
        WHEN sex_code = 'M' THEN '남자'
        ELSE '미등록' 
        END
ORDER BY 1 DESC;

---------------------------------------------------------------------
----------5번 문제 ---------------------------------------------------
--월별 예약 취소 건수를 출력하시오 (많은 달 부터 출력)

--시작시간 :  2023-03-31 15:17:24
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 시작시간 FROM DUAL;
--종료시간 : 2023-03-31 15:38:07
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 종료시간 FROM DUAL;

SELECT SUBSTR(SUBSTR(reserv_date, 5), 1, 2) as 월
    , count(cancel) as 취소건수
FROM reservation
WHERE cancel = 'Y'
GROUP BY SUBSTR(SUBSTR(reserv_date, 5), 1, 2)
ORDER BY 2 DESC;

---------------------------------------------------------------------
----------6번 문제 ---------------------------------------------------
 -- 전체 상품별 '상품이름', '상품매출' 을 내림차순으로 구하시오 
 
--시작시간 :  2023-03-31 15:51:39
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 시작시간 FROM DUAL;
--종료시간 : 2023-03-31 15:51:45
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 종료시간 FROM DUAL; 
 
SELECT product_name
    ,  SUM(sales)
FROM item a
    ,order_info b
WHERE a.item_id = b.item_id
GROUP BY product_name
ORDER BY 2 DESC;
 
 
-----------------------------------------------------------------------------
---------- 7번 문제 ---------------------------------------------------
-- 모든상품의 월별 매출액을 구하시오 
-- 매출월, SPECIAL_SET, PASTA, PIZZA, SEA_FOOD, STEAK, SALAD_BAR, SALAD, SANDWICH, WINE, JUICE

--시작시간 :  2023-03-31 15:52:04
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 시작시간 FROM DUAL;
--종료시간 : 2023-03-31 16:21:24
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 종료시간 FROM DUAL; 

SELECT 월
    , SUM(SPECIAL_SET) as SPECIAL_SET
    , SUM(PASTA) as PASTA
    , SUM(PIZZA) as PIZZA
    , SUM(SEA_FOOD) as SEA_FOOD
    , SUM(STEAK) as STEAK
    , SUM(SALAD_BAR) as SALAD_BAR
    , SUM(SALAD) as SALAD
    , SUM(SANDWICH) as SANDWICH
    , SUM(WINE) as WINE
    , SUM(JUICE) as JUICE
FROM (SELECT SUBSTR(b.reserv_no, 1, 6) as 월
       , DECODE(PRODUCT_NAME, 'SPECIAL_SET', sales, 0) as SPECIAL_SET
       , DECODE(PRODUCT_NAME, 'PASTA', sales, 0) as PASTA
       , DECODE(PRODUCT_NAME, 'PIZZA', sales, 0) as PIZZA
       , DECODE(PRODUCT_NAME, 'SEA_FOOD', sales, 0) as SEA_FOOD
       , DECODE(PRODUCT_NAME, 'STEAK', sales, 0) as STEAK
       , DECODE(PRODUCT_NAME, 'SALAD_BAR', sales, 0) as SALAD_BAR
       , DECODE(PRODUCT_NAME, 'SALAD', sales, 0) as SALAD
       , DECODE(PRODUCT_NAME, 'SANDWICH', sales, 0) as SANDWICH
       , DECODE(PRODUCT_NAME, 'WINE', sales, 0) as WINE
       , DECODE(PRODUCT_NAME, 'JUICE', sales, 0) as JUICE
        FROM item a
            ,order_info b
        WHERE a.item_id = b.item_id
    )
GROUP BY 월
ORDER BY 1 ASC;
----------------------------------------------------------------------------
---------- 8번 문제 ---------------------------------------------------
-- 월별 온라인_전용 상품 매출액을 일요일부터 월요일까지 구분해 출력하시오 
-- 날짜, 상품명, 일요일, 월요일, 화요일, 수요일, 목요일, 금요일, 토요일의 매출을 구하시오 

--시작시간 :  2023-03-31 16:21:59
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 시작시간 FROM DUAL;
--종료시간 : 2023-03-31 16:55:57
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 종료시간 FROM DUAL; 

SELECT SUBSTR(reserv_date, 1, 6)
FROM reservation;

SELECT 년도
    , SUM(일요일) as 일요일
    , SUM(월요일) as 월요일
    , SUM(화요일) as 화요일
    , SUM(수요일) as 수요일
    , SUM(목요일) as 목요일
    , SUM(금요일) as 금요일
    , SUM(토요일) as 토요일
FROM (SELECT SUBSTR(reserv_date, 1, 6) as 년도
     , a.product_name
     , TO_CHAR(TO_DATE(c.reserv_date, 'YYYYMMDD'), 'DAY')  as 요일
     , DECODE(TO_CHAR(TO_DATE(c.reserv_date, 'YYYYMMDD'), 'DAY'), '일요일', sales, 0) as 일요일
     , DECODE(TO_CHAR(TO_DATE(c.reserv_date, 'YYYYMMDD'), 'DAY'), '월요일', sales, 0) as 월요일
     , DECODE(TO_CHAR(TO_DATE(c.reserv_date, 'YYYYMMDD'), 'DAY'), '화요일', sales, 0) as 화요일
     , DECODE(TO_CHAR(TO_DATE(c.reserv_date, 'YYYYMMDD'), 'DAY'), '수요일', sales, 0) as 수요일
     , DECODE(TO_CHAR(TO_DATE(c.reserv_date, 'YYYYMMDD'), 'DAY'), '목요일', sales, 0) as 목요일
     , DECODE(TO_CHAR(TO_DATE(c.reserv_date, 'YYYYMMDD'), 'DAY'), '금요일', sales, 0) as 금요일
     , DECODE(TO_CHAR(TO_DATE(c.reserv_date, 'YYYYMMDD'), 'DAY'), '토요일', sales, 0) as 토요일
        FROM item a
            , order_info b
            , reservation c
        WHERE a.item_id = b.item_id
        AND b.reserv_no = c.reserv_no
        AND a.product_name = 'SPECIAL_SET'
    )
GROUP BY 년도
ORDER BY 1 ASC;

----------------------------------------------------------------------------
---------- 9번 문제 ----------------------------------------------------
-- 고객수, 남자인원수, 여자인원수, 평균나이, 평균거래기간(월기준)을 구하시오 
-- (성별 NULL 제외, 생일 NULL  제외, MONTHS_BETWEEN, AVG, ROUND 사용(소수점 1자리 까지) 나이계산 

--시작시간 :  2023-03-31 16:56:20
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 시작시간 FROM DUAL;
--종료시간 : 2023-03-31 17:35:17
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 종료시간 FROM DUAL; 

-- 고객수, 평균나이, 평균거래기간
SELECT COUNT(*) as 고객수
        , ROUND(AVG(2023 - SUBSTR(birth, 1, 4)), 1) as 평균나이
        , ROUND(AVG(sysdate - first_reg_date) / 365, 1) as 평균거래기간
FROM customer
WHERE birth IS NOT NULL
AND sex_code IS NOT NULL;

-- 고객 중 남녀 인원수
SELECT COUNT(ALL SEX_CODE)
    , SEX_CODE
FROM customer
WHERE SEX_CODE IS NOT NULL
GROUP BY SEX_CODE;


----------------------------------------------------------------------------
---------- 10번 문제 ----------------------------------------------------
--매출이력이 있는 고객의 주소, 우편번호, 해당지역 고객수를 출력하시오
-- ㅠ

----------------------------------------------------------------------------
