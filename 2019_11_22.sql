--where8

SELECT *
FROM emp
WHERE deptno <> 10 -- <>, !=
AND hiredate > TO_DATE ('19810601', 'yyyymmdd');

--where9

SELECT *
FROM emp
WHERE deptno NOT IN 10 -- <>, !=
AND hiredate > TO_DATE ('19810601', 'yyyymmdd');

SELECT *
FROM emp
WHERE deptno NOT LIKE 10 -- <>, !=
AND hiredate > TO_DATE ('19810601', 'yyyymmdd');

--where 10 (NOT IN ������ ��� ����, IN �����ڸ� ��밡��)
--deptno �÷��� ���� 10, 20, 30�� ���� �Ѵ�
SELECT *
FROM emp
WHERE deptno IN (20, 30) --20, 30
AND hiredate > TO_DATE ('19810601', 'yyyymmdd');

--where 11
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR hiredate > TO_DATE ('19810601', 'yyyymmdd');

--where 12

SELECT *
FROM emp
WHERE job = 'SALESMAN' --���ڿ� ����� '��Ŭ �����̼�' 
OR empno LIKE '78%';

--where 13 (LIKE ������ ������� ���ƶ�)
--�������� : EMPNO�� ���ڿ����Ѵ� ( DESC emp.empno NUMBER)
DESC emp;

SELECT *
FROM emp
WHERE job = 'SALESMAN' 
OR empno BETWEEN 7800 AND 7899; --BETWEEN A AND B A�� B������ ���ڻ���


--������ �켱���� (AND > OR)
--�����̸��� SMITH �̰ų�, �����̸��� ALLEN�̸鼭 ��Ȱ�� SALESMAN�� ����
SELECT *
FROM emp
WHERE ename = 'SMITH' 
OR (ename = 'ALLEM' AND job = 'SALESMAN');

--�����̸��� SMITH�̰ų� ALLEN�̸鼭 ��Ȱ�� SALESMAN�� ���

SELECT *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN') AND job = 'SALESMAN';

--where 14
SELECT *
FROM emp
WHERE (job = 'SALESMAN' OR EMPNO LIKE '78%') AND HIREDATE > TO_DATE('19810601', 'yyyymmdd');

--������ ����
--ORDER BY
--ASC ��������(�⺻) (1, 2, 3, 4, 5) ǥ����Ұ�� �⺻��
--DESC  �������� (5, 4, 3, 2, 1) ���������� �ݵ�� ǥ��

/*
SELCELT  coll, coll2, ....
FROM ���̺� ��
WHERE coll = '��'
ORDER BY ���ı��� �÷�1 [ASC / DESC]. ���ı��� �÷�2...[ASC / DESC]
�÷��� �ڿ� ���ı����� ����
*/

--��� (emo) ���̺��� ������ ������ ���� �̸����� �������� ����
SELECT *
FROM emp
ORDER BY ename ASC; --��������

SELECT *
FROM emp
ORDER BY ename DESC; --��������

--���(emp) ���̺��� ������ ������ �μ���ȣ�� �������� �����ϰ�
--�μ���ȣ�� �������� sal �������� ����
--�޿�(sal)�� �������� �̸����� ��������(ASC)���� �Ѵ�
SELECT *
FROM emp
ORDER BY deptno, sal DESC;

SELECT *
FROM emp
ORDER BY ename;

SELECT *
FROM emp
WHERE (job = 'SALESMAN' OR EMPNO LIKE '78%') AND HIREDATE > TO_DATE('19810601', 'yyyymmdd');

--���� �÷��� ALLAS�� ǥ��
SELECT deptno, sal, ename nm
FROM emp
ORDER BY nm;

--��ȸ�ϴ� �÷��� ��ġ �ε����� ǥ�� ����
SELECT deptno, sal, ename nm
FROM emp
ORDER BY 3; --��õ������ �ʴ´�(�÷� �߰��� �ǵ����� ���� ����� ���� �� ����)   

--order by 1
--dept���̺��� ��� ������ �μ��̸����� �������� ����
DESC dept;
SELECT *
FROM dept
ORDER BY dname;


SELECT *
FROM dept
ORDER BY LOC;

--order by 2
-- emp ���̺��� �������� �ִ� ����鸸 ��ȸ
-�󿩰� ���� ��� ������� �������� (ASC)
SELECT *
FROM emp 
WHERE comm IS NOT null 
AND comm != 0
ORDER BY comm DESC , empno;

--order by 3
SELECT *
FROM emp
WHERE mgr IS NOT null
ORDER BY job, empno DESC;

--order by 4
SELECT *
FROM emp
WHERE deptno IN (10,30) AND sal > 1500
ORDER BY ename DESC;

--ROWNUM
SELECT ROWNUM, empno, ename 
FROM emp;

SELECT ROWNUM, empno, ename 
FROM emp
WHERE ROWNUM = 1;  --ROWNUM  = equal �񱳴� 1�� ����

SELECT ROWNUM, empno, ename 
FROM emp
WHERE ROWNUM >= 1;  -- <= (<) ROWNUM�� 1���� ���������� ��ȸ�ϴ� ���� ����

SELECT ROWNUM, empno, ename 
FROM emp
WHERE ROWNUM BETWEEN 1 AND 20; --BETWEEN���ε� ���� 1���� �����ϴ� ��� ����

--SELECT ����  ORDER BY ������ ���� ����
--SELECT -> ROWNUM -> ORDER BY
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

--INLINE VIEW�� ���� ���� ���� �����ϰ�, �ش� ����� ROWNUM�� ����
--SELECT���� *�� ǥ���ϰ�, �ٸ� �÷� ǥ������ ���� ��� *�տ�  ���̺���̳�, ���̺� ��Ī�� ����
SELECT ROWNUM,  a.* --empno, ename
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename) a;
    
SELECT emp.*
FROM emp;


SELECT emp.*
FROM emp;

--rownum 1
SELECT ROWNUM rn, empno, ename
FROM emp 
WHERE ROWNUM <= 10;

--rownum 2 (ROWNUM�� 11 ~ 14�� ������)
SELECT A.*
FROM
    (SELECT ROWNUM rn, empno, ename
    FROM emp) A
WHERE rn BETWEEN 11 AND 14;

--row_3
--����� emp���̺��� ename���� ������ ����� 11��°��� 14��° �ุ ��ȸ�ϴ� ������ �ۼ��غ��ÿ�
SELECT anr.*
FROM(SELECT ROWNUM rn, b.*
    FROM (SELECT *
    FROM
    (SELECT empno, ename 
    FROM emp
    ORDER BY ename))b) anr
WHERE rn BETWEEN 11 AND 14;   