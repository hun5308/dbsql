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

--outter join2
SELECT NVL(buyprod.buy_date, '2005/01/25') buy_date/*TO_DATE(:yyyymmdd, 'YYYYMMDD')*/, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM buyprod, prod
WHERE buyprod.buy_date(+) = TO_DATE('20050125', 'YYYY/MM/DD')
AND prod.prod_id = buyprod.buy_prod(+)
ORDER BY buy_date;

-- outer join 3
SELECT TO_DATE(:yyyymmdd, 'YYYYMMDD') buy_date, buyprod.buy_prod, 
        prod.prod_id, prod.prod_name,  NVL(buyprod.buy_qty, 0)
FROM buyprod, prod
WHERE buyprod.buy_date(+) = TO_DATE('20050125', 'YYYY/MM/DD')
AND prod.prod_id = buyprod.buy_prod(+)
ORDER BY buy_date;

--outer join 4
SELECT PRODUCT.PID, product.PNM,
NVL(cycle.CID, 1)CID,
NVL(cycle.DAY, 0)DAY,
NVL(cycle.CNT, 0)CNT
FROM cycle,product
WHERE cycle.pid(+) = product.pid
AND cycle.CID(+) IN 1; --AND cycle.CID(+)= :cid;

--outer join 5
SELECT PRODUCT.PID, product.PNM,
NVL(cycle.CID, 1)CID,
CUSTOMER.CNM,
NVL(cycle.DAY, 0)DAY,
NVL(cycle.CNT, 0)CNT
FROM cycle,product, CUSTOMER
WHERE cycle.pid(+) = product.pid
AND cycle.CID(+)
IN 1
AND CUSTOMER.CNM IN'brown';



--outerjoin5 (교수님)
SELECT a.pid, a.pnm, NVL(a.cid,'1')cycle, NVL(cnm, 'brown') cnm, 
        NVL(day,0) day, NVL(cnt,0) cnt
FROM 
    (SELECT product.pid, product.pnm, --product
            :cid cid, NVL(cycle.day, 0) day, NVL(cycle.cnt, 0) cnt
    FROM cycle, product
    WHERE cycle.cid(+) = :cid
    AND cycle.pid(+) = product.pid) a, customer
WHERE a.cid = customer.cid;


--실습5(강현지 학생)
SELECT product.pid, pnm, NVL(cycle.cid,'1')cycle, NVL(cnm, 'brown') cnm, 
        NVL(day,0) day, NVL(cnt,0) cnt
FROM cycle, product, customer
WHERE product.pid = cycle.pid (+)
AND cycle.cid = customer.cid (+)
AND cycle.cid (+)= 1
ORDER BY pid DESC, DAY DESC;

--crossjoin실습 1
SELECT *
FROM   customer , product;

SELECT *
FROM customer cross JOIN product;

