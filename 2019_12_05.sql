--sub4
INSERT INTO dept VALUES (99,'ddit','daejeon');
COMMIT;

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                    FROM emp);
                    
--직원이 존재하는 부서
SELECT deptno
FROM emp;

--직원이 존재하는 부서 정보
SELECT *
FROM dept
WHERE deptno IN (SELECT deptno
                    FROM emp);

SELECT dept.*
FROM dept, emp
WHERE dept.deptno = emp.deptno(+)
AND emp.deptno IS NULL;

--sub5
SELECT product.PID, product.PNM
FROM product 
WHERE pid NOT IN (SELECT PID
                    FROM cycle
                    WHERE CID = 1);
    
    
--sub6
SELECT *
FROM cycle
WHERE cid IN 1
AND pid IN (SELECT pid
            FROM cycle
            WHERE cid IN 2);
            
--sub7

SELECT a.cid, b.cnm, c.pid, c.pnm, day, cnt
FROM
    (SELECT *
    FROM cycle
    WHERE cid IN 1
    AND pid IN (SELECT pid
                FROM cycle
                WHERE cid IN 2)) a, customer b, product c
WHERE a.cid = b.cid
AND a.pid = c.pid;


SELECT cycle.cid, customer.cnm, cycle.pid, product.pnm,
       cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid =1
AND cycle.cid = customer.cid
AND product.pid = cycle.pid
AND cycle.pid IN(SELECT pid
            FROM cycle
            WHERE cid IN 2);
            
--매니저가 하는 직원 정보 조회
SELECT *
FROM emp e
WHERE EXISTS (SELECT 1
                FROM emp m
                WHERE m.empno = e.mgr);
                
--sub8
SELECT e.*
FROM emp e, emp m
WHERE m.empno = e.mgr; 

SELECT *
FROM emp
WHERE mgr IS NOT NULL;


--sub9
SELECT *
FROM product 
WHERE EXISTS (  SELECT 'X'
                  FROM cycle
                 WHERE cid IN 1
                 AND cycle.pid = product.pid);
                 
SELECT *
FROM product 
WHERE NOT EXISTS (  SELECT 'X'
                  FROM cycle
                 WHERE cid  IN 1
                 AND cycle.pid = product.pid);
                 
--집합연산
--UNION : 합집하브 두집합의 중복건은 제거한다
--담당업무가 SALESMAN인 직원의 직원번호, 직원의 이름조회
--위아래 결과셋이 동일하기 떄문에 합집합 연산을 하게 될 경우
--중복되는 데이터는 한번만 표현한다
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--서로다른 집합의 합집합
SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION

SELECT empno, ename
FROM emp
WHERE job = 'CLERK';

--UNION ALL
--합집합 연산시 중복제거를 하지 않는다
--위아래 결과를 셋을 붙여 주지만 하면 된다

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename
FROM emp
WHERE job = 'SALESMAN';

--집합연산시 집합셋의 컬럼이 동일 해야한다
--컬럼의 계수가 다를경우 임의의 값을 넣는 방식으로 개수를 맞춰준다
SELECT empno, ename, ''
FROM emp
WHERE job = 'SALESMAN'

UNION ALL

SELECT empno, ename,job
FROM emp
WHERE job = 'SALESMAN';

--INTERSECT : 교집합
--두집합간 공통적인 데이터만 조회
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

INTERSECT

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');

--MINUS
--차집합 : 위, 아래 집합의 교집합을 위 집합에서 제거한 집합을 조회
--차집합의 경우 합집합, 교집합과 다르게 집합의 선언 순서가 결과집합에 영향을 준다
SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN', 'CLERK')

MINUS

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN');
----------------------------------------------
SELECT *
FROM
(SELECT empno, enam
FROM emp
WHERE job IN ('CLERK'))

UNION ALL

SELECT empno, ename
FROM emp
WHERE job IN ('SALESMAN')
ORDER BY ename;

SELECT m.ename, s.ename
FROM emp m LEFT OUTER JOIN emp s ON(m.mgr = s.empno)
UNION
SELECT m.ename, s.ename
FROM emp m RIGHT OUTER JOIN emp s ON(m.mgr = s.empno)
INTERSECT
SELECT m.ename, s.ename
FROM emp m FULL OUTER JOIN emp s ON(m.mgr = s.empno);
--------------------------------------------------------------------
DESC emp;

--DML
--INSERT : 테이블에 새로운 데이터를 입력
SELECT *
FROM dept;

DELETE dept
WHERE deptno = 99;
COMMIT;

--INSERT 시 컬럼 나열한 경우
--나열한 컬럼에 맞춰 입력할 값을 동일한 순서로 기술한다
--INSERT INTO 테이블명  ( 컬럼1, 컬럼2....)
--             VALUES (값1, 값2....)
--dept 테이블에 99번 부서번호, ddit 조직명, daejeon 지역명을 갖는 데이터 입력
INSERT INTO dept (deptno, dname, loc)
            VALUES(99, 'ddit', 'daejeon');
ROLLBACK;
--컬럼을 기술할 경우 테이블의 컬럼 정의 순서와 다르게 나열해도 상솬이 없다
--dept 테이블의 컬럼순서 : deptno, dname, location
INSERT INTO dept (loc, deptno, dname)
            VALUES('daejeon',99, 'ddit');
            
--컬럼을 기술하지 않는 경우 : 테이블의 컬럼 정의 순서에 맞춰 값을 기술한다
INSERT INTO dept VALUES(99, 'ddit', 'daejeon');

--날짜 값 입력하기
--1SYSDATE
--2.사용자로 부터 받은 문자열을 DATE타입으로 변경하여 입력
DESC emp;
INSERT INTO emp VALUES (9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL);

SELECT *
FROM emp;

--2019년 12월 2일 입사
INSERT INTO emp VALUES 
(9997, 'james', 'CLERK', NULL, TO_DATE('20191202', 'YYYYMMDD'), 500, NULL, NULL);

ROLLBACK;

--여러건의 데이터를 한번에 입력
--SELECT 결과를 테이블에 입력 할 수 있다

INSERT INTO emp
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL
FROM dual

UNION ALL

SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 500, NULL, NULL
FROM dual;