






--procedure 생성 실습 PRO_3
/*CREATE OR REPLACE PROCEDURE updatedept_test 
    (p_deptno IN dept_test.deptno%TYPE,
     p_dname IN dept_test.dname%TYPE,
     p_loc IN dept_test.loc%TYPE
    ) 
IS 
    deptno dept_test.deptno%TYPE;
    dname dept_test.dname%TYPE;
    loc dept_test.loc%TYPE;
    
BEGIN
   UPDATE dept_test 
   SET dname = 'ddit_m',
       loc = 'daejeon'
   WHERE deptno  = '99';*/

   
    
    DBMS_OUTPUT.PUT_LINE(deptno ||' '|| dname || ' ' || loc);

END;
/


exec UPDATEdept_test  (99, 'ddit_m', 'daejeon');


--ROW TYPE
--특정 테이블의 ROW정보를 담을 수 있는 참고 타입
--TYPE : 테이블명, 테이블 컬럼명 % TYPE 
-- ROW TYPE : 테이블명 % ROWTYPE

SET SERVEROUTPUT ON;
DECLARE
--dept 테이블의 row 정보를 담을 수 있는 ROWTYPE 변수 선언
    dept_row dept%ROWTYPE;
BEGIN
    SELECT *
    INTO dept_row
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(dept_row.dname || ', ' || dept_row.loc);
END;
/

--RECORD TYPE : 개발자가 컬럼을 직접 선언하여 개발에 필요한 TYPE을 생성
-- TYPE 타입이름 SI RECODE(
--      컬럼1 컬럼1 TYPE,
--      컬럼2 컬럼2 TYPE
--    );
--public class 클래스명{
--      필드type 필드(컬럼);  //int name;
--      필드2type 필드(컬럼)2; //int age;
DECLARE 
--부서이름, loc정보를 저장할 수 있는 RECORD TYPE선언
    TYPE dept_row IS RECORD(
        dname dept.dname%TYPE,
        loc dept.loc%TYPE);
        --type선언이 완료, type을 갖고 변수를 생성
        --java : class 생성후 해당 class의 인스턴스를 생성(new)
        --PL SQL 변수 생성 : 변수이름 변수 타입 dname dept.dname%TYPE;
        dept_row_data dept_row;
BEGIN
    SELECT dname, loc
    INTO dept_row_data
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(dept_row_data.dname || ',' || dept_row_data.loc);
END;
/


--TABLE TYPE : 여러개의 ROWTYPE을 저장할 수 있는 TYPE
--col --> row --> table
-- TYPE 테이블 타입명 IS TABLE OF ROWTYPE/RECORD INDEX BY 인덱스 타입(BINARY_INTGER)
--java와 다르게 PLSQL에서는 arrary역활을 하는 table type의 인덱스를
--숫자뿐만 아니라, 문자열 형태도 가능 하다
--그렇기 때문에 index에 대한 타입을 명시한다
--일반적으로 array(list) 형태인 경우라면 INDEX BY BINARY_INTEGER를 주로 사용한다.
--arr(1).name = 'brown'
--arr('person').name = 'brown'

--dept 테이블의 row를 여러건 저장 할 수 있는 dept_tab TABLE TYPE 선언하여
--SELECT *FROM dept; 의 결과(여러건)를 변수에 담는다
DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept dept_tab;
BEGIN
    --한 row 값을 변수에 저장 : INTO
    --복수 row의 값을 변수에 저장 : BULK COLLECT INTO
    SELECT *
    BULK COLLECT INTO v_dept
    FROM dept;
    
    FOR i IN 1..v_dept.count LOOP
    --arr[1] --> arr(1)
    DBMS_OUTPUT.PUT_LINE(v_dept(i).deptno);
    END LOOP;
END;
/

-- 로직 제어 IF
--IF condition THEN
-- statement
--ELSIF condition THEN
-- statement
--ELSE
-- statement
--END IF;

--PL SQL IF 실습
-- 변수 p(NUMBER)에 2라는 값을 할당하고
-- int a = 5;
-- int a;
-- a = 5;
-- IF 구문을 통해 p의 값이 1, 2, 그 밖의 값일때 텍스트 출력
DECLARE
    p NUMBER := 2; -- 변수 선언과 할당을 한문장에서 진행
    --p는 숫자 2이다
BEGIN
    --p := 2;
    IF p = 1 THEN  --p가 1이면
        DBMS_OUTPUT.PUT_LINE('p=1'); --1을 출력
    ELSIF p = 2 THEN -- JAVA와 문법이 다르다 (else if --> elsif) p가 2이면
        DBMS_OUTPUT.PUT_LINE('p=2');--2를 출력
    ELSE
        DBMS_OUTPUT.PUT_LINE(p);--그렇지 않으면 p를 출력
    END IF;
END;
/



--FOR LOOP
--FOR 인덱스 변수 IN [REVERSE] START..END LOOP
-- 반복실행문
--END LOOP;
--0~5까지 루프 변수를 이용하여 반복문 실행
DECLARE
BEGIN
    FOR i IN 0..5 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/
-- 1~10 : 55
-- 1~10 까지의 합을 loop를 이용하여 계산, s_val 이라는 변수에 담아
--    DBMS_OUTPUT.PUT_LINE 함수를 통해 화면에 출력

DECLARE
    s_val NUMBER := 0;
BEGIN
    FOR i IN 1..10 LOOP
    s_val := s_val + i;    
    END LOOP;      
    DBMS_OUTPUT.PUT_LINE(s_val);
END;
/

--while loop
--WHILE condition LOOP
--  statement
-- END LOOP;
-- 0 ~ 5 까지 WHILE 문을 이용하여 출력
DECLARE
    i NUMBER := 0;
BEGIN
    WHILE i <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
        i := i + 1;
    END LOOP;
END;
/
--LOOP
--LOOP
--      statement;
--      EXIT [WHEN condition];
-- END LOOP;

DECLARE
    i NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(i);
        EXIT WHEN i >= 5;
        i := i + 1;
    END LOOP;
END;
/

--CUSOR : SQL을 개발자가 제어할 수 있는 객체
--묵시적 : 개발자가 별도의 커서명을 기술하지 않은 형태, ORACLE에서 자동으로 OPEN, 실행, FETCH, CLOSE를 관리한다
--명시적 : 개발자가 이름을 붙인 커서, 개발자가 직접 제어하며 선언, OPEN, FETCH, CLOSE 단계가 존재
--CURSOR 커서이름 IS -- 커서 선언
--  QUERY;
--OPEN 커서이름; --커서 OPEN
--FECTH 커서이름 INTO 변수1, 변수2... -- 커서 FECTH(행 인출)
--CLOSE 커서이름; --커서 CLOSE

--부서테이블의 모든 행의 부서이름, 위치, 지역 정보를 출력 (CURSOR)를 이용
DECLARE
    CURSOR dept_cursor IS
        SELECT dname, loc
        FROM dept;
        v_dname dept.dname%TYPE;
        v_loc dept.loc%TYPE;
BEGIN
--커서오픈
    OPEN dept_cursor;
    
    LOOP
        FETCH dept_cursor INTO v_dname, v_loc;
        --종료조건 : FETCH할 데이터가 없을 때 종료
        EXIT WHEN dept_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_dname || '. ' || v_loc);
    END LOOP;
    
    CLOSE dept_cursor;
    
    
END;
/