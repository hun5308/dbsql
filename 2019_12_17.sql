--WITH 
--WITH 블록이름 AS (
--                  서브쿼리
--                 )
--SELECET *
--FROM 블록이름

--deptno, avg(sal), avg_sal
--해당부서의 급여평균이 전체 직원의 급여 평균보다 높은 부서에 한해 조회
SELECT deptno, avg(sal) avg_sal
FROM emp
GROUP BY deptno
HAVING avg(sal) > (SELECT AVG(sal) FROM emp);

--WITH 절을 사용하여 위의 쿼리를 작성
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

--계층쿼리
--달력만들기
--CONNECT BY LEVEL <= N
--테이블의 ROW건수를 N만큼 반복한다
--CONNECT BY LEVEL절을 사용한 쿼리에서는
--SELECT 절에서 LEVEL이라는 특수 컬럼을 사용할 수 있다
--계층을 표현하는 특수 컬럼으로 1부터 증가하며 ROWNUM과 유사하나
--추후 배우게될 START WITH, CONNECT BY절에서 다른점을 배우게 된다

--201911
--일자 + 정수 = 정수만큼 미래의 일자
--201911 --> 해당년월의 날짜가 몇일 까찌 존재 하는가??
--1-일, 2-월, .....7-토
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

-------------------------------------학생 방법------------------------
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
ORDER BY sat; --정렬방법 변경

--실습 calendar2
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

--달력쿼리 복습 (실습calendar1)
--달력만들기 복습 데이터 sql의 일별 실적 데이터를 이용하여 1~6월의 월별 실적 데이터를 다음과같이 구하세요

SELECT NVL(MIN(DECODE(mm, '01', sales_sum)), 0) J, NVL(MIN(DECODE(mm, '02', sales_sum)), 0) F,
       NVL(MIN(DECODE(mm, '03', sales_sum)), 0) M, NVL(MIN(DECODE(mm, '04', sales_sum)), 0) A,
       NVL(MIN(DECODE(mm, '05', sales_sum)), 0) M, NVL(MIN(DECODE(mm, '06', sales_sum)), 0) J
FROM
    (SELECT TO_CHAR(dt, 'MM') mm, SUM(sales) sales_sum
    FROM  sales
    GROUP BY TO_CHAR(dt, 'MM'));

SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd='dept0' --시작점은 deptcd = 'dept0' --->XX회사 최상위 조직
CONNECT BY PRIOR deptcd = p_deptcd;

/*
    dept0 (xx회사)
        dept0_00 (디자인부)
            dept00_0 (디자인팀)
        dept0_01 (정보기획부)
            dept01_0 (기획팀)
                dept0_00_0_0(기획파트)
        dept0_02 (정보시스템부)
            dept02_0 (개발1팀)
            dept02_1 (개발2팀)