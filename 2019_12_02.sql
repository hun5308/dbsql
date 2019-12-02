--join 종류 
--outer join : 조인 연결에 실패 하더라고 기준이 되는 테이블의 데이터는
--나오도록 하는 join
--LEFT OUTER JOIN : 테이블1 LEFT OUTER JOIN 테이블2
--테이블1과 테이블2를 조인할때 조인에 실패하더라도 테이블1쪽에 데이터는
--조회가 되도록 한다
--조인에 실패한 행에서 테이블2의 컬럼값은 존재하지 않으므로   NULL로 표시된다.


--ORACLE outer join syntax
--일반조인과 차이점은 컬럼명에 (+)표시
-- + 표시 : 데이터가 존재하지 않는데 나와야 한느 테이블의 컬럼
-- 직원  LFET OTER JOIN 매니저
-- ON(직원.매니저번호 = 매니저.직원번호)
--ORACLE OUTER
--WHERE 직원.매니저번호 = 매니저.직원번호(+) --매니저쪽 데이터가 존재하지 않음

--ansi
SELECT e.empno, e.ename,m.empno, m.ename 
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);

--oracle
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);


--매니저 부서번호 제한
--anso sql WHERE 절에 기술
-- -->OUTER 조인이 적용되지 않는 상황
--**아우터 조인이 적용되어야 하는 모든컬럼에 (+)가 붙어야 된다
SELECT e.empno, e.ename,m.empno, m.ename 
FROM emp e, emp m 
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;


-ansi sql의 on절에 기술한 경우와 동일
SELECT e.empno, e.ename,m.empno, m.ename 
FROM emp e, emp m 
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

--emp테이블에는 14명의 직원이 있고 14명은 10, 20, 30 부서중에 한부서에 속한다
--하지만  dept테이블에는 10, 20, 30, 40 번 부서가 존재
--부서번호, 부서명, 해당부서에 속한 직원 수가 나오도록 쿼리를 작성


-- deptno : deptno, dname
--inline : deptno, cnt( 직원의수)
--oracle
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt
FROM 
    dept,
    (SELECT deptno, COUNT(*) cnt
    FROM emp 
    GROUP BY deptno) emp_cnt
WHERE dept.deptno = emp_cnt.deptno(+);

--ansi
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt --nvl(1, 2) 1번이 null이변 2번으로 출력
FROM 
    dept LEFT OUTER JOIN
                            (SELECT deptno, COUNT(*) cnt
                            FROM emp 
                            GROUP BY deptno) emp_cnt
ON  dept.deptno = emp_cnt.deptno(+);

--기본적인 생각의 방법
SELECT dept.DEPTNO, dept.DNAME, COUNT(emp.DEPTNO) cnt --그룹 함수에서 NULL값은 제외
FROM emp, dept
WHERE emp.deptno(+) = dept.deptno
GROUP BY dept.DEPTNO, dept.DNAME
ORDER BY deptno;


--RIGHT OUT
SELECT e.empno, e.ename,m.empno, m.ename 
FROM emp e LEFT OUTER JOIN emp m 
            ON(e.mgr = m.empno);


SELECT e.empno, e.ename,m.empno, m.ename 
FROM emp e RIGHT OUTER JOIN emp m 
            ON(e.mgr = m.empno);

--FULL OUTER : LEFT OUTER + RIGHT OUTER 에서 중복데이터 (-)한후 한건만 남기기
SELECT e.empno, e.ename,m.empno, m.ename 
FROM emp e FULL OUTER JOIN emp m 
            ON(e.mgr = m.empno);
            
            
--outerjoin1
SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM buyprod, prod
WHERE buyprod.buy_date(+) = TO_DATE('20050125', 'YYYY/MM/DD')
AND prod.prod_id = buyprod.buy_prod(+)
ORDER BY buy_date;

--otuerjoin ansi
SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM buyprod RIGHT OUTER JOIN prod
ON buyprod.buy_date = TO_DATE('20050125', 'YYYY/MM/DD')
AND prod.prod_id = buyprod.buy_prod
ORDER BY buy_date;