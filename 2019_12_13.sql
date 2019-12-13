--merge

SELECT *
FROM emp_test
ORDER BY empno;

--emp���̺� �����ϴ� �����͸� emp_test ���̺�� ����
--���� empno�� ������ �����Ͱ� �����ϸ�
--ename update : ename || '_merge'
--���� empno�� ������ �����Ͱ� �������� ���� ���
--emp���̺��� empno, ename_emp_Test �����ͷ� insert

--emp_test�����Ϳ��� ������ ������ ����
DELETE emp_test
WHERE empno >= 7788;
COMMIT;


--emp ���̺��� 14���� �����Ͱ� ����
--emp_test ���̺��� ����� 7788���� ���� 7���� �����Ͱ� ����
--emp ���̺��� �̿��Ͽ� emp_test ���̺��� �����ϰ� �Ǹ�
--emp���̺��� �����ϴ� ����(����� 7788���� ũ�ų� ����) 7��
--emp_test�� ���Ӱ� insert�� �ɰ��̰�
--emp, emp_Test�� �����ȣ�� �����ϰ� �����ϴ� 7���� �����ʹ�
--(����� 7788���� ���� ����)ename�÷��� ename || '_modify'�� ��������Ʈ�� �Ѵ�

/*
MERGE INTO ���̺��
USING ������� ���̺�|VIEW|SUBQUERY
ON (���̺��� ��������� �������)
WHEN MATCHED THEN
    UPDATE.....
WHEN NOT MATCHED THEN
    INSERT.....
*/

MERGE INTO emp_test
USING emp
ON(emp.empno = emp_test.empno)
WHEN MATCHED THEN
    UPDATE SET ename = ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES(emp.empno, emp.ename);
    
--emp_test ���̺� ����� 9999�� �����Ͱ� �����ϸ�
--ename�� 'browm'���� update
--�������� ���� ��� empno, ename VALUES (9999, 'brown')���� insert
-- ���� �ó������� merge ������ Ȱ���Ͽ� �ѹ��� sql�� ����
--:empno - 9999, :ename - 'brown'
MERGE INTO emp_test
USING dual
ON (emp_test.empno = : empno)
WHEN MATCHED THEN
    UPDATE SET ename = :ename || '_mod'
WHEN NOT MATCHED THEN
    INSERT VALUES (:empno, :ename);
    
SELECT *
FROM emp_test
WHERE empno = 9999;

--���� merge������ ���ٸ�
-- 1.empno = 9999�� �����Ͱ� ���� �ϴ��� Ȯ��
-- 2-1. 1�����׿��� �����Ͱ� �����ϸ� UPDATE
-- 2-2. 1�����׿��� �����Ͱ� �������� ������ INSERT


--group_ad1
--��ü������ �޿���
SELECT SUM(sal)
FROM emp;
    

--�μ��� �޿���
SELECT deptno, SUM(sal) sal
FROM emp
    GROUP BY (deptno)
    ORDER BY deptno;

SELECT NULL , SUM(sal)
FROM emp
UNION ALL
SELECT deptno, SUM(sal) sal
FROM emp
S
    GROUP BY (deptno);
    
    
--JOIN �������
--emp ���̺��� 14�ǿ� �����͸� 28������ ����
--������(1 - 14, 2-14)�� �������� GROUP BY
--������ 1: �μ���ȣ ���� 14 row
--������ 2: ��ü 14row
SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno, 
       SUM(emp.sal) sal
FROM emp, (SELECT ROWNUM rn
            FROM dept
            WHERE ROWNUM <= 2) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);



SELECT DECODE(b.rn, 1, emp.deptno, 2, null) deptno, 
       SUM(emp.sal) sal
FROM emp, (SELECT LEVEL rn
            FROM dual
            CONNECT BY LEVEL <= 2) b
GROUP BY DECODE(b.rn, 1, emp.deptno, 2, null)
ORDER BY DECODE(b.rn, 1, emp.deptno, 2, null);




--REPORT GROUP BY
--ROLLUP
--GROUP BY ROLLUP(coll....)
--ROLLUP ���� ����� �÷��� �����ʿ��� ���� ���� �����
--SUB GROUP�� �����Ͽ� �������� GROUP BY ���� �ϳ��� SQL���� ����ǵ��� �Ѵ�
GROUP BY ROLLUP(job, deptno)
-- GROUP BY job, deptno
-- GROUP BY job
-- GROUP BY --> ��ü ���� ������� GROUP BY

--emp���̺��� �̿��ϸ� �μ���ȣ��, ��ü������ �޿����� ���ϴ� ������ 
--ROLLUP����� �̿��Ͽ� �ۼ�
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (deptno);

--EMP ���̺��� �̿��Ͽ� job, deptno �� sal+comm�հ�
                            --job �� sla+comm �հ�
                            --��ü ������ sal+comm �հ�
                            
--ROLLUP�� Ȱ���Ͽ� �ۼ�
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sla_sum
FROM emp
GROUP BY ROLLUP(job, deptno);
-- GROUP BY job, deptno
-- GROUP BY job
-- GROUP BY --> ��ü ���� ������� GROUP BY


--ROLLUP�� �÷� ������ ��ȸ����� ������ ��ģ��
GROUP BY ROLLUP(job, deptno);
-- GROUP BY job, deptno
-- GROUP BY job
-- GROUP BY --> ��ü ���� ������� GROUP BY

GROUP BY ROLLUP(deptno, job);
-- GROUP BY deptno, job
-- GROUP BY deptno    
-- GROUP BY --> ��ü ���� ������� GROUP BY


--GROUP_AD2
SELECT DECODE(GROUPING(job), 1, '�Ѱ�', job) job, deptno, SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP (job, deptno);

--GROPU AD2_1
SELECT DECODE(GROUPING(job), 1, '��', job) job, 
--DECODE(GROUPING(job), 1, '��', job) job, 
        CASE
         WHEN deptno IS NULL AND JOB IS NULL THEN '��'
         WHEN deptno IS NULL AND JOB IS NOT NULL THEN '�Ұ�'
         ELSE ''|| deptno
         --TO_CHAR(deptno)
         END,
         SUM(sal + NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP (job, deptno);
GROUP BY(job, deptno)
GROUP BY(job)
GROUP BY


--GOURP _AD3
SELECT deptno, job, sal
FROM emp
ORDER BY deptno;

SELECT deptno, job,
        SUM(sal +NVL(comm, 0)) sal_sum
FROM emp
GROUP BY ROLLUP (deptno, job);

--UNION ALL�� ġȯ
SELECT deptno, job, SUM(sal +NVL(comm, 0)) sal_sum
FROM emp
GROUP BY deptno, job

UNION ALL

SELECT deptno, null, SUM(sal +NVL(comm, 0)) sal_sum
FROM emp
GROUP BY deptno

UNION ALL

SELECT null, null, SUM(sal +NVL(comm, 0)) sal_sum
FROM emp;

--gourp ad4
SELECT dept.dname, job, SUM(sal +NVL(comm, 0)) sal_sum
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, job);

SELECT dept.dname, a.job, a.sal_sum
FROM 
        (SELECT deptno, job,
        SUM(sal +NVL(comm, 0)) sal_sum
        FROM emp
        GROUP BY ROLLUP (deptno, job)) a, dept
WHERE a.deptno = dept.deptno(+);

--group ad5
SELECT NVL(dept.dname, '����')dname , job, SUM(sal +NVL(comm, 0)) sal_sum
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, job);


SELECT NVL(dept.dname, '����')dname, a.job, a.sal_sum
FROM 
        (SELECT deptno, job,
        SUM(sal +NVL(comm, 0)) sal_sum
        FROM emp
        GROUP BY ROLLUP (deptno, job)) a, dept
WHERE a.deptno = dept.deptno(+);