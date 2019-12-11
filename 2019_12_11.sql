--INDEX만 조회하여 사용자의 요구사항에 만족하는 데이터를 만들어
--낼 수 있는 경우

SELECT rowid, emp.*
FROM emp;

SELECT empno, rowid
FROM emp
ORDER BY empno;

--emp 테이블의 모든 컬럼을 조회
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 2949544139
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7782)
   
--emp 테이블의 empno컬럼을 조회   
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 56244932
 
----------------------------------------------------------------------------
| Id  | Operation         | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |        |     1 |     4 |     0   (0)| 00:00:01 |
|*  1 |  INDEX UNIQUE SCAN| PK_EMP |     1 |     4 |     0   (0)| 00:00:01 |
----------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("EMPNO"=7782)
   
--기존 인덱스 제거(PK_emp 제약조건 삭제) -->  unique 제약 삭제 --> PK_emp 인덱스 삭제

--INDEX 종류 (컬럼 중복 여부)
--UNIQUE INDEX : 인덱스 컬럼의 값이 중복될 수 없는 인덱스
--    (emp,empno, dept.detno)
--NON-UNIQUE INDEX(default) :  인덱스 컬럼의 값이 중복될 수 있는 인덱스 (emp.job)
ALTER TABLE emp DROP CONSTRAINT pk_emp;
--CREATE UNIQUE INDEX idx_n_emp_01 ON emp (empno);

--위쪽 상황이랑 달라진 것은 EMPNO컬럼으로 생성된 인덱스가 
--UNIQUE --> NON-UNIQUE 인덱스로 변경됨
CREATE INDEX idx_n_emp_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 2778386618
 
--------------------------------------------------------------------------------------------
| Id  | Operation                   | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |              |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_N_EMP_01 |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7782)
   
--7782
DELETE emp WHERE empno = '9999';
INSERT INTO emp(empno, ename) VALUES (7782, 'brown');
COMMIT;

SELECT *
FROM emp
WHERE empno=7782;

--DEPT 테이블에는 PK_DEPT (PRIMARY KEY 제약 조건이 설정됨)
--PK_DEPT : deptno
SELECT *
FROM dept

INSERT INTO dept VALUES (20, 'ddit3', '대전');

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='DEPT';


--emp테이블에 job컬럼으로 non-unique 인덱스 생성
--인덱스 명 : didx_n_emp_02
CREATE INDEX idx_n_emp_02 ON emp (job);

SELECT job, rowid
FROM emp, dept
ORDER BY job;

--emp 테이블에는 인덱스가 2개 존재
--1. empno
--2. job

--IDX_02 인덱스
--emp 테이블에는 인덱스가 2개 존재
--1. empno
--2. job
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

--IDX_n_emp_03
--emp테이블의 job, ename컬럼으로 non-unique인덱스 생성
CREATE INDEX idx_n_emp_03 ON emp (job,ename);

SELECT job, ename, rowid
FROM emp
ORDER BY job, ename;

--idx_n_emp_04
--emp테이블의 ename, job컬럼으로 non-unique인덱스 생성
CREATE INDEX idx_n_emp_04 ON emp(ename, job);


SELECT ename, job, rowid
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'J%';

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'J%';

SELECT *
FROM TABLE(dbms_xplan.display);

--JOIN 쿼리에서의 인덱스
--emp 테이블은 empno컬럼으로 PRIMARY KEY 제약조건이 존재
--dept 테이블은 deptno컬럼으로 PRIMARY KEY 제약조건이 존대
-- emp 테이블은 PRIMARY KEY 제약을 삭제한 상태 이므로 재생성
DELETE emp
WHERE ename = 'brown';
COMMIT;

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT ename, ename, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 3070176698
 
----------------------------------------------------------------------------------------------
| Id  | Operation                     | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |              |     1 |    25 |     2   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                 |              |       |       |            |          |
|   2 |   NESTED LOOPS                |              |     1 |    25 |     2   (0)| 00:00:01 |
|   3 |    TABLE ACCESS BY INDEX ROWID| EMP          |     1 |    13 |     1   (0)| 00:00:01 |
|*  4 |     INDEX RANGE SCAN          | IDX_N_EMP_01 |     1 |       |     0   (0)| 00:00:01 |
|*  5 |    INDEX UNIQUE SCAN          | PK_DEPT      |     1 |       |     0   (0)| 00:00:01 |
|   6 |   TABLE ACCESS BY INDEX ROWID | DEPT         |     5 |    60 |     1   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - access("EMP"."EMPNO"=7788)
   5 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
   
   
--index실습 idx1

CREATE TABLE dept_test AS
SELECT *
FROM dept
WHERE 1 = 1; 

CREATE UNIQUE INDEX index_dept_test_01 ON dept_test(deptno);

--dname 컬럼으로 NON_UNIQUE INDEX 생성
CREATE INDEX index_n_dept_test_02 ON dept_test(dname);

--deptnom dname 컬럼으로 NON_UNIQUE INDEX 생성
CREATE INDEX index_n_dept_test_03 ON dept_test(deptno, dname);


--idx2 
DROP INDEX index_dept_test_01;
DROP INDEX index_n_dept_test_02;
DROP INDEX index_n_dept_test_03;

