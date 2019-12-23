-------------------------------------window functionÈ°¿ë n0_ana3
SELECT a.empno, a.ename, a.sal, SUM(b.sal) 
FROM
    (SELECT aa.*, ROWNUM rn
    FROM
    (SELECT empno, ename, sal
    FROM emp
    ORDER BY sal)aa) a, 
    (SELECT bb.*, ROWNUM rn
    FROM
    (SELECT empno, ename, sal
    FROM emp
    ORDER BY sal)bb) b
WHERE a.rn >= b.rn
GROUP BY a.empno, a.ename, a.sal
ORDER BY sal;
