--emp ���̺�, dept���̺� ����
EXPLAIN PLAN FOR 
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno --�����
AND emp.deptno = 10;

SELECT ename, deptno
FROM emp;

SELECT deptno, dname
FROM dept;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


SELECT ename, emp.deptno, dept.dname
FROM emp, dep
WHERE emp.deptno != dept.deptno --�����
AND emp.deptno = 10;

SELECT ename, deptno
FROM emp;

SELECT deptno, dname
FROM dept;

--natural join : ���� ���̺� ���� Ÿ��, ���� �̸��� �÷�����
--              ���� ���� ���� ��� ����
DESC emp;
DESC dept;

--ANSI SQL
SELECT deptno, a.empno, ename
FROM emp a NATURAL JOIN dept b;

ALTER TABLE emp DROP COLUMN dname;

--oracle ����
SELECT a.deptno, a.empno, ename
FROM emp a, dept b
WHERE a.deptno = b.deptno;

--JOIN USING
--join �Ϸ����ϴ� ���̺� ������ �̸��� �ø��� �ΰ� �̻��� ��
--join �÷��� �ϳ��� ����ϰ� ���� ��

--ANSI SQL
SELECT *
FROM emp JOIN dept USING (deptno);

--ORACLE SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI SQL JOIN with ON
--���� �ϰ��� �ϴ� ���̺��� �÷� �̸��� �ٸ��� 
--�����ڰ� ���� ������ ���� ������ ��

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.deptno = 10;

--oracle
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : ���� ���̺� ����
--emp ���̺� ���� �Ҹ��� ���� : ������ ������ ���� ��ȸ 
--������ ������ ���� ��ȸ
--�����̸�, ������ �̸�
--ansi sql
SELECT e.ename, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);



--oracle
SELECT e.ename, m.ename -- 3. ��� �����Ͷ�
FROM emp e, emp m -- 1.� ���̺���
WHERE e.mgr = m.empno; --2. ���ǿ� �����ϴ� ������

--���� �̸�, ������ ����� �̸�, ������ ������� ����� �̸�, ���� �������� �������� �������� �̸�
--���һ�.....��ģ....
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e, emp  m, emp t, emp k
WHERE e.mgr = m.empno AND m.mgr = t.empno AND t.mgr = k.empno;

--�������̺��� ANSI JOIN�� �̿��� JOIN
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno)
    JOIN emp t ON (m.mgr = t.empno) JOIN emp k ON (t.mgr = k.empno);
    
    
--������ �̸���, �ش� ������ ������ �̸��� ��ȸ�Ѵ�
--�� ������ ����� 7369 ~ 7689�� ������ ������� ��ȸ
SELECT ename, empno
FROM emp;

SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno
AND e.empno >= 7369 AND e.empno <= 7689;

SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.empno BETWEEN 7369 AND 7698
AND e.mgr = m.empno;

--ANSI
SELECT s.ename, m.ename
FROM emp s JOIN emp m ON(s.mgr = m.empno)
WHERE s.empno BETWEEN 7369 AND 7698;

--NON= EQUI JOIN : ���� ������  =(equal)�� �ƴ� JOIN
-- != , BETWEEN AND

SELECT *
FROM salgrade;

SELECT empno, ename, sal /*�޿� grade */
FROM emp;

--ANSI SQL
SELECT empno, ename, sal, salgrade.losal, salgrade.hisal
FROM emp JOIN salgrade
ON emp.sal BETWEEN  salgrade.losal AND salgrade.hisal;
--Oracle
SELECT empno, ename, sal, salgrade.losal, salgrade.hisal
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;
--�޿� ��� ���̱�
--1-1
SELECT empno, ename, sal, grade
FROM emp, salgrade
WHERE emp.sal >= salgrade.losal AND emp.sal <= salgrade.hisal;
--1-2
SELECT empno, ename, sal, grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;


--join0
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY deptno;

SELECT a.empno, a.ename, b.deptno, b.dname
FROM emp a, dept b
WHERE a.deptno = b.deptno
ORDER BY deptno;

SELECT a.empno, a.ename, b.deptno, b.dname
FROM emp a JOIN dept b
ON a.deptno = b.deptno
ORDER BY deptno;

--join01
SELECT c.*
FROM(SELECT a.empno, a.ename, b.deptno, b.dname
FROM emp a, dept b
WHERE a.deptno = b.deptno) c 
WHERE c.deptno = 10 OR c.deptno = 30
ORDER BY empno;


SELECT c.*
FROM(SELECT a.empno, a.ename, b.deptno, b.dname
FROM emp a JOIN dept b
ON a.deptno = b.deptno) c 
WHERE c.deptno = 10 OR c.deptno = 30
ORDER BY empno;


SELECT a.empno, a.ename, b.deptno, b.dname
FROM emp a, dept b
WHERE a.deptno = b.deptno 
AND a.deptno IN (10,30)
ORDER BY empno;

--join02
SELECT c.*
FROM(SELECT a.empno, a.ename, a.sal, b.deptno, b.dname
FROM emp a JOIN dept b
ON a.deptno = b.deptno) c 
WHERE c.sal > 2500
ORDER BY c.deptno;


