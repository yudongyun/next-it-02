-- 검색_문제.pdf 파일을 보고 조회 SQL을 작성하세요

/*
    1. 고객 이름으로 고객의 기본정보를 조회하는 SELECT 문
       이름은 LIKE 검색
       
    2. 고객의 ID로 고객의 예약 및 고매 이력을 조회하는 SELECT 문
*/

-- #1번 문제
SELECT ROWNUM as no
    ,  a.customer_id as 고객ID
    ,  a.customer_name 고객명
    ,  a.email
    ,  b.address_detail as 주소
FROM customer a
    ,address b
WHERE customer_name LIKE '고객5%'
AND a.zip_code = b.zip_code;

-- #2번 문제
SELECT c.reserv_no as 예약NO
    , TO_DATE(c.reserv_date) as 예약일자
    , c.cancel as 취소여부
    , a.product_name as 상품명
    , b.quantity as 수량
    , b.sales as 금액
FROM item a
    ,order_info b
    ,reservation c
    ,customer d
WHERE a.item_id(+) = b.item_id
AND b.reserv_no(+) = c.reserv_no
AND c.customer_id(+) = d.customer_id
AND d.customer_id = 'W1341752';








