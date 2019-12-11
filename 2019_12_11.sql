--INDEX�� ��ȸ�Ͽ� ������� �䱸���׿� �����ϴ� �����͸� �����
--�� �� �ִ� ���

SELECT rowid, emp.*
FROM emp;

SELECT empno, rowid
FROM emp
ORDER BY empno;

--emp ���̺��� ��� �÷��� ��ȸ
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
   
--emp ���̺��� empno�÷��� ��ȸ   
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
   
--���� �ε��� ����(PK_emp �������� ����) -->  unique ���� ���� --> PK_emp �ε��� ����

--INDEX ���� (�÷� �ߺ� ����)
--UNIQUE INDEX : �ε��� �÷��� ���� �ߺ��� �� ���� �ε���
--    (emp,empno, dept.detno)
--NON-UNIQUE INDEX(default) :  �ε��� �÷��� ���� �ߺ��� �� �ִ� �ε��� (emp.job)
ALTER TABLE emp DROP CONSTRAINT pk_emp;
--CREATE UNIQUE INDEX idx_n_emp_01 ON emp (empno);

--���� ��Ȳ�̶� �޶��� ���� EMPNO�÷����� ������ �ε����� 
--UNIQUE --> NON-UNIQUE �ε����� �����
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

--DEPT ���̺��� PK_DEPT (PRIMARY KEY ���� ������ ������)
--PK_DEPT : deptno
SELECT *
FROM dept

INSERT INTO dept VALUES (20, 'ddit3', '����');

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='DEPT';


--emp���̺� job�÷����� non-unique �ε��� ����
--�ε��� �� : didx_n_emp_02
CREATE INDEX idx_n_emp_02 ON emp (job);

SELECT job, rowid
FROM emp, dept
ORDER BY job;

--emp ���̺��� �ε����� 2�� ����
--1. empno
--2. job

--IDX_02 �ε���
--emp ���̺��� �ε����� 2�� ����
--1. empno
--2. job
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

--IDX_n_emp_03
--emp���̺��� job, ename�÷����� non-unique�ε��� ����
CREATE INDEX idx_n_emp_03 ON emp (job,ename);

SELECT job, ename, rowid
FROM emp
ORDER BY job, ename;

--idx_n_emp_04
--emp���̺��� ename, job�÷����� non-unique�ε��� ����
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

--JOIN ���������� �ε���
--emp ���̺��� empno�÷����� PRIMARY KEY ���������� ����
--dept ���̺��� deptno�÷����� PRIMARY KEY ���������� ����
-- emp ���̺��� PRIMARY KEY ������ ������ ���� �̹Ƿ� �����
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
   
   
--index�ǽ� idx1

CREATE TABLE dept_test AS
SELECT *
FROM dept
WHERE 1 = 1; 

CREATE UNIQUE INDEX index_dept_test_01 ON dept_test(deptno);

--dname �÷����� NON_UNIQUE INDEX ����
CREATE INDEX index_n_dept_test_02 ON dept_test(dname);

--deptnom dname �÷����� NON_UNIQUE INDEX ����
CREATE INDEX index_n_dept_test_03 ON dept_test(deptno, dname);


--idx2 
DROP INDEX index_dept_test_01;
DROP INDEX index_n_dept_test_02;
DROP INDEX index_n_dept_test_03;

