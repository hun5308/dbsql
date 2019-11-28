--cond3
SELECT a.userid, a.usernm, a.alias, a.reg_dt,
       DECODE( mod(a.yyyy, 2), mod(a.this_yyyy, 2), '건강검진대상', '건강검진비대상'
FROM 
    (SELECT userid, usernm, alias, reg_dt, TO_CHAR(reg_dt, 'YYYY') yyyy, 
        TO_CHAR(SYSDATE, 'YYYY') this_YYYY  
        FROM users)a ;
        
--GROUP FUNCTION
--특정 컬럼이나 , 표현을 기준으로 여러행의 값을 한행의 결과로 생성
--COUNT:건수, SUM:합계  , AVG:평균 , MAX:최대값, MIN:최소값
--전체직원을 대상으로  (14건의 -> 1건)

DESC emp;
SELECT 
       MAX(sal) max_sal, --가장 높은 급여
       MIN(sal) min_sal, --가장 낮은 급여
       ROUND (AVG(sal),2) avg_sal, --전 직원의 급여 평균
       SUM(sal) sum_sal, --전 직원의 급여 평균
       COUNT(sal) count_sal, --급여 건수(null이 아닌 값이면 1건)
       COUNT(mgr) count_mgr,--직원의 관리자 건수(KING의 경우 mgr가 없다)
       COUNT(*) count_row  --특정 컬럼의 건수가 아니라 행의 개수를 알고 싶을떄
FROM emp;


--SELECT 절에는 GROUP BY 절에 표현된 컬럼 이외의 컬림이 올 수 없다
--놀리적으로 성립이 되지 않음(여러명의 직원 정보로 한건의 데이터로 구르핑)
--단 예회적으로 상수값들은 SELECT 절에 표현 가능 
--부서번호별 그룹함수 적용
SELECT deptno, ename,
       MAX(sal) max_sal, --부서에서 가장 높은 급여
       MIN(sal) min_sal, --부서에서 가장 낮은 급여
       ROUND (AVG(sal),2) avg_sal, --부서 직원의 급여 평균
       SUM(sal) sum_sal, --부서 직원의 급여 평균
       COUNT(sal) count_sal, --부서의 급여 건수(null이 아닌 값이면 1건)
       COUNT(mgr) count_mgr,--부서 직원의 관리자 건수(KING의 경우 mgr가 없다)
       COUNT(*) count_row  --부서의 조직원수 특정 컬럼의 건수가 아니라 행의 개수를 알고 싶을떄
FROM emp
GROUP BY deptno, ename;

--그룹함수에서는 NULL 컬럼은 계산에서 제외된다
--emp테이블에서 comm컬럼이 null이 아닌 데이터는 4건이 존대, 9건읜 NULL
SELECT COUNT(comm) count_comm, --NULL이 아닌 값의 개수 4
       SUM(comm)sum_comm,    --NULL값을 제외, 300+500+1400+0 = 2200
       SUM(sal + comm) tot_sal_sum,
       SUM(sal + NVL(comm, 0)) tot_sal_sum
FROM emp;
        
        
--WHERE 절에는 GROUP 함수를 표현 할 수 없다
--1.부서별 최대 급여 구하기
--2.부서별 최대 급여 갑싱 3000이 넘는 행만 구하기
--deptno, 최대급여

SELECT  deptno, MAX(sal) max_sal
FROM emp
WHERE MAX(sal) > 3000 --ORA==00934 WHERE 절에는 GROUP 함수가 올 수 없다
GROUP BY deptno;



SELECT  deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) >= 3000;


--grp 1
SELECT 
       MAX(sal) max_sal, --가장 높은 급여
       MIN(sal) min_sal, --가장 낮은 급여
       ROUND (AVG(sal),2) avg_sal, --전 직원의 급여 평균
       SUM(sal) sum_sal, --전 직원의 급여 평균
       COUNT(sal) count_sal, --급여 건수(null이 아닌 값이면 1건)
       COUNT(mgr) count_mgr,--직원의 관리자 건수(KING의 경우 mgr가 없다)
       COUNT(*) count_row  --특정 컬럼의 건수가 아니라 행의 개수를 알고 싶을떄
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
--전체 직원수 구하기
SELECT COUNT(*), COUNT(empno), COUNT(mgr)
FROM emp;

--전체 부서수 구하기(dept)
DESC dept;
SELECT COUNT(*), COUNT(deptno), COUNT(loc)
FROM dept;

SELECT    COUNT(deptno) CNT    
FROM dept;

--grp7
--직원이 속한 부서의 개수
SELECT COUNT(COUNT(deptno)) CNT
FROM emp
GROUP BY deptno; 

SELECT COUNT(DISTINCT deptno) CNT
FROM emp;

--JOIN
--1. 테이블 구조 변경(컬럼추가)
--2. 추가된 컬럼에 값을 update
--dname 컬럼을 emp 테이블에 추가
DESC emp;
DESC dept;

--컬럼추가(dname, VARCHAR2(14))
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
-- 총 6건의 데이터 변경이 필요하다
-- 값의 중복이 잇는 형태 (반 정규형)
UPDATE emp SET dname = 'MARKET SALES'
WHERE dname = 'SALES';

