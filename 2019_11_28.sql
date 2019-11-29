--emp 테이블, dept테이블 조인
EXPLAIN PLAN FOR 
SELECT ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno --연결고리
AND emp.deptno = 10;

SELECT ename, deptno
FROM emp;

SELECT deptno, dname
FROM dept;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


SELECT ename, emp.deptno, dept.dname
FROM emp, dep
WHERE emp.deptno != dept.deptno --연결고리
AND emp.deptno = 10;

SELECT ename, deptno
FROM emp;

SELECT deptno, dname
FROM dept;

--natural join : 조인 테이블간 같은 타입, 같은 이름의 컬럼으로
--              같은 값을 작을 경우 조인
DESC emp;
DESC dept;

--ANSI SQL
SELECT deptno, a.empno, ename
FROM emp a NATURAL JOIN dept b;

ALTER TABLE emp DROP COLUMN dname;

--oracle 문법
SELECT a.deptno, a.empno, ename
FROM emp a, dept b
WHERE a.deptno = b.deptno;

--JOIN USING
--join 하려고하는 테이블간 동일한 이름의 컬림이 두개 이상일 떄
--join 컬럼을 하나만 사용하고 싶을 때

--ANSI SQL
SELECT *
FROM emp JOIN dept USING (deptno);

--ORACLE SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI SQL JOIN with ON
--조인 하고자 하는 테이블의 컬럼 이름이 다를떄 
--개발자가 조인 조건을 직접 제어할 떄

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.deptno = 10;

--oracle
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : 같은 테이블간 조인
--emp 테이블간 조인 할만한 사항 : 직원의 관리자 정보 조회 
--직원의 관리자 정보 조회
--직원이름, 관리자 이름
--ansi sql
SELECT e.ename, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);



--oracle
SELECT e.ename, m.ename -- 3. 어떤걸 가져와라
FROM emp e, emp m -- 1.어떤 테이블에서
WHERE e.mgr = m.empno; --2. 조건에 만족하는 데이터

--직원 이름, 직원의 상급자 이름, 직원의 상급자의 상급자 이름, 직원 관리자의 관리자의 관리자의 이름
--맙소사.....미친....
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e, emp  m, emp t, emp k
WHERE e.mgr = m.empno AND m.mgr = t.empno AND t.mgr = k.empno;

--여러테이블을 ANSI JOIN을 이용한 JOIN
SELECT e.ename, m.ename, t.ename, k.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno)
    JOIN emp t ON (m.mgr = t.empno) JOIN emp k ON (t.mgr = k.empno);
    
    
--직원의 이름과, 해당 직원의 관리자 이름을 조회한다
--단 직원의 사번이 7369 ~ 7689인 직원을 대상으로 조회
SELECT ename, empno
FROM emp;

SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno
AND e.empno >= 7369 AND e.empno <= 7689;

SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.empno BETWEEN 7369 AND 7698
AND e.mgr = m.empno;

--ANSI
SELECT s.ename, m.ename
FROM emp s JOIN emp m ON(s.mgr = m.empno)
WHERE s.empno BETWEEN 7369 AND 7698;

--NON= EQUI JOIN : 조인 조건이  =(equal)이 아닌 JOIN
-- != , BETWEEN AND

SELECT *
FROM salgrade;

SELECT empno, ename, sal /*급여 grade */
FROM emp;

--ANSI SQL
SELECT empno, ename, sal, salgrade.losal, salgrade.hisal
FROM emp JOIN salgrade
ON emp.sal BETWEEN  salgrade.losal AND salgrade.hisal;
--Oracle
SELECT empno, ename, sal, salgrade.losal, salgrade.hisal
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;
--급여 등긍 붙이기
--1-1
SELECT empno, ename, sal, grade
FROM emp, salgrade
WHERE emp.sal >= salgrade.losal AND emp.sal <= salgrade.hisal;
--1-2
SELECT empno, ename, sal, grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;


--join0
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY deptno;

SELECT a.empno, a.ename, b.deptno, b.dname
FROM emp a, dept b
WHERE a.deptno = b.deptno
ORDER BY deptno;

SELECT a.empno, a.ename, b.deptno, b.dname
FROM emp a JOIN dept b
ON a.deptno = b.deptno
ORDER BY deptno;

--join01
SELECT c.*
FROM(SELECT a.empno, a.ename, b.deptno, b.dname
FROM emp a, dept b
WHERE a.deptno = b.deptno) c 
WHERE c.deptno = 10 OR c.deptno = 30
ORDER BY empno;


SELECT c.*
FROM(SELECT a.empno, a.ename, b.deptno, b.dname
FROM emp a JOIN dept b
ON a.deptno = b.deptno) c 
WHERE c.deptno = 10 OR c.deptno = 30
ORDER BY empno;


SELECT a.empno, a.ename, b.deptno, b.dname
FROM emp a, dept b
WHERE a.deptno = b.deptno 
AND a.deptno IN (10,30)
ORDER BY empno;

--join02
SELECT c.*
FROM(SELECT a.empno, a.ename, a.sal, b.deptno, b.dname
FROM emp a JOIN dept b
ON a.deptno = b.deptno) c 
WHERE c.sal > 2500
ORDER BY c.deptno;


