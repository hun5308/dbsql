--join03
--사원번호, 사원이름, 급여, 부서번호, 부서이름
SELECT c.*
FROM(SELECT a.empno, a.ename, a.sal, b.deptno, b.dname
FROM emp a, dept b
WHERE a.deptno = b.deptno) c 
WHERE c.sal > 2500 AND c.empno >7600
ORDER BY c.deptno;



--join04

SELECT c.*
FROM(SELECT a.empno, a.ename, a.sal, b.deptno, b.dname
FROM emp a JOIN dept b
ON a.deptno = b.deptno) c 
WHERE c.sal > 2500 AND c.empno >7600 AND dname = 'RESEARCH'
ORDER BY c.deptno;


--join1
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu
ORDER BY lprod_gu;

--join2
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id
ORDER BY prod_id;

--join3
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member AND cart.cart_prod = prod.prod_id;


--join4 
SELECT *
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid
AND CNM IN ('brown', 'sally');

--join5
SELECT a.cid, a.CNM, b.pid, c.pnm, b.day, b.cnt
FROM customer a, cycle b, product c
WHERE a.cid = b.cid 
AND b.pid = c.pid AND CNM IN ('brown', 'sally');

--join6
SELECT a.cid, a.CNM, b.pid, c.pnm,
sum(b.cnt) cnt
FROM customer a, cycle b, product c
WHERE a.cid = b.cid 
AND b.pid = c.pid
GROUP BY  a.cid, a.CNM, b.pid, c.pnm, b.cnt;

--join7
SELECT a.pid, pnm,
SUM(cnt)
FROM cycle a, product b
WHERE a.pid = b.pid
GROUP BY a.pid, pnm;


