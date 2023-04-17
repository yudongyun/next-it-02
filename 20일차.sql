
CREATE TABLE EX11_1 AS
SELECT EMPLOYEE_ID
     , EMP_NAME
     , SALARY
FROM EMPLOYEES;


CREATE OR REPLACE TRIGGER test1_trig
BEFORE UPDATE
ON EX11_1
BEGIN
DBMS_OUTPUT.PUT_LINE('요청하신 작업이 처리 되었습니다.');
END;

SELECT *
FROM EX11_1;

UPDATE ex11_1
SET emp_name = '팽수'
WHERE employee_id = 198;

CREATE OR REPLACE TRIGGER hak_tr
BEFORE UPDATE OF 이름 ON 학생
FOR EACH ROW
  DECLARE    
    v_msg VARCHAR2(100);
  BEGIN
    DBMS_OUTPUT.PUT_LINE('이름 변경안됨 !');
    DBMS_OUTPUT.PUT_LINE(:OLD.이름 ||'|'||:OLD.학번);
    DBMS_OUTPUT.PUT_LINE(:NEW.이름);
     v_msg := '이름변경 no';
     RAISE_APPLICATION_ERROR(-20999, v_msg);
  END;
  
 SELECT *
 FROM 학생;
 
 UPDATE 학생
 SET 이름 = '길동'
 WHERE 학번 = 2023000001;
  
CREATE TABLE 상품 (
       상품코드 VARCHAR2(10) CONSTRAINT 상품_PK PRIMARY KEY 
      ,상품명   VARCHAR2(100) NOT NULL
      ,제조사  VARCHAR2(100)
      ,소비자가격 NUMBER
      ,재고수량 NUMBER DEFAULT 0
    );
    
    CREATE TABLE 입고 (
       입고번호 NUMBER CONSTRAINT 입고_PK PRIMARY KEY
      ,상품코드 VARCHAR(10) CONSTRAINT 입고_FK REFERENCES 상품(상품코드)
      ,입고일자 DATE DEFAULT SYSDATE
      ,입고수량 NUMBER
      ,입고단가 NUMBER
      ,입고금액 NUMBER
    );
    
    INSERT INTO 상품 (상품코드, 상품명, 제조사, 소비자가격) VALUES ('a001','마우스','삼성','1000');
    INSERT INTO 상품 (상품코드, 상품명, 제조사, 소비자가격) VALUES ('a002','마우스','NKEY','2000');
    INSERT INTO 상품 (상품코드, 상품명, 제조사, 소비자가격) VALUES ('b001','키보드','LG','2000');
    INSERT INTO 상품 (상품코드, 상품명, 제조사, 소비자가격) VALUES ('c001','모니터','삼성','1000');
  
  
SELECT *
FROM 상품;
  
SELECT *
FROM 입고;
  
/*insert trigger 입고테이블에 입고내역이 INSERT 가 되면
  해당 상품의 상품수량을 상품테이블에 업데이트
*/
  
CREATE OR REPLACE TRIGGER warehousing_insert
AFTER INSERT ON 입고
FOR EACH ROW
DECLARE
    vn_cnt 상품.재고수량%TYPE;
    vn_nm 상품.상품명%TYPE;
BEGIN
    SELECT 재고수량, 상품명
        INTO vn_cnt, vn_nm
    FROM 상품
    WHERE 상품코드 = :NEW.상품코드;
    
    UPDATE 상품
    SET 재고수량 = :NEW.입고수량 + 재고수량
    WHERE 상품코드 = :NEW.상품코드;
    DBMS_OUTPUT.PUT_LINE(vn_nm||'제품의 수량 정보가 변경됨.');
    DBMS_OUTPUT.PUT_LINE('이전 재고수량:'|| vn_cnt);
    DBMS_OUTPUT.PUT_LINE('입고수량:'||:NEW.입고수량);
    DBMS_OUTPUT.PUT_LINE('입고 후 수량:'||(vn_cnt + :NEW.입고수량));
END;

SELECT NVL(MAX(입고번호), 0) + 1
FROM 입고;

INSERT INTO 입고(입고번호, 상품코드, 입고수량, 입고단가, 입고금액)
VALUES ((SELECT NVL(MAX(입고번호), 0) + 1
         FROM 입고), 'a002', 100, 1000, 10000);

INSERT INTO 입고(입고번호, 상품코드, 입고수량, 입고단가, 입고금액)
VALUES ((SELECT NVL(MAX(입고번호), 0) + 1
         FROM 입고), 'a002', 10, 1000, 10000);

SELECT *
FROM 상품;



CREATE OR REPLACE TRIGGER werehounsing_delete
AFTER DELETE ON 입고
FOR EACH ROW 
BEGIN
    UPDATE 상품
    SET 재고수량 = 재고수량 - :OLD.입고수량
    WHERE 상품코드 = :OLD.상품코드;
END;

DELETE FROM 입고 WHERE 입고번호 = 2;

SELECT *
FROM 상품;
  
  
CREATE OR REPLACE TRIGGER werehounsing_update
AFTER DELETE ON 입고
FOR EACH ROW 
DECLARE
    vn_cnt 상품.재고수량%TYPE;
    vn_nm 상품.상품명%TYPE;
BEGIN
    SELECT 재고수량, 상품명
            INTO vn_cnt, vn_nm
        FROM 상품
        WHERE 상품코드 = :NEW.상품코드;
        
    UPDATE 상품
    SET 재고수량 = 재고수량 -:OLD.입고수량 + :NEW.입고수량
    WHERE 상품코드 = :NEW.상품코드;
    DBMS_OUTPUT.PUT_LINE(vn_nm||'제품의 수량 정보가 변경됨.');
    DBMS_OUTPUT.PUT_LINE('이전 재고수량:'|| vn_cnt);
    DBMS_OUTPUT.PUT_LINE('입고수량:'||:NEW.입고수량);
    DBMS_OUTPUT.PUT_LINE('수정 후 수량:'||(vn_cnt + :NEW.입고수량));
END;
 
UPDATE 입고
SET 입고수량 = 40
WHERE 입고번호 = 2;
  
SELECT *
FROM 입고;

--- 암호화, 복호화
DECLARE
  input_string  VARCHAR2 (200) := 'The Oracle';  -- 암호화할 VARCHAR2 데이터
  output_string VARCHAR2 (200); -- 복호화된 VARCHAR2 데이터 

  encrypted_raw RAW (2000); -- 암호화된 데이터 
  decrypted_raw RAW (2000); -- 복호화할 데이터 

  num_key_bytes NUMBER := 256/8; -- 암호화 키를 만들 길이 (256 비트, 32 바이트)
  key_bytes_raw RAW (32);        -- 암호화 키 

  -- 암호화 슈트 
  encryption_type PLS_INTEGER; 
  
BEGIN
	 -- 암호화 슈트 설정
	 encryption_type := DBMS_CRYPTO.ENCRYPT_AES256 + -- 256비트 키를 사용한 AES 암호화 
	                    DBMS_CRYPTO.CHAIN_CBC +      -- CBC 모드 
	                    DBMS_CRYPTO.PAD_PKCS5;       -- PKCS5로 이루어진 패딩
	
   DBMS_OUTPUT.PUT_LINE ('원본 문자열: ' || input_string);

   -- RANDOMBYTES 함수를 사용해 암호화 키 생성 
   key_bytes_raw := DBMS_CRYPTO.RANDOMBYTES (num_key_bytes);
   
   -- ENCRYPT 함수로 암호화를 한다. 원본 문자열을 UTL_I18N.STRING_TO_RAW를 사용해 RAW 타입으로 변환한다. 
   encrypted_raw := DBMS_CRYPTO.ENCRYPT ( src => UTL_I18N.STRING_TO_RAW (input_string, 'AL32UTF8'),   
                                          typ => encryption_type,
                                          key => key_bytes_raw
                                        );
                                        
   -- 암호화된 RAW 데이터를 한번 출력해보자
   DBMS_OUTPUT.PUT_LINE('암호화된 RAW 데이터: ' || encrypted_raw);                                     
   -- 암호화 한 데이터를 다시 복호화 ( 암호화했던 키와 암호화 슈트는 동일하게 사용해야 한다. )
   decrypted_raw := DBMS_CRYPTO.DECRYPT ( src => encrypted_raw,
                                          typ => encryption_type,
                                          key => key_bytes_raw
                                        );
   
   -- 복호화된 RAW 타입 데이터를 UTL_I18N.RAW_TO_CHAR를 사용해 다시 VARCHAR2로 변환 
   output_string := UTL_I18N.RAW_TO_CHAR (decrypted_raw, 'AL32UTF8');
   -- 복호화된 문자열 출력 
   DBMS_OUTPUT.PUT_LINE ('복호화된 문자열: ' || output_string);
END;


--  input : VARCHAR2 타입 입력
--  output :RETURN VARCHAR2 
CREATE OR REPLACE FUNCTION fn_encoding(pw VARCHAR2)
    RETURN VARCHAR2
IS
  input_string  VARCHAR2 (200) := pw;  -- 입력 VARCHAR2 데이터
  input_raw     RAW(128);                        -- 입력 RAW 데이터 
  encrypted_raw RAW (2000); -- 암호화 데이터 
BEGIN
	-- VARCHAR2를 RAW 타입으로 변환
	input_raw := UTL_I18N.STRING_TO_RAW (input_string, 'AL32UTF8');
  DBMS_OUTPUT.PUT_LINE('----------- HASH 함수 -------------');
  encrypted_raw := DBMS_CRYPTO.HASH( src => input_raw,
                                     typ => DBMS_CRYPTO.HASH_SH1);                      
  RETURN RAWTOHEX(encrypted_raw);
  END;


DECLARE

  input_string  VARCHAR2 (200) := 'The Oracle';  -- 입력 VARCHAR2 데이터
  input_raw     RAW(128);                        -- 입력 RAW 데이터 
  encrypted_raw RAW (2000); -- 암호화 데이터 
  key_string VARCHAR2(8) := 'secret';  -- MAC 함수에서 사용할 비밀 키
  raw_key RAW(128) := UTL_RAW.CAST_TO_RAW(CONVERT(key_string,'AL32UTF8','US7ASCII')); -- 비밀키를 RAW 타입으로 변환
BEGIN
	-- VARCHAR2를 RAW 타입으로 변환
	input_raw := UTL_I18N.STRING_TO_RAW (input_string, 'AL32UTF8');
  
  DBMS_OUTPUT.PUT_LINE('----------- MAC 함수 -------------'); 
  encrypted_raw := DBMS_CRYPTO.MAC( src => input_raw,
                                    typ => DBMS_CRYPTO.HMAC_MD5,
                                    key => raw_key);   
                                    
  DBMS_OUTPUT.PUT_LINE('MAC 값 : ' || RAWTOHEX(encrypted_raw));
END;





































  