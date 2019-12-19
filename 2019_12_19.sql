--����̸�, �����ȣ , ��ü������
SELECT ename, empno, COUNT(*), SUM(SAL)
FROM emp
GROUP BY ename, empno;


-------------------�ǽ� ana0
SELECT a.ename, a.sal, a.deptno, b.rn
FROM 
(SELECT ename, sal, deptno, ROWNUM j_rn
    FROM
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal DESC)) a,

(SELECT rn, ROWNUM j_rn
FROM
    (SELECT b.*, a.rn
    FROM 
    (SELECT ROWNUM rn
     FROM dual
     CONNECT BY level <= (SELECT COUNT(*) FROM emp)) a,
    
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) b
    WHERE b.cnt >= a.rn
    ORDER BY b.deptno, a.rn )) b
WHERE a.j_rn = b.j_rn;

--ana0- �� �м��Լ���
SELECT ename, sal, deptno, 
       RANK() OVER (PARTITION BY deptno ORDER BY sal ) rank,
       DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal ) dense_rank,
       ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal ) row_rank
FROM emp;

-----------------------------------------�ǽ� 1
SELECT empno, ename, sal, deptno, 
       RANK() OVER (ORDER BY sal DESC, empno) sal_rank,
       DENSE_RANK() OVER (ORDER BY sal DESC, empno) sal_dense_rank,
       ROW_NUMBER() OVER (ORDER BY sal DESC) sal_row_rank
FROM emp;

-----------------------------------------�ǽ� 2
SELECT b.empno, b.ename, b.deptno, a.cnt
FROM
    (SELECT deptno, count(deptno) cnt
    FROM emp
    GROUP BY  deptno) a, emp b
WHERE a.deptno = b.deptno
ORDER BY deptno;

--�����ȣ, ����̸�, �μ���ȣ , �μ��� ������
SELECT empno, ename, deptno, 
       COUNT(*) OVER (PARTITION BY deptno)
FROM emp;
-------------------------------------window functionȰ�� ana2
SELECT empno, ename, sal, deptno,
     ROUND(AVG(sal) OVER (PARTITION BY deptno), 2) avg
FROM emp;


-------------------------------------window functionȰ�� ana3
SELECT empno, ename, sal, deptno,
       MAX(sal) OVER (PARTITION BY deptno)
FROM emp;

SELECT b.empno, b.ename, b.sal, b.deptno, a.sal_max
FROM
    (SELECT deptno, MAX(sal) sal_max
    FROM emp
    GROUP BY deptno) a, emp b
WHERE a.deptno = b.deptno    
ORDER BY deptno ;
-------------------------------------window functionȰ�� ana4
SELECT empno, ename, sal, deptno,
       MIN(sal) OVER (PARTITION BY deptno)
FROM emp;

--��ü����� ������� �޿������� �ڽź��� �Ѵܰ� ��������� �޿�
--(�޿��� ���� ��� �Ի����ڰ� ��������� ���� ����)
SELECT empno, ename, hiredate, sal,
        LEAD(sal) OVER(ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

-------------------------------------window functionȰ�� ana5
SELECT empno, ename, hiredate, sal,
        LAG(sal) OVER(ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

-------------------------------------window functionȰ�� ana6
SELECT empno, ename, hiredate, job, sal, 
    LAG(sal) OVER(PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

