SELECT *
FROM emp
WHERE empno = :empno;


SELECT *
FROM dept;
WHERE deptno = :deptno;
 

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno = :deptno
AND emp.deptno LIKE : deptno ||'%';


SELECT *
FROM emp
WHERE sal BETWEEN : st_sal AND : ed_sal
AND deptno = :deptno;


SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno = :deptno
AND dept.loc = :loc;

CREATE UNIQUE INDEX idx_emp_empno ON emp(empno);
CREATE INDEX idx_emp_deptno ON dept(deptno);