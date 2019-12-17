--WITH 
--WITH ����̸� AS (
--                  ��������
--                 )
--SELECET *
--FROM ����̸�

--deptno, avg(sal), avg_sal
--�ش�μ��� �޿������ ��ü ������ �޿� ��պ��� ���� �μ��� ���� ��ȸ
SELECT deptno, avg(sal) avg_sal
FROM emp
GROUP BY deptno
HAVING avg(sal) > (SELECT AVG(sal) FROM emp);

--WITH ���� ����Ͽ� ���� ������ �ۼ�
WITH dept_sal_avg AS(
    SELECT deptno, avg(sal) avg_sal
    FROM emp
    GROUP BY deptno), 
    emp_sal_avg AS(
    SELECT AVG(sal) avg_sal FROM emp) 
SELECT *
FROM dept_sal_avg
WHERE dept_sal_avg.avg_sal > (SELECT avg_sal FROM emp_sal_avg); 

WITH test AS(
    SELECT 1, 'TEST' FROM DUAL UNION ALL
    SELECT 2, 'TEST2' FROM DUAL UNION ALL
    SELECT 3, 'TEST3' FROM DUAL )
SELECT *
FROM test;

--��������
--�޷¸����
--CONNECT BY LEVEL <= N
--���̺��� ROW�Ǽ��� N��ŭ �ݺ��Ѵ�
--CONNECT BY LEVEL���� ����� ����������
--SELECT ������ LEVEL�̶�� Ư�� �÷��� ����� �� �ִ�
--������ ǥ���ϴ� Ư�� �÷����� 1���� �����ϸ� ROWNUM�� �����ϳ�
--���� ���Ե� START WITH, CONNECT BY������ �ٸ����� ���� �ȴ�

--201911
--���� + ���� = ������ŭ �̷��� ����
--201911 --> �ش����� ��¥�� ���� ���� ���� �ϴ°�??
--1-��, 2-��, .....7-��
SELECT /*dt, d, iw, dt-(d-1)*/
       MAX(DECODE(d, 1, dt)) S, MAX(DECODE(d, 2, dt)) M, MAX(DECODE(d, 3, dt)) T, MAX(DECODE(d, 4, dt)) W, 
       MAX(DECODE(d, 5, dt)) T, MAX(DECODE(d, 6, dt)) F, MAX(DECODE(d, 7, dt)) SAT
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) DT,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
FROM dual
CONNECT BY LEVEL <=  TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
GROUP BY dt-(d-1)
ORDER BY dt-(d-1);

-------------------------------------�л� ���------------------------
SELECT /*dt, d, iw, dt-(d-1)*/
       MAX(DECODE(d, 1, dt)) S, MAX(DECODE(d, 2, dt)) M, MAX(DECODE(d, 3, dt)) T, MAX(DECODE(d, 4, dt)) W, 
       MAX(DECODE(d, 5, dt)) T, MAX(DECODE(d, 6, dt)) F, MAX(DECODE(d, 7, dt)) SAT
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) DT,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
FROM dual
CONNECT BY LEVEL <=  TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
GROUP BY iw 
ORDER BY sat; --���Ĺ�� ����

--�ǽ� calendar2
SELECT /*dt, d, iw, dt-(d-1)*/
       MAX(DECODE(d, 1, dt)) S, MAX(DECODE(d, 2, dt)) M, MAX(DECODE(d, 3, dt)) T, MAX(DECODE(d, 4, dt)) W, 
       MAX(DECODE(d, 5, dt)) T, MAX(DECODE(d, 6, dt)) F, MAX(DECODE(d, 7, dt)) SAT
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) DT,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL), 'IW') iw
FROM dual
CONNECT BY LEVEL <=  TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
GROUP BY dt-(d-1)
ORDER BY dt-(d-1); 

--�޷����� ���� (�ǽ�calendar1)
--�޷¸���� ���� ������ sql�� �Ϻ� ���� �����͸� �̿��Ͽ� 1~6���� ���� ���� �����͸� ���������� ���ϼ���

SELECT NVL(MIN(DECODE(mm, '01', sales_sum)), 0) J, NVL(MIN(DECODE(mm, '02', sales_sum)), 0) F,
       NVL(MIN(DECODE(mm, '03', sales_sum)), 0) M, NVL(MIN(DECODE(mm, '04', sales_sum)), 0) A,
       NVL(MIN(DECODE(mm, '05', sales_sum)), 0) M, NVL(MIN(DECODE(mm, '06', sales_sum)), 0) J
FROM
    (SELECT TO_CHAR(dt, 'MM') mm, SUM(sales) sales_sum
    FROM  sales
    GROUP BY TO_CHAR(dt, 'MM'));

SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd='dept0' --�������� deptcd = 'dept0' --->XXȸ�� �ֻ��� ����
CONNECT BY PRIOR deptcd = p_deptcd;

/*
    dept0 (xxȸ��)
        dept0_00 (�����κ�)
            dept00_0 (��������)
        dept0_01 (������ȹ��)
            dept01_0 (��ȹ��)
                dept0_00_0_0(��ȹ��Ʈ)
        dept0_02 (�����ý��ۺ�)
            dept02_0 (����1��)
            dept02_1 (����2��)