--join ���� 
--outer join : ���� ���ῡ ���� �ϴ���� ������ �Ǵ� ���̺��� �����ʹ�
--�������� �ϴ� join
--LEFT OUTER JOIN : ���̺�1 LEFT OUTER JOIN ���̺�2
--���̺�1�� ���̺�2�� �����Ҷ� ���ο� �����ϴ��� ���̺�1�ʿ� �����ʹ�
--��ȸ�� �ǵ��� �Ѵ�
--���ο� ������ �࿡�� ���̺�2�� �÷����� �������� �����Ƿ�   NULL�� ǥ�õȴ�.


--ORACLE outer join syntax
--�Ϲ����ΰ� �������� �÷��� (+)ǥ��
-- + ǥ�� : �����Ͱ� �������� �ʴµ� ���;� �Ѵ� ���̺��� �÷�
-- ����  LFET OTER JOIN �Ŵ���
-- ON(����.�Ŵ�����ȣ = �Ŵ���.������ȣ)
--ORACLE OUTER
--WHERE ����.�Ŵ�����ȣ = �Ŵ���.������ȣ(+) --�Ŵ����� �����Ͱ� �������� ����

--ansi
SELECT e.empno, e.ename,m.empno, m.ename 
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);

--oracle
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);


--�Ŵ��� �μ���ȣ ����
--anso sql WHERE ���� ���
-- -->OUTER ������ ������� �ʴ� ��Ȳ
--**�ƿ��� ������ ����Ǿ�� �ϴ� ����÷��� (+)�� �پ�� �ȴ�
SELECT e.empno, e.ename,m.empno, m.ename 
FROM emp e, emp m 
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;


-ansi sql�� on���� ����� ���� ����
SELECT e.empno, e.ename,m.empno, m.ename 
FROM emp e, emp m 
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;

--emp���̺��� 14���� ������ �ְ� 14���� 10, 20, 30 �μ��߿� �Ѻμ��� ���Ѵ�
--������  dept���̺��� 10, 20, 30, 40 �� �μ��� ����
--�μ���ȣ, �μ���, �ش�μ��� ���� ���� ���� �������� ������ �ۼ�


-- deptno : deptno, dname
--inline : deptno, cnt( �����Ǽ�)
--oracle
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt
FROM 
    dept,
    (SELECT deptno, COUNT(*) cnt
    FROM emp 
    GROUP BY deptno) emp_cnt
WHERE dept.deptno = emp_cnt.deptno(+);

--ansi
SELECT dept.deptno, dept.dname, NVL(emp_cnt.cnt, 0) cnt --nvl(1, 2) 1���� null�̺� 2������ ���
FROM 
    dept LEFT OUTER JOIN
                            (SELECT deptno, COUNT(*) cnt
                            FROM emp 
                            GROUP BY deptno) emp_cnt
ON  dept.deptno = emp_cnt.deptno(+);

--�⺻���� ������ ���
SELECT dept.DEPTNO, dept.DNAME, COUNT(emp.DEPTNO) cnt --�׷� �Լ����� NULL���� ����
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

--FULL OUTER : LEFT OUTER + RIGHT OUTER ���� �ߺ������� (-)���� �ѰǸ� �����
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