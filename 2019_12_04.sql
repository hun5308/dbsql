--1.tax ���̺��� �̿� �õ�/������ �δ� �������� �Ű�� ���ϱ�
--2. �Ű���� ���� ������ ��ŷ �ο��ϱ�
-- ��ŷ   �õ�    �ñ���    �δ翬������Ű��
-- 1    ����Ư���� ���ʱ�   7000    
/*SELECT ROWNUM ����, sido, sigungu, �δ翬������Ű��
FROM(SELECT sido, sal, people, sigungu,ROUND(sal/people, 1) �δ翬������Ű��
    FROM tax
    ORDER BY �δ翬������Ű�� DESC);*/
    
/*(UPDATE tax SET PEOPLE = 70391
WHERE SIDO = '����������'
AND SIGUNGU = '����';
COMMIT)*/

SELECT *
FROM(SELECT ROWNUM ����, a.sido, a.sigungu,/*a.cnt,b.cnt*/ROUND(a.cnt/b.cnt,1) as ���ù�������  
              FROM
                  (SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
                    FROM fastfood
                    WHERE gb IN('�Ƶ�����','����ŷ','KFC')
                    GROUP BY sido, sigungu) a,
                  (SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
                    FROM fastfood
                    WHERE gb IN('�Ե�����')
                    GROUP BY sido, sigungu) b
                    WHERE a.sido = b.sido  
                    AND a.sigungu = b.sigungu
                    ORDER BY ���ù������� DESC) buger, 
                    
                   (SELECT ROWNUM ����, sido, sigungu, �δ翬������Ű��
                    FROM
                   (SELECT sido, sal, people, sigungu,ROUND(sal/people, 1) �δ翬������Ű��
                    FROM tax
                    ORDER BY �δ翬������Ű�� DESC)) tax_sal
WHERE buger.����(+) = tax_sal.����
ORDER BY tax_sal.����;

--���ù������� �õ�, �ñ����� �������� ���Աݾ��� �õ�, �ñ�����
--���� �������� ����
--���ļ����� tax���̺��� id�÷������� ����
--1.����Ư����       ������  5.6  ����Ư����   ������   70.3

SELECT *
FROM(SELECT ROWNUM ����, a.sido, a.sigungu,/*a.cnt,b.cnt*/ROUND(a.cnt/b.cnt,1) as ���ù�������  
              FROM
                  (SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
                    FROM fastfood
                    WHERE gb IN('�Ƶ�����','����ŷ','KFC')
                    GROUP BY sido, sigungu) a,
                    
                  (SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
                    FROM fastfood
                    WHERE gb IN('�Ե�����')
                    GROUP BY sido, sigungu) b
                    
                    WHERE a.sido = b.sido  
                    AND a.sigungu = b.sigungu
                    ORDER BY ���ù������� DESC) buger, 
                    
                   (SELECT ROWNUM ����, id, sido, sigungu, �δ翬������Ű��
                    FROM
                   (SELECT id, sido, sal, people, sigungu,ROUND(sal/people, 1) �δ翬������Ű��
                    FROM tax
                    ORDER BY �δ翬������Ű�� DESC)) tax_sal
                    
WHERE buger.sido(+) = tax_sal.sido
AND buger.sigungu(+) = tax_sal.sigungu
ORDER BY tax_sal.id;



--SMITH�� ���� �μ� ã��   --> 20
SELECT deptno
FROM emp
WHERE ename = 'WARD';

SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
                
SELECT empno, ename, deptno, 
    (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname
FROM emp;            

--SCALAR SUBQUERY
--SELECT ���� ǥ���� ��������
--�� ��, �� COLUMN�� ��ȸ�ؾ��Ѵ�
SELECT empno, ename, deptno,
        (SELECT dname FROM dept) dname
FROM emp;

--INLINE VIEW
--FROM���� ���Ǵ� ��������

--SUBQUERY
--WHERE���� ���Ǵ� ��������

--�ǽ� sub1
--��� �޿����� ���� �޿��� �޴� ������ ���� ��ȸ�ϼ���
SELECT COUNT(*) cnt
FROM emp
WHERE sal > (SELECT round(AVG(sal), 0)
            FROM   emp);
        
--�ǽ� sub2
--��� �޿����� ���� �޿��� �޴� ������ ������ ��ȸ�ϼ���
SELECT *
FROM emp
WHERE sal > (SELECT round(AVG(sal), 0)
            FROM   emp);
            
--�ǽ� sub3

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename IN('SMITH', 'WARD'));
                
--���̽� Ȥ�� ���庸�� �޿��� ���� �޴� ���� ��ȸ
SELECT *
FROM   emp  
WHERE  sal < ALL (SELECT sal --800, 1250 ���� �������
                     FROM emp
                    WHERE ename IN('SMITH', 'WARD'));

--������ ��Ȱ�� ���� �ʴ� ������� ��ȸ
--NOT IN ������ ���� NUIL�� �����Ϳ� �������� �ʾƾ� ������ �Ѵ�
SELECT *
FROM emp --������� ��ȸ --> �����ڿ�Ȱ�� ���� �ʴ�
WHERE empno NOT IN
                (SELECT NVL(mgr, -1) --NULL ���� �������� �������� �����ͷ� ġȯ
                FROM emp);

SELECT *
FROM emp --������� ��ȸ --> �����ڿ�Ȱ�� ���� �ʴ�
WHERE empno NOT IN
                (SELECT mgr --NULL ���� �������� �������� �����ͷ� ġȯ
                FROM emp
                WHERE mgr IS NOT null);
                
--pair wise (���� �÷��� ���� ���ÿ� ���� �ؾ��ϴ� ���)
--ALLEN, CLARK�� �Ŵ����� �μ���ȣ�� ���ÿ� ���� ��� ���� ��ȸ
--(7689, 30)
--(7689, 10)
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));
--�Ŵ����� 7698�̰ų� 7839 �̸鼭
--�ҼӺμ��� 10�� �̰ų� 30���� ���� ���� ��ȸ
--7698, 10
--7698, 30
--7839, 10
--7839, 30  
SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
                        FROM emp
                        WHERE empno IN (7499, 7782))                     
AND deptno IN (SELECT deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));        
--���ȣ ���� ���� ����
--���� ������ Į���� ������������ ������� �ʴ� ������ ��������

--���ȣ ���� ���������� ��� ������������ ����ϴ� ���̺�, �������� ��ȸ ������
--���������� ������������ �Ǵ��Ͽ� ������ �����Ѵ�.
--���������� emp ���̺��� ���� �������� �ְ� , ���������� emp���̺��� ���� ���� ���� �ִ�

--���ȣ ���� ������������ ���������� ���̺��� ���� ���� ����
--���������� ������ ��Ȱ�� �ߴ� ��� �� �������� ǥ��

--���ȣ ���� ������������ ���������� ���̺��� ���߿� ���� ����
--���������� Ȯ���� ��Ȱ�� �ߴ� ��� �� �������� ǥ��

 --������ �޿� ��պ��� ���� �޿��� �޴� ������ ���� ��ȸ
 --������ �޿� ���
 SELECT *
 FROM emp
 WHERE sal > (SELECT AVG(sal)
                FROM emp);
                
--��ȣ���� ��������
--�ش������� ���� �μ��� �޿���պ��� ���� �޿��� �޴� ���� ��ȸ

SELECT *
FROM emp m
WHERE sal > (SELECT AVG(sal)
            FROM emp
            WHERE deptno = m.deptno);


/*
10 2916.67 --KING
20 2175 -- JONES, SCOTT, FORD
30 1566.67 --ALLEN, BLAKE
*/
SELECT empno, ename, deptno, sal
FROM emp;

--10�� �μ��� �޿� ���
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;

