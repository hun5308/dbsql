SELECT *
FROM EMP
WHERE empno = :empno;\
DROP INDEX 
ALTER TABLE emp ADD CONSTRAINT PK_emp_empno PRIMARY KEY (empno); 

SELECT *
FROM EMP
WHERE ename = :ename;
ALTER TABLE emp ADD CONSTRAINT PK_emp_empno PRIMARY KEY (ename); 
ALTER TABLE emp ADD CONSTRAINT nn_emp_ename CHECK (ename IS NOT NULL); 


SELECT *
FROM EMP, DEPT
WHERE EMP.deptno = DEPT.deptno
AND EMP.deptno = emp.DEPTNO
AND EMP.empno LIKE emp.empno || '%';
CREATE INDEX idx_emp_deptno_empno ON emp (deptno, empno);


SELECT *
FROM EMP
WHERE sal BETWEEN : st_sal AND :ed_sal
AND deptno = :deptno;
CREATE INDEX idx_emp_deptno ON emp (deptno);

SELECT B.*
FROM EMP A, EMP B
WHERE A.mgr = B.empno
AND A.deptno = :deptno;
CREATE INDEX idx_emp_mgr_deptno ON emp (mgr, empno);


SELECT deptno, TO_CHAR(hiredate, 'yyyymm'),
        COUNT(*) cnt
FROM EMP
GROUP BY deptno, to_CHAR(hiredate, 'yyyymm');