--cond1
<<<<<<< Updated upstream
=======
--CASE
-- WHEN condition THEN return1
--END
>>>>>>> Stashed changes
SELECT empno, ename
    ,DECODE(deptno, '10', 'ACCOUNTING',
                    '20', 'RESEARCH',
                    '30', 'SALES',
                    '40', 'OPEARTIONS',
                    'DDIT') DNAME

FROM emp;

<<<<<<< Updated upstream


--cond2
SELECT empno, ename, TO_CHAR(hiredate, 'yy/mm/dd') hiredate
    ,CASE WHEN MOD(TO_NUMBER(TO_CHAR(hiredate, 'yy')), 2) = 1 THEN '�ǰ����� �����'
=======
SELECT empno, ename
    ,CASE 
        WHEN deptno = '10' THEN 'ACCOUNTING'
        WHEN deptno = '20' THEN 'RESEARCH'
        WHEN deptno = '30' THEN 'SALES'
        WHEN deptno = '40' THEN 'OPEARTIONS'
        ELSE 'DDIT'
    END dename
FROM emp;




--cond2
--�ǰ����� ����� ��ȸ ����
--1. ���س⵵�� ¦��/Ȧ���� ����
--2. hiredate���� �Ի�⵵�� ¦�� / Ȧ�� ����

--1. TO_CHAR(SYSDATE, 'YYYY')
--> ���س⵵ ����( 0:¦���� 1:Ȧ����)
SELECT empno, ename, TO_CHAR(hiredate, 'yy/mm/dd') hiredate
    ,CASE 
          WHEN MOD(TO_CHAR(hiredate, 'yyyy'), 2) = 
             MOD(TO_CHAR(SYSDATE, 'yyyy')+1, 2) THEN '�ǰ����� �����'
>>>>>>> Stashed changes
     ELSE '�ǰ����� ������' 
     END CONTACT_TO_DOCTOR
FROM emp;

<<<<<<< Updated upstream
SELECT empno, ename, TO_CHAR(hiredate, 'yy/mm/dd') hiredate
    ,DECODE (hiredate, 'MOD('TO_NUMBER(TO_CHAR(hiredate, 'yy')), 3' ,�ǰ����� �����,
                    'MOD('TO_NUMBER(TO_CHAR(hiredate, 'yy')), 2',�ǰ����� ������) CONTACT_TO_DOCTOR
=======
-- ���⵵ �ǰ����� �����

SELECT empno, ename, TO_CHAR(hiredate, 'yy/mm/dd') hiredate
    ,CASE 
        WHEN MOD(TO_CHAR(hiredate, 'yyyy'), 2) = 
             MOD(TO_CHAR(SYSDATE, 'yyyy')+1, 2) THEN '�ǰ����� �����'
     ELSE '�ǰ����� ������' 
     END CONTACT_TO_DOCTOR
FROM emp;
-- DECODE�� ������
SELECT empno, ename, TO_CHAR(hiredate, 'yy/mm/dd') hiredate
    ,DECODE (MOD(TO_CHAR(hiredate, 'yyyy'), 2), MOD(TO_CHAR(TO_DATE('2020', 'yyyy'),'YYYY'), 2),'�ǰ����� �����',
                    '�ǰ����� ������') CONTACT_TO_DOCTOR
>>>>>>> Stashed changes

FROM emp;

