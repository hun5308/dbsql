--cond3
SELECT a.userid, a.usernm, a.alias, a.reg_dt,
       DECODE( mod(a.yyyy, 2), mod(a.this_yyyy, 2), '�ǰ��������', '�ǰ���������'
FROM 
    (SELECT userid, usernm, alias, reg_dt, TO_CHAR(reg_dt, 'YYYY') yyyy, 
        TO_CHAR(SYSDATE, 'YYYY') this_YYYY  
        FROM users)a ;
        
--GROUP FUNCTION
--Ư�� �÷��̳� , ǥ���� �������� �������� ���� ������ ����� ����
--COUNT:�Ǽ�, SUM:�հ�  , AVG:��� , MAX:�ִ밪, MIN:�ּҰ�
--��ü������ �������  (14���� -> 1��)

DESC emp;
SELECT 
       MAX(sal) max_sal, --���� ���� �޿�
       MIN(sal) min_sal, --���� ���� �޿�
       ROUND (AVG(sal),2) avg_sal, --�� ������ �޿� ���
       SUM(sal) sum_sal, --�� ������ �޿� ���
       COUNT(sal) count_sal, --�޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr,--������ ������ �Ǽ�(KING�� ��� mgr�� ����)
       COUNT(*) count_row  --Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰� ������
FROM emp;


--SELECT ������ GROUP BY ���� ǥ���� �÷� �̿��� �ø��� �� �� ����
--������� ������ ���� ����(�������� ���� ������ �Ѱ��� �����ͷ� ������)
--�� ��ȸ������ ��������� SELECT ���� ǥ�� ���� 
--�μ���ȣ�� �׷��Լ� ����
SELECT deptno, ename,
       MAX(sal) max_sal, --�μ����� ���� ���� �޿�
       MIN(sal) min_sal, --�μ����� ���� ���� �޿�
       ROUND (AVG(sal),2) avg_sal, --�μ� ������ �޿� ���
       SUM(sal) sum_sal, --�μ� ������ �޿� ���
       COUNT(sal) count_sal, --�μ��� �޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr,--�μ� ������ ������ �Ǽ�(KING�� ��� mgr�� ����)
       COUNT(*) count_row  --�μ��� �������� Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰� ������
FROM emp
GROUP BY deptno, ename;

--�׷��Լ������� NULL �÷��� ��꿡�� ���ܵȴ�
--emp���̺��� comm�÷��� null�� �ƴ� �����ʹ� 4���� ����, 9���� NULL
SELECT COUNT(comm) count_comm, --NULL�� �ƴ� ���� ���� 4
       SUM(comm)sum_comm,    --NULL���� ����, 300+500+1400+0 = 2200
       SUM(sal + comm) tot_sal_sum,
       SUM(sal + NVL(comm, 0)) tot_sal_sum
FROM emp;
        
        
--WHERE ������ GROUP �Լ��� ǥ�� �� �� ����
--1.�μ��� �ִ� �޿� ���ϱ�
--2.�μ��� �ִ� �޿� ���� 3000�� �Ѵ� �ุ ���ϱ�
--deptno, �ִ�޿�

SELECT  deptno, MAX(sal) max_sal
FROM emp
WHERE MAX(sal) > 3000 --ORA==00934 WHERE ������ GROUP �Լ��� �� �� ����
GROUP BY deptno;



SELECT  deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000;


--grp 1
SELECT 
       MAX(sal) max_sal, --���� ���� �޿�
       MIN(sal) min_sal, --���� ���� �޿�
       ROUND (AVG(sal),2) avg_sal, --�� ������ �޿� ���
       SUM(sal) sum_sal, --�� ������ �޿� ���
       COUNT(sal) count_sal, --�޿� �Ǽ�(null�� �ƴ� ���̸� 1��)
       COUNT(mgr) count_mgr,--������ ������ �Ǽ�(KING�� ��� mgr�� ����)
       COUNT(*) count_row  --Ư�� �÷��� �Ǽ��� �ƴ϶� ���� ������ �˰� ������
FROM emp;

--grp2
SELECT deptno,
       MAX(sal) max_sal, 
       MIN(sal) min_sal, 
       ROUND (AVG(sal),2) avg_sal, 
       SUM(sal) sum_sal, 
       COUNT(sal) count_sal, 
       COUNT(mgr) count_mgr,
       COUNT(*) count_row  
FROM emp
GROUP BY deptno;


--grp3
SELECT 
    CASE     
         WHEN deptno = '30' THEN 'SALES'
         WHEN deptno = '20' THEN 'RESEARCH'
         WHEN deptno = '10' THEN 'ACCOUNTING'
         END DNAME,
       MAX(sal) max_sal, 
       MIN(sal) min_sal, 
       ROUND (AVG(sal),2) avg_sal, 
       SUM(sal) sum_sal, 
       COUNT(sal) count_sal, 
       COUNT(mgr) count_mgr,
       COUNT(*) count_row  
FROM emp
GROUP BY deptno
ORDER BY dname;

--grp4-1
SELECT TO_CHAR(hiredate, 'yyyymm') HIRE_YYYYMM,
    COUNT(TO_CHAR(hiredate, 'yyyymm')) CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyymm');

--grp4-2
SELECT hire_yyyymm, COUNT(*) cnt
FROM
    (SELECT TO_CHAR(hiredate, 'yyyymm') HIRE_YYYYMM
    FROM emp)
GROUP BY hire_yyyymm;


--grp5
SELECT TO_CHAR(hiredate, 'yyyy') HIRE_YYYY,
    COUNT(TO_CHAR(hiredate, 'yyyy')) CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyy');

--grp6
--��ü ������ ���ϱ�
SELECT COUNT(*), COUNT(empno), COUNT(mgr)
FROM emp;

--��ü �μ��� ���ϱ�(dept)
DESC dept;
SELECT COUNT(*), COUNT(deptno), COUNT(loc)
FROM dept;

SELECT    COUNT(deptno) CNT    
FROM dept;

--grp7
--������ ���� �μ��� ����
SELECT COUNT(COUNT(deptno)) CNT
FROM emp
GROUP BY deptno; 

SELECT COUNT(DISTINCT deptno) CNT
FROM emp;

--JOIN
--1. ���̺� ���� ����(�÷��߰�)
--2. �߰��� �÷��� ���� update
--dname �÷��� emp ���̺� �߰�
DESC emp;
DESC dept;

--�÷��߰�(dname, VARCHAR2(14))
ALTER TABLE emp ADD (dname VARCHAR2(14));
DESC emp;

SELECT *
FROM emp;

UPDATE emp SET dname = CASE
                            WHEN deptno = 10 THEN 'ACCOUTING'
                            WHEN deptno = 20 THEN 'RESEARCH'
                            WHEN deptno = 30 THEN 'SALES'
                            END;
COMMIT;

SELECT empno, ename, deptno, dname
FROM emp;


--SALES --> MARKET SALES
-- �� 6���� ������ ������ �ʿ��ϴ�
-- ���� �ߺ��� �մ� ���� (�� ������)
UPDATE emp SET dname = 'MARKET SALES'
WHERE dname = 'SALES';

