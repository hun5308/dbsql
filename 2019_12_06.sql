--dept ���̺� �μ���ȣ 99, �μ��� ddit, ��ġ daejeon
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
COMMIT;

--UPDATE : ���̺� ����� �÷��� ���� ����
--UPDATE ���̺�� SET �÷���  1 = �����Ϸ��� �ϴ� ��1, �÷���2=�����Ϸ��� �ϴ°�......
--[WHERE row ��ȸ����] -- ��ȸ���ǿ� �ش��ϴ� �����͸� ������Ʈ�� �ȴ�

--�μ���ȣ�� 99�� �μ��� �μ����� ���IT��, ������ ���� �������� ����
UPDATE dept SET dname = '���IT', loc = '���κ���'
WHERE deptno = 99;

--������Ʈ���� ������Ʈ �Ϸ����ϴ� ���̺��� WHERE���� ����� �������� SELECT�� �Ͽ� ������Ʈ ��� ROW�� Ȯ���� ����

SELECT *
FROM dept
WHERE deptno = 99; 

--���� ������ �����ϸ� WHERE���� ROW���� ������ ���� ������
--dept ���̺��� ����࿡ ���� �μ���, ��ġ ������ �����Ѵ�
UPDATE dept SET dname = '���IT', loc = '���κ���';

--���� ������ �׽�Ʈ ������ ���� --> ���α׷�

--���������� �̿���UPDATE
--emp���̺� �űԵ����� �Է�
---�����ȣ 9999, ����̸� brown, ���� : null
INSERT INTO emp(empno, ename) VALUES (9999, 'brown');
COMMIT;

--�����ȣ�� 9999�� ����� �ҼӺμ���, ��� ������ SMITH ����� �μ�, ������ ������Ʈ
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
                job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;
COMMIT;
SELECT *
FROM emp
WHERE empno = 9999;

--DELETE : ���ǿ� �ش��ϴ� ROW�� ����
--�÷��� ���� ����??(null)������ �����Ϸ��� --> UPDATE

--DELETE ���̺��
--[WHERE ����]

--UPDATE������ ���������� DELETE ���� ���������� �ش� ���̺��� WHERE������ �����ϰ� �Ͽ�
--SELECT�� ����, ������ ROW�� ���� Ȯ���غ���

--emp���̺� �����ϴ� �����ȣ 9999�� ����� ����
DELETE emp
WHERE empno = 9999;

SELECT *
FROM emp
WHERE empno = 9999;

COMMIT;

--�Ŵ����� 7698�� ��� ����� ����
-- ���������� ���

DELETE emp
WHERE empno IN (SELECT empno
                FROM emp
                WHERE mgr = 7698);
ROLLBACK;
--�� ������ �Ʒ� ������ ����
DELETE emp WHERE mgr = 7698;

