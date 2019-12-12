--��Ī : ���̺�, �÷��� �ٸ� �̸����� ��Ī
-- [AS] ��Ī��
-- SELECT empno [AS] eno
-- FROM emp e

--SYNONYM (���Ǿ�)
--����Ŭ ��ü�� �ٸ��̸����� �θ� �� �ֵ��� �ϴ� ��
--���࿡ EMP ���̺��� e ��� �ϴ� synonym(���Ǿ�)�� ������ �ϸ�
--������ ���� SQL�� �ۼ� �� �� �ִ�
--SELECT *
--FROM e;

--hun������ SYNONYM ���� ������ �ο�
GRANT CREATE SYNONYM TO hun;

--emp���̺��� ����Ͽ� synonym e�� ����
--CREATE SYNONYM �ó�� �̸� FOR ����Ŭ ��ü;
CREATE SYNONYM e FOR emp;

--emp ��� ���̺� �� ��ſ� e��� �ϴ� �ó���� ����Ͽ� ������ �ۼ� �� �� �ִ�
SELECT *
FROM e;

--hun������ fastfood ���̺��� hr ���������� �� �� �ֵ���
---���̺� ��ȸ������  �ο�
GRANT SELECT ON fastfood TO hr;

--DML
--      SELECT / INSERT / UPDATE / DELETE / INSERT ALL / MERGE

--TCL 
--      COMMIT / ROLLBACK / [SAVEPOINT]

--DDL
--      CREATE ��ü
--      ALTER
--      DROP

--DCL
--      GRANT / REVOKE

SELECT*
FROM DICTIONARY;


--������ SQL�� ���信 ������ �Ʒ� SQL���� �ٸ���
SELECT /*201911_205*/ * FROM emp;
SELECT /*201911_205*/ * FROM EMP;
SELECt /*201911_205*/ * FROM EMP;

SELECt /*201911_205*/ * FROM EMP WHERE empno = 7369;
SELECt /*201911_205*/ * FROM EMP WHERE empno = 7499;

--multiple insert
DROP TABLE emp_test;


--emp���̺��� empno, ename Į������ emp_test, emp_test2 ���̺���
--����(CTAS, �����͵� ���� ����)
CREATE TABLE emp_test AS
SELECT empno, ename
FROM emp;

CREATE TABLE emp_test2 AS
SELECT empno, ename
FROM emp;

SELECT *
FROM emp_test;


SELECT *
FROM emp_test2;

--uncoditional onsert
--���� ���̺� �����͸� ���� �Է�
--brown, cony 
INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 9999, 'brown' FROM DUAL UNION ALL
SELECT 9998, 'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000;

SELECT *
FROM emp_test2
WHERE empno > 9000;

--���̺� �� �ԷµǴ� �������� �÷��� ���� ����
ROLLBACK;
INSERT ALL
    INTO emp_test (empno, ename) VALUES (eno, enm)
    INTO emp_test2 (empno) VALUES (eno)
SELECT 9999 eno, 'brown' enm FROM DUAL UNION ALL
SELECT 9998, 'cony' FROM DUAL;

SELECT *
FROM emp_test
WHERE empno > 9000

UNION ALL

SELECT *
FROM emp_test2
WHERE empno > 9000;

ROllBACK;

--CONDITIONAL INSERT
--���ǿ� ���� ���̺�� �����͸� �Է�
/*
CASE 
        WHEN ���� THEN--- //IF
        WHEN ���� THEN--- //ELSE IF
        ELSE            //ELSE
*/
ROLLBACK;
INSERT FIRST
    WHEN eno > 9000 THEN 
        INTO emp_test(empno, ename)VALUES(eno, enm)
    WHEN eno > 9500 THEN 
        INTO emp_test(empno, ename)VALUES(eno, enm)
    ElSE
        INTO emp_test2 (empno) vALUES (eno)
SELECT 9999 eno, 'brown' enm FROM DUAL UNION ALL
SELECT 8998, 'cony' FROM DUAL;

SELECT * 
FROM emp_test
WHERE empno > 9000 UNION ALL
SELECt *
FROM emp_test2
WHERE empno > 8000;