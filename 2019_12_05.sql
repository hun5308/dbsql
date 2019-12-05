--sub4
INSERT INTO dept VALUES (99,'ddit','daejeon');
COMMIT;

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                    FROM emp);
                    
--������ �����ϴ� �μ�
SELECT deptno
FROM emp;

--������ �����ϴ� �μ� ����
SELECT *
FROM dept
WHERE deptno IN (SELECT deptno
                    FROM emp);

SELECT dept.*
FROM dept, emp
WHERE dept.deptno = emp.deptno(+)
AND emp.deptno IS NULL;

--sub5
SELECT product.PID, product.PNM
FROM product 
WHERE pid NOT IN (SELECT PID
                    FROM cycle
                    WHERE CID = 1);
    
    
--sub6
SELECT *
FROM cycle
WHERE cid IN 1
AND pid IN (SELECT pid
            FROM cycle
            WHERE cid IN 2);
            
--sub7

SELECT a.cid, b.cnm, c.pid, c.pnm, day, cnt
FROM
    (SELECT *
    FROM cycle
    WHERE cid IN 1
    AND pid IN (SELECT pid
                FROM cycle
                WHERE cid IN 2)) a, customer b, product c
WHERE a.cid = b.cid
AND a.pid = c.pid;


SELECT cycle.cid, customer.cnm, cycle.pid, product.pnm,
       cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid =1
AND cycle.cid = customer.cid
AND product.pid = cycle.pid
AND cycle.pid IN(SELECT pid
            FROM cycle
            WHERE cid IN 2);
            
--�Ŵ����� �ϴ� ���� ���� ��ȸ
SELECT *
FROM emp e
WHERE EXISTS (SELECT 1
                FROM emp m
                WHERE m.empno = e.mgr);
                
--sub8
SELECT e.*
FROM emp e, emp m
WHERE m.empno = e.mgr; 

SELECT *
FROM emp
WHERE mgr IS NOT NULL;


--sub9
SELECT *
FROM product 
WHERE EXISTS (  SELECT 'X'
                  FROM cycle
                 WHERE cid IN 1
                 AND cycle.pid = product.pid);
                 
SELECT *
FROM product 
WHERE NOT EXISTS (  SELECT 'X'
                  FROM cycle
                 WHERE cid  IN 1
                 AND cycle.pid = product.pid);
                 
--���տ���
--UNION : �����Ϻ� �������� �ߺ����� �����Ѵ�
--�������� SALESMAN�� ������ ������ȣ, ������ �̸���ȸ
--���Ʒ� ������� �����ϱ� ������ ������ ������ �ϰ� �� ���
--�ߺ��Ǵ� �����ʹ� �ѹ��� ǥ���Ѵ�
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--���δٸ� ������ ������
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'CLERK';

--UNION ALL
--������ ����� �ߺ����Ÿ� ���� �ʴ´�
--���Ʒ� ����� ���� �ٿ� ������ �ϸ� �ȴ�

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--���տ���� ���ռ��� �÷��� ���� �ؾ��Ѵ�
--�÷��� ����� �ٸ���� ������ ���� �ִ� ������� ������ �����ش�
SELECT empno, ename, ''
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename,job
FROM emp
WHERE job = 'SALESMAN';

--INTERSECT : ������
--�����հ� �������� �����͸� ��ȸ
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

INTERSECT

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');

--MINUS
--������ : ��, �Ʒ� ������ �������� �� ���տ��� ������ ������ ��ȸ
--�������� ��� ������, �����հ� �ٸ��� ������ ���� ������ ������տ� ������ �ش�
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

MINUS

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');
----------------------------------------------
SELECT *
FROM
(SELECT empno, enam
FROM emp
WHERE job IN ('CLERK'))

UNION ALL

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN')
ORDER BY ename;

SELECT m.ename, s.ename
FROM emp m LEFT OUTER JOIN emp s ON(m.mgr = s.empno)
UNION
SELECT m.ename, s.ename
FROM emp m RIGHT OUTER JOIN emp s ON(m.mgr = s.empno)
INTERSECT
SELECT m.ename, s.ename
FROM emp m FULL OUTER JOIN emp s ON(m.mgr = s.empno);
--------------------------------------------------------------------
DESC emp;

--DML
--INSERT : ���̺� ���ο� �����͸� �Է�
SELECT *
FROM dept;

DELETE dept
WHERE deptno = 99;
COMMIT;

--INSERT �� �÷� ������ ���
--������ �÷��� ���� �Է��� ���� ������ ������ ����Ѵ�
--INSERT INTO ���̺��  ( �÷�1, �÷�2....)
--             VALUES (��1, ��2....)
--dept ���̺� 99�� �μ���ȣ, ddit ������, daejeon �������� ���� ������ �Է�
INSERT INTO dept (deptno, dname, loc)
            VALUES(99, 'ddit', 'daejeon');
ROLLBACK;
--�÷��� ����� ��� ���̺��� �÷� ���� ������ �ٸ��� �����ص� ����� ����
--dept ���̺��� �÷����� : deptno, dname, location
INSERT INTO dept (loc, deptno, dname)
            VALUES('daejeon',99, 'ddit');
            
--�÷��� ������� �ʴ� ��� : ���̺��� �÷� ���� ������ ���� ���� ����Ѵ�
INSERT INTO dept VALUES(99, 'ddit', 'daejeon');

--��¥ �� �Է��ϱ�
--1SYSDATE
--2.����ڷ� ���� ���� ���ڿ��� DATEŸ������ �����Ͽ� �Է�
DESC emp;
INSERT INTO emp VALUES (9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL);

SELECT *
FROM emp;

--2019�� 12�� 2�� �Ի�
INSERT INTO emp VALUES 
(9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'YYYYMMDD'), 500, NULL, NULL);

ROLLBACK;

--�������� �����͸� �ѹ��� �Է�
--SELECT ����� ���̺� �Է� �� �� �ִ�

INSERT INTO emp
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL
FROM dual

UNION ALL

SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL
FROM dual;