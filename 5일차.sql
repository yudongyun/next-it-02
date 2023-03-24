CREATE TABLE exp_goods_asia (
       country VARCHAR2(10),
       seq     NUMBER,
       goods   VARCHAR2(80));

INSERT INTO exp_goods_asia VALUES ('한국', 1, '원유제외 석유류');
INSERT INTO exp_goods_asia VALUES ('한국', 2, '자동차');
INSERT INTO exp_goods_asia VALUES ('한국', 3, '전자집적회로');
INSERT INTO exp_goods_asia VALUES ('한국', 4, '선박');
INSERT INTO exp_goods_asia VALUES ('한국', 5, 'LCD');
INSERT INTO exp_goods_asia VALUES ('한국', 6, '자동차부품');
INSERT INTO exp_goods_asia VALUES ('한국', 7, '휴대전화');
INSERT INTO exp_goods_asia VALUES ('한국', 8, '환식탄화수소');
INSERT INTO exp_goods_asia VALUES ('한국', 9, '무선송신기 디스플레이 부속품');
INSERT INTO exp_goods_asia VALUES ('한국', 10,'철 또는 비합금강');

INSERT INTO exp_goods_asia VALUES ('일본', 1, '자동차');
INSERT INTO exp_goods_asia VALUES ('일본', 2, '자동차부품');
INSERT INTO exp_goods_asia VALUES ('일본', 3, '전자집적회로');
INSERT INTO exp_goods_asia VALUES ('일본', 4, '선박');
INSERT INTO exp_goods_asia VALUES ('일본', 5, '반도체웨이퍼');
INSERT INTO exp_goods_asia VALUES ('일본', 6, '화물차');
INSERT INTO exp_goods_asia VALUES ('일본', 7, '원유제외 석유류');
INSERT INTO exp_goods_asia VALUES ('일본', 8, '건설기계');
INSERT INTO exp_goods_asia VALUES ('일본', 9, '다이오드, 트랜지스터');
INSERT INTO exp_goods_asia VALUES ('일본', 10, '기계류');

COMMIT;

SELECT goods
FROM exp_goods_asia
WHERE country = '한국'
UNION ALL -- 각각의 조회 결과의 집합 / 조회결과를 그냥 합침 
SELECT goods
FROM exp_goods_asia
WHERE country = '일본';

SELECT goods
FROM exp_goods_asia
WHERE country = '한국'
UNION -- 중복 값이 제거 된 후 결합
SELECT goods
FROM exp_goods_asia
WHERE country = '일본';

SELECT goods
FROM exp_goods_asia
WHERE country = '한국'
MINUS -- 차집합
SELECT goods
FROM exp_goods_asia
WHERE country = '일본';

SELECT goods
FROM exp_goods_asia
WHERE country = '한국'
INTERSECT -- 교집합
SELECT goods
FROM exp_goods_asia
WHERE country = '일본';

-- 칼럼 두개
SELECT goods, seq
FROM exp_goods_asia
WHERE country = '한국'
UNION
SELECT goods, seq
FROM exp_goods_asia
WHERE country = '일본'
UNION  -- 유니온 하나 더 추가
SELECT 'hi', 1
FROM dual
UNION  --  컬럼수와 타입이 같아야함
SELECT 'hi2', 2
FROM dual;
ORDER BY 2 ; -- 정렬 조건은 마지막 쿼리에만 가능

-- member 생일 요일별 회원수 를 출력하세요 

SELECT TO_CHAR(mem_bir, 'day') as 요일
     , COUNT(*) as 회원수
FROM member
GROUP BY TO_CHAR(mem_bir, 'day')
ORDER BY 2 DESC;

-- decode
SELECT cust_name 
     , cust_gender
     , DECODE(cust_gender, 'F', '여자', 'M', '남자', '?')
FROM customers;

/*  ROLLUP(expr1, expr2 ..)
    expr로 명시한 표현식을 기준으로 집계한 결과를 출력
    표현식의 수가 n개 이면 n+1레벨까지 집계됨
*/
SELECT period
     , gubun
     , SUM(loan_jan_amt) total
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY ROLLUP(period, gubun);

-- 2개 컬럼 사용 + 1 = 총 3레벨
-- (3) 월과 대출 종류
-- (2) 월별 합계
-- (1) 전체 합계

/* INNER JOIN 내부조인 ( 동등 조인 )
   a = b <-- 두 값이 같을 경우 행이 연결됨
*/
SELECT employees.emp_name
    , employees.department_id as emp_dep_id
    , departments.department_id as dep_id
    , departments.department_name
FROM employees -- a
    ,departments -- b  // 테이블 별칭에서는 AS(X)
WHERE employees.department_id = departments.department_id;
-- 테이블 알리야스 주면 간단해짐 / from 절에서

-- 두 테이블 부서 id가 같은경우 조인된다.

----------------------------------------
CREATE TABLE 강의내역 (
     강의내역번호 NUMBER(3)
    ,교수번호 NUMBER(3)
    ,과목번호 NUMBER(3)
    ,강의실 VARCHAR2(10)
    ,교시  NUMBER(3)
    ,수강인원 NUMBER(5)
    ,년월 date
);

CREATE TABLE 과목 (
     과목번호 NUMBER(3)
    ,과목이름 VARCHAR2(50)
    ,학점 NUMBER(3)
);

CREATE TABLE 교수 (
     교수번호 NUMBER(3)
    ,교수이름 VARCHAR2(20)
    ,전공 VARCHAR2(50)
    ,학위 VARCHAR2(50)
    ,주소 VARCHAR2(100)
);

CREATE TABLE 수강내역 (
    수강내역번호 NUMBER(3)
    ,학번 NUMBER(10)
    ,과목번호 NUMBER(3)
    ,강의실 VARCHAR2(10)
    ,교시 NUMBER(3)
    ,취득학점 VARCHAR(10)
    ,년월 DATE 
);

CREATE TABLE 학생 (
     학번 NUMBER(10)
    ,이름 VARCHAR2(50)
    ,주소 VARCHAR2(100)
    ,전공 VARCHAR2(50)
    ,부전공 VARCHAR2(500)
    ,생년월일 DATE
    ,학기 NUMBER(3)
    ,평점 NUMBER
);


COMMIT;



/*       강의내역, 과목, 교수, 수강내역, 학생 테이블을 만드시고 아래와 같은 제약 조건을 준 뒤 
        (1)'학생' 테이블의 PK '학번'
        (2)'수강내역' 테이블의 PK '수강내역번호'
        (3)'과목' 테이블의 PK '과목번호'
        (4)'교수' 테이블의 PK '교수번호'
        (5)'강의내역'의 PK를 '강의내역번호'

        (6)'학생' 테이블의 PK를 '수강내역' 테이블의 '학번' 컬럼이 참조한다 FK 키 설정
        (7)'과목' 테이블의 PK를 '수강내역' 테이블의 '과목번호' 컬럼이 참조한다 FK 키 설정 
        (8)'교수' 테이블의 PK를 '강의내역' 테이블의 '교수번호' 컬럼이 참조한다 FK 키 설정
        (9)'과목' 테이블의 PK를 '강의내역' 테이블의 '과목번호' 컬럼이 참조한다 FK 키 설정
            각 테이블에 엑셀 데이터를 임포트 

    ex) ALTER TABLE 학생 ADD CONSTRAINT PK_학생_학번 PRIMARY KEY (학번);
        
        ALTER TABLE 수강내역 
        ADD CONSTRAINT FK_학생_학번 FOREIGN KEY(학번)
        REFERENCES 학생(학번);

*/
ALTER TABLE 학생 ADD CONSTRAINT PK_학생_학번 PRIMARY KEY (학번);
ALTER TABLE 수강내역 ADD CONSTRAINT PK_수강내역_번호 PRIMARY KEY (수강내역번호);
ALTER TABLE 과목 ADD CONSTRAINT PK_과목_번호 PRIMARY KEY (과목번호);
ALTER TABLE 교수 ADD CONSTRAINT PK_교수_번호 PRIMARY KEY (교수번호);
ALTER TABLE 강의내역 ADD CONSTRAINT PK_강의내역_번호 PRIMARY KEY (강의내역번호);


ALTER TABLE 수강내역 
ADD CONSTRAINT FK_학생_학번 FOREIGN KEY(학번)
REFERENCES 학생(학번);

ALTER TABLE 수강내역 
ADD CONSTRAINT FK_수강내역_번호 FOREIGN KEY(과목번호)
REFERENCES 과목(과목번호);

ALTER TABLE 강의내역 
ADD CONSTRAINT FK_교수_번호 FOREIGN KEY(교수번호)
REFERENCES 교수(교수번호);

ALTER TABLE 강의내역 
ADD CONSTRAINT FK_과목_번호 FOREIGN KEY(과목번호)
REFERENCES 과목(과목번호);

-------------------------------
SELECT 학생.학번
     , 학생.이름
     , 수강내역.수강내역번호
FROM 학생
     , 수강내역
WHERE 학생.학번 = 수강내역.학번
AND 학생.이름 = '최숙경'; -- 동등조인, 이너조인 (같은 학번 행의 결합)


SELECT 학생.학번
     , 학생.이름
     , 수강내역.수강내역번호
FROM 학생
     , 수강내역
WHERE 학생.학번 = 수강내역.학번(+)
AND 학생.이름 = '양지운';  -- outer join 외부조인 / null값도 포함시킬때 ( null이 있는쪽에 (+) )

SELECT a. 이름 , b. 수강내역번호, c. 과목이름
FROM 학생 a
    ,수강내역 b
    , 과목 c
WHERE a.학번 = b.학번
AND b.과목번호 = c.과목번호 ; 

-- 모든 학생의 수강내역건수를 출력하세요

SELECT a. 이름
    , COUNT(b.수강내역번호) as 수강내역건수
FROM 학생 a
    ,수강내역 b
WHERE a.학번 = b.학번(+)
GROUP BY ROLLUP(a. 이름)
ORDER BY 2 DESC;

-- 수강이력이 있는 학생의 수강'학점'합계를 출력하세요

SELECT a. 이름
    , SUM(c.학점)
FROM 학생 a
    ,수강내역 b
    ,과목 c
WHERE a.학번 = b.학번
AND b.과목번호 = c.과목번호
GROUP BY a. 이름;







