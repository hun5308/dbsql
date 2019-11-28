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
    ,CASE WHEN MOD(TO_NUMBER(TO_CHAR(hiredate, 'yy')), 2) = 1 THEN '건강검진 대상자'
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
--건강검진 대상자 조회 쿼리
--1. 올해년도가 짝수/홀수년 인지
--2. hiredate에서 입사년도가 짝수 / 홀수 인지

--1. TO_CHAR(SYSDATE, 'YYYY')
--> 올해년도 구분( 0:짝수년 1:홀수년)
SELECT empno, ename, TO_CHAR(hiredate, 'yy/mm/dd') hiredate
    ,CASE 
          WHEN MOD(TO_CHAR(hiredate, 'yyyy'), 2) = 
             MOD(TO_CHAR(SYSDATE, 'yyyy')+1, 2) THEN '건강검진 대상자'
>>>>>>> Stashed changes
     ELSE '건강검진 비대상자' 
     END CONTACT_TO_DOCTOR
FROM emp;

<<<<<<< Updated upstream
SELECT empno, ename, TO_CHAR(hiredate, 'yy/mm/dd') hiredate
    ,DECODE (hiredate, 'MOD('TO_NUMBER(TO_CHAR(hiredate, 'yy')), 3' ,건강검진 대상자,
                    'MOD('TO_NUMBER(TO_CHAR(hiredate, 'yy')), 2',건강검진 비대상자) CONTACT_TO_DOCTOR
=======
-- 내년도 건강검진 대상자

SELECT empno, ename, TO_CHAR(hiredate, 'yy/mm/dd') hiredate
    ,CASE 
        WHEN MOD(TO_CHAR(hiredate, 'yyyy'), 2) = 
             MOD(TO_CHAR(SYSDATE, 'yyyy')+1, 2) THEN '건강검진 대상자'
     ELSE '건강검진 비대상자' 
     END CONTACT_TO_DOCTOR
FROM emp;
-- DECODE로 했을떄
SELECT empno, ename, TO_CHAR(hiredate, 'yy/mm/dd') hiredate
    ,DECODE (MOD(TO_CHAR(hiredate, 'yyyy'), 2), MOD(TO_CHAR(TO_DATE('2020', 'yyyy'),'YYYY'), 2),'건강검진 대상자',
                    '건강검진 비대상자') CONTACT_TO_DOCTOR
>>>>>>> Stashed changes

FROM emp;

