--dept테이블에 synonym을 생성하여


--DDL : TABLE 생성
--CREATE TABLE [사용자명.]테이블명(
--    컬럼명1 컬럼타입1, 
--    컬럼명1 컬럼타입2,...
--    컴럼명 N 컬럼타입N);


--ranger _ no NUMBER        :레인저 번호
--ranger_nm VARCHAR2(50)    :레인저 이름
--reg_dt DATE               :레인저 등록일자
--테이블 생성 DDL: Date Defination Language(데이터 정의어)
--DDL rollback이 없다(자동커밋 되므로 rollback을 할 수 없다)
CREATE TABLE ranger (
 ranger_no NUMBER,
 ranger_nm VARCHAR2(50),
 reg_dt DATE
);
DESC ranger;

--DDL 문장은 ROLLBACK 처리 불가!!
ROLLBACK;

SELECT *
FROM user_tables
WHERE table_name = 'RANGER';
--WHERE table_name = 'ranger;
--오라클에서는 객체 생성시 소문자로 생성하더라도 내부적으로는 대문자로 관리한다

INSERT INTO ranger VALUES(1, 'brwon', sysdate);
--데이터가 조회되는것을 확인 했음
SELECT *
FROM ranger;

--DML문은 DDL과 다르게 ROLLBACK이 가능하다
ROLLBACK;

--ROLLBACK을 했기 때문에 DML문장이 취소된다
SELECT *
FROM ranger;

--DATE 타입에서 필드 추출하기
--EXTRACT(필드명 FROM 컬럼 /expression)
SELECT TO_CHAR(SYSDATE, 'YYYY') yyyy,
       TO_CHAR(SYSDATE, 'mm') mm,
       EXTRACT(year FROM SYSDATE) ex_yyyy,
       EXTRACT(month FROM SYSDATE) ex_mm
FROM dual;


--테이블 생성시 컬럼 레벨 제약조건 생성
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13));

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13));

--dept_test 테이블의 deptno 컬럼에 PRIMARY KEY 제약조건이 있기 때문에 
--deptno가 동일한 데이터를 입력하거나 수정 할 수 없다
--최초 데이터이므로 입력성공
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');

--dept_test 데이터에 deptno가 99번인 데이터가 있으므로
--primary key 제약조건에 의해 입력 될 수 없다
--ORA-0001 unique constraint 제약 위배
--SYS_C007147 제약 조건을 어떤 제약 조건인지 판단하기 힘드므로
--제약조건에 이름을 코딩 룰에 의해 붙여주는 편이 유지보수시 편하다
INSERT INTO dept_test VALUES(99, '대덕', '대전');



--테이블 삭제후 제약조건 이름을 추가하여 재생성
--primary key : pk_테이블명
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13));
    
--INSERT 구문 복사
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, '대덕, '대전');