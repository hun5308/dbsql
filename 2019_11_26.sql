--��¥���� �Լ�
--ROUND, TRUNC
--(MONETH_BETWEEN)ADD_MONTHS, NEXT_DAT
--LAST_DAY : �ش� ��¥�� ���� ���� ������ ����(DATE)

SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM dual;


--�� : 1, 3, 5, 7, 8, 10, 12: 31��
-- : 2, 4, 6, 9, 11


--'201912'�� DATEŸ������ �����ϱ�
--�ش� ��¥�� ������ ��¥�� �̵�
--���� �ʵ常 �����ϱ�
--DATE --> �����÷�(DD)�� ����
--DATE --> ���ڿ�(DD)
--TO_CHAR(DATE, '����')
SELECT yyyymm param,
        TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') dt
FROM dual;

--SYSDATE�� YYYY/MM/DD ������ ���ڿ��� ���� (DATE -> CHAR)
--'2019/11/26'���ڿ� --> DATE
SELECT TO_DATE('2019/11/26', 'YYYY/MM/DD'), TO_CHAR(SYSDATE, 'YYYY-MM-DD') 
FROM dual;

--YYYY-MM-DD HH24:MI:SS ���ڿ��� ���
SELECT TO_CHAR(TO_DATE(TO_CHAR(SYSDATE, 'YYYY/MM/DD'), 'YYYY/MM/DD'), 'YYYY-MM-DD HH24:MI:SS')
FROM dual;

--empno�� 7369�� ���� ���� ��ȸ �ϱ�
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';


SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)
   
   EXPLAIN PLAN FOR
   SELECT *
   FROM emp
   WHERE TO_CHAR(empno) = '7369';

 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)
   
   
  EXPLAIN PLAN FOR
   SELECT *
   FROM emp
   WHERE TO_CHAR(empno) = 7300 + '69';
   
   Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_NUMBER(TO_CHAR("EMPNO"))=7369);
   
   SELECT *
   FROM TABLE(dbms_xplan.display);
   
   
   SELECT *
   FROM emp
   WHERE hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
   
   -- DATE Ÿ���� ������ ����ȯ�� ����� ������ ����
   --YY -> 19
   --RR --> 5-, 19/20?
   SELECT *
   FROM emp
    WHERE hiredate >= TO_DATE('81/06/01', 'RR/MM/DD');
   --WHERE hiredate >= '81/06/01';
   
   SELECT TO_DATE('50/05/05', 'RR/MM/DD'),
        TO_DATE('49/05/05', 'RR/MM/DD'),
          TO_DATE('50/05/05', 'YY/MM/DD'),
          TO_DATE('49/05/05', 'YY/MM/DD')
    FROM dual;
    
--���� --> ���ڿ�
--���ڿ� --> ����
--���� : 1000000 -? 1,000,000.00(�ѱ�)
--���� : 1000000 -? 1.000.000,00(����
--��¥ ���� : YYYY, MM, DD, HH24, MI, SS
--���� ���� : ����ǥ�� : 9, /�ڸ������� ���� 0ǥ�� : 0, /ȭ�� ���� : L / 1000�ڸ� ���� : , /�Ҽ��� : .
--���� -> ���ڿ� TO_CAHR(����, '����')
--���� ������ �������� ���� �ڸ����� ����� ǥ��
SELECT empno, ename, sal, TO_CHAR(sal, 'L099,999') fm_sal
FROM emp;
   
   
SELECT TO_CAHR(10000000000, '099,999,999,999,999,999,999')
FROM dual;

--NULL ó�� �Լ� : NVL, NVL2, NULLIF, COALESCE

--NVL(expr1, expr2) : �Լ� ���� �ΰ�
--expr1�� NULL �̸� expr2�� ��ȯ
--expr1�� NULL�� �ƴϸ� expr1�� ��ȯ

SELECT empno, ename, comm, NVL(comm, 0) nvl_comm
FROM emp;
  
  
--NVL2(enpr1, expr2, expr3)
--expr1 IS NOT NULL expr2����
--expr1 IS NULL expr3 ����

SELECT empno, ename, comm, NVL2(comm, 1000, -500) nvl2_comm,
        NVL2(comm, comm, -500) nvl1_comm  --NVL�� ������ ��� 
FROM emp;

--NULLIF(expr1, expr2)
--expr1 = expr2 NULL�� ����
--expr1 != expr2 expr1�� ����
--comm�� NULL�ϋ� comm+500 : NULL
--  NULLIF(NULL, NULL) : NULL
--comm�� NULL�� �ƴҶ� comm+500 : comm+500
-- NULLOF(comm, comm+500) : comm

SELECT empno, ename, comm, NULLIF(comm, comm+500) nullif_comm
FROM emp;


--COALESCE(expr1, expr2, expr3, ...)
--�����߿� ù��°�� �����ϴ� NULL�� �ƴ� exprN�� ����
--expr1 IS NOT NULL expr1�� �����ϰ�
--expr1 IS NULL COALESCE(expr2, expr3, ...)

SELECT empno, ename, comm, sal, COALESCE(comm, sal) coal_sal
FROM emp;  

--Funcion(null �ǽ� fn4)
--emp���̺��� ������ ������ ���� ��ȸ�ϵ��� ������ �ۼ��ϼ���.

SELECT empno, ename, mgr, 
        NVL(mgr, 9999)mgr_n,
        NVL2(mgr, mgr, 9999)mgr_n_2,
        COALESCE(mgr, 9999) mgr_n_3
FROM emp;


--Funcion �ǽ� fn5
users ���̺��� ������ ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���
reg_dt�� null�� ��� sysdate�� ����

SELECT userid, usernm, reg_dt, COALESCE(reg_dt, sysdate) n_reg_dt,
        NVL(reg_dt, sysdate) nvl_reg_dt
FROM users
WHERE userid NOT IN ('brown');

--condition
--case
--emp.job �÷��� ��������
-- 'SALESMAN'�̸� sal *1.05�� ������ �� ����
-- 'MANAGER'�̸� sal * 1.10�� ������ �� ����
-- 'PRESIDENT'�̸� sal * 1.20�� ������ �� ����
-- �� 3���� ������ �ƴ� ��� sal ����
-- empno, ename, sal, ���� ������ �޿� AS bouns

SELECT empno, ename, job, sal,
       CASE
            WHEN job = 'SALEMANS' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal * 1
       END bonus
       FROM emp;
       
       --NULLó�� �Լ� ������� �ʰ� CASE ���� �̿��Ͽ�
       --comm�� NULL�� ��� -10�� �����ϵ��� ����
       
       SELECT empno, ename, job, sal,
       CASE
            WHEN comm IS NULL THEN -10
            ELSE comm
        END case_null    
       FROM emp;
       
--DECODE
SELECT empno, ename, job, sal,
        DECODE(job, 'SALESMAN', sal*1.05,
                    'MANGER', sal*1.10,
                    'PRESIEDNT', sal*1.20, 
                    sal)bouns
FROM emp;                   