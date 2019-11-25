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

--where 10 (NOT IN 연산자 사용 금지, IN 연산자만 사용가능)
--deptno 컬럼의 값은 10, 20, 30만 존대 한다
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
WHERE job = 'SALESMAN' --문자열 상수는 '싱클 쿼테이션' 
OR empno LIKE '78%';

--where 13 (LIKE 연산을 사용하지 말아라)
--전재조건 : EMPNO가 숫자여야한다 ( DESC emp.empno NUMBER)
DESC emp;

SELECT *
FROM emp
WHERE job = 'SALESMAN' 
OR empno BETWEEN 7800 AND 7899; --BETWEEN A AND B A와 B사이의 숫자사이


--연산자 우선순위 (AND > OR)
--직원이름이 SMITH 이거나, 직원이름이 ALLEN이면서 역활이 SALESMAN인 직원
SELECT *
FROM emp
WHERE ename = 'SMITH' 
OR (ename = 'ALLEM' AND job = 'SALESMAN');

--직원이름이 SMITH이거나 ALLEN이면서 역활이 SALESMAN인 사람

SELECT *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN') AND job = 'SALESMAN';

--where 14
SELECT *
FROM emp
WHERE (job = 'SALESMAN' OR EMPNO LIKE '78%') AND HIREDATE > TO_DATE('19810601', 'yyyymmdd');

--데이터 정렬
--ORDER BY
--ASC 오름차순(기본) (1, 2, 3, 4, 5) 표기안할경우 기본값
--DESC  내림차순 (5, 4, 3, 2, 1) 내림차순시 반드시 표기

/*
SELCELT  coll, coll2, ....
FROM 테이블 명
WHERE coll = '값'
ORDER BY 정렬기준 컬럼1 [ASC / DESC]. 정렬기준 컬럼2...[ASC / DESC]
컬럼명 뒤에 정렬기준을 쓴다
*/

--사원 (emo) 테이블에서 직원이 정보를 직원 이름으로 오름차순 정렬
SELECT *
FROM emp
ORDER BY ename ASC; --오름차순

SELECT *
FROM emp
ORDER BY ename DESC; --내림차순

--사원(emp) 테이블에서 직원의 정보를 부서번호로 오름차순 정렬하고
--부서번호가 같을떄는 sal 내림차순 정렬
--급여(sal)가 같을떄는 이름으로 오름차순(ASC)정렬 한다
SELECT *
FROM emp
ORDER BY deptno, sal DESC;

SELECT *
FROM emp
ORDER BY ename;

SELECT *
FROM emp
WHERE (job = 'SALESMAN' OR EMPNO LIKE '78%') AND HIREDATE > TO_DATE('19810601', 'yyyymmdd');

--정렬 컬럼을 ALLAS로 표현
SELECT deptno, sal, ename nm
FROM emp
ORDER BY nm;

--조회하는 컬럼의 위치 인덱스로 표현 가능
SELECT deptno, sal, ename nm
FROM emp
ORDER BY 3; --추천하지는 않는다(컬럼 추가시 의도하지 않은 결과가 나올 수 있음)   

--order by 1
--dept테이블의 모든 정보를 부서이름으로 오름차순 정렬
DESC dept;
SELECT *
FROM dept
ORDER BY dname;


SELECT *
FROM dept
ORDER BY LOC;

--order by 2
-- emp 테이블에서 상여정보가 있는 사람들만 조회
-상여가 같을 경우 사번으로 오름차순 (ASC)
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
WHERE ROWNUM = 1;  --ROWNUM  = equal 비교는 1만 가능

SELECT ROWNUM, empno, ename 
FROM emp
WHERE ROWNUM >= 1;  -- <= (<) ROWNUM을 1부터 순차적으로 조회하는 경우는 가능

SELECT ROWNUM, empno, ename 
FROM emp
WHERE ROWNUM BETWEEN 1 AND 20; --BETWEEN으로도 가능 1부터 시작하는 경우 가능

--SELECT 절과  ORDER BY 구문의 실행 순서
--SELECT -> ROWNUM -> ORDER BY
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

--INLINE VIEW를 통해 정렬 먼저 실행하고, 해당 결과에 ROWNUM을 적용
--SELECT절에 *을 표현하고, 다른 컬럼 표현식을 썻을 경우 *앞에  테이블명이나, 테이블 별칭을 적용
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

--rownum 2 (ROWNUM이 11 ~ 14인 데이터)
SELECT A.*
FROM
    (SELECT ROWNUM rn, empno, ename
    FROM emp) A
WHERE rn BETWEEN 11 AND 14;

--row_3
--사원의 emp테이블에서 ename으로 정렬한 결과에 11번째행과 14번째 행만 조회하는 쿼리를 작성해보시오
SELECT anr.*
FROM(SELECT ROWNUM rn, b.*
    FROM (SELECT *
    FROM
    (SELECT empno, ename 
    FROM emp
    ORDER BY ename))b) anr
WHERE rn BETWEEN 11 AND 14;   