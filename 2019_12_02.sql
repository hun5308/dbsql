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
SELECT NVL(buyprod.buy_date, '2005/01/25') buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM buyprod, prod
WHERE buyprod.buy_date(+) = TO_DATE('20050125', 'YYYY/MM/DD')
AND prod.prod_id = buyprod.buy_prod(+)
ORDER BY buy_date;

-- outer join 3
SELECT NVL(buyprod.buy_date, '2005/01/25') buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name,  NVL(buyprod.buy_qty, 0)
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
AND cycle.CID(+) IN 1;

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