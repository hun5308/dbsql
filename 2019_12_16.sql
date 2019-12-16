--GROUPPING SETS(col1, col2)
--������ ����� ����
--�����ڰ� GROUP BY�� ������ ���� ����Ѵ�
--ROLL UP �� �޸� ���⼺�� ���� �ʴ´�
--GROUPING SETS(col1, col2) = GROUPING SETS(col1. col2)

--GROUP BY col1
--UNION ALL
--BROUP BY col2

--emp ���̺��� ������ job�� �޿�(sal)+ ��(comm)��, 
--                     deptno(�μ�)�� �޿�(sal)+ ��(comm)�� ���ϱ�
--�������(GROUP FUNCTION) : 2���� SQL�ۼ� �ʿ�(UNION / UNION ALL)
SELECT job,null deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job

UNION ALL
SELECT '',deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY deptno;

-- GROUPING SETS ������ �̿��Ͽ� ���� SQL�� ���տ����� ������� �ʰ�
-- ���̺��� �ѹ� �о ó��
SELECT job, deptno,SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY GROUPING SETS (job, deptno);

--job, deptno�� �׷����� �� sal+comm��
--mgr�� �׷����� �� sal+comm��
--GROUP BY job, deptno
--UNION ALL
--GROUP BY mgr
-- --> GROUPING SETS(job, deptno, mgr)
SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal_comm_sum,
        GROUPING(job), GROUPING(deptno), GROUPING(mgr)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);

--CUBE (col1, col2 ...)
--������ �÷��� ��� ������ �������� GROUP BY subset�� �����
--CUBE�� ������ �÷��� 2���� ��� : ������ ���� 4��
--CUBE�� ������ �÷��� 3���� ��� : ������ ���� 8��
--CUBE�� ������ �÷����� 2�� ������ �� ����� ������ ���� ������ �ȴ� : (2^n)
--�÷��� ���ݸ� �������� ������ ������ ���� �޼������� �þ�� ������
--���� ��������� �ʴ´�

--job, deptno�� �̿��Ͽ� CUBE����
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY CUBE (job, deptno);
--job, deptno
--1, 1 -->GROUP BY job, deptno
--1, 0 -->GROUP BY job
--0, 1 -->GROUP BY deptno
--0, 0 -->GROUP BY --���̺��� ����࿡ ���� GROUP BY

--GROOUP BY ����
--GROUP BY, ROLLUP, CUBE�� ���� ����ϱ�
--������ ������ �����غ��� ���� ����� ������ �� �ִ�
--GROUP BY job, rollup(deptno), cube(mgr)

SELECT job, deptno, mgr, SUM(sal+NVL(comm, 0)) sal_comm_sum
FROM emp
GROUP BY job, rollup(deptno), cube(mgr);

SELECT job, JOB, SUM(sal)
FROM emp
GROUP BY job, rollup(deptno), cube(mgr);

-- sub_a1
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER);

UPDATE dept_test 
SET empcnt = (SELECT count(*)deptno
                FROM emp
                WHERE emp.deptno = dept_test.deptno);

--deptno = 10 --> empcnt = 3,                
--deptno = 10 --> empcnt = 5,
--deptno = 10 --> empcnt = 6,

SELECT *
FROM dept_test;

--sub-a2
insert into dept_test values (99, 'it1', 'daejoen');
insert into dept_test values (98, 'it2', 'daejoen');

DELETE FROM dept_test 
WHERE deptno  NOT IN (SELECT deptno
                        FROM emp
                    GROUP BY deptno);
                
--10, 20, 30, 40, 98, 99
--���� 40, 98, 99
SELECT *
FROM dept_test
WHERE deptno NOT IN(10, 20, 30);

--10. 20. 30
SELECT deptno
FROM emp
GROUP BY deptno;

--sub_a3
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

UPDATE emp_test 
SET sal = sal + 200
WHERE sal <(SELECT ROUND(AVG(sal), 2)
                FROM emp
                WHERE deptno = emp_test.deptno);


SELECT empno, ename, deptno, sal
FROM emp_test
ORDER BY deptno;

SELECT ROUND(AVG(sal), 2)
FROM emp_test
WHERE deptno = 30;

ROLLBACK;

SELECT deptno, AVG(sal)
FROM emp_test
GROUP BY deptno;
--MERGE ������ �̿��� ������Ʈ

MERGE INTO emp_test a
USING (SELECT deptno, AVG(sal) avg_sal
        FROM emp_test
        GROUP BY deptno) b
ON ( a.deptno = b.deptno)
WHEN MATCHED THEN 
     UPDATE SET sal = CASE 
                        WHEN a.sal < b.avg_sal THEN sal + 200
                        ELSE sal
     END;

