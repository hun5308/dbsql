--1. DESC ���̺��
--2 SELECT user_tab_colums;

--prod ���̺��� �÷���ȸ

DESC prod;

VARCHAR2, CHAR -> ���ڿ�(character)
NUMBER -> ����
CLOB -> charactar large OBject, ���ڿ� Ÿ���� ���� ������ ���ϴ� Ÿ��
  --�ִ� ������ : VARCHAR2(4000),  CLOB : 4GB
  
  DATA -> ��¥ (�Ͻ� = ��, ��, �� + �ð�, ��, ��)
  
  --date Ÿ�Կ� ���� �ǻ��� �����?
  '2019/11/20 09:16:20' + 1 = ?
  
  --USERS ���̺��� ��� �÷��� ��ȸ�� ������
SELECT *
FROM users;

--userid, usernm, reg_dt ������ �÷��� ��ȸ
SELECT userid, usernm, reg_dt
FROM users;

--������ ���� ���ο� �÷��� ������ (reg_dt�� ���ڿ����� �� ���ο� ���� �÷�)
-- ��¥ + ���� ���� ==> ���ڸ� ���� ��¥Ÿ���� ����� ���´�
-- ��Ī : ���� �ɷ����̳� ������ ���� ������ ���� �÷��� ������ �÷��̸��� �ο�
-- col �̳� express [AS] ��Ī��
SELECT userid, usernm, reg_dt , reg_dt+5 after5day
FROM users;

--���� ���, ���ڿ� ��� (orale: '' , java : '',"")
--table�� ���� ���� ������ �÷����� ����
--���ڿ� ���� ���� ( +, -, /, *)
--���ڿ� ���� ����(+�� �������� ����, ==> ||)
SELECT (10-2)*2, 'DE SQL ����',  
/*userid + 'modified',���ڿ� ������ ���ϱ� ������ ����*/
        usernm ||'_modified', reg_dt
FROM users;


--NULL : ���� �𸣴� ��
--NULL�� ���� ���� ����� �׻� NULL�̴�
--DESC ���̺�� : NOT NULL�� ���� �Ǿ��ִ� �÷����� ���� �ݵ�� ���� �Ѵ�


--user ���ʿ��� ������ ����
SELECT *
FROM users;


DELETE users
WHERE userid NOT IN ('brown', 'sally', 'cony', 'moon', 'james');

rollback;

commit;

SELECT userid, reg_dt
FROM users;
--null ������ �����غ��� ���� moon�� reg_dt �÷��� null�� ����
UPDATE users SET reg_dt = NULL
WHERE userid = 'moon';

ROLLBACK;
COMMIT;

--users ���̺��� reg_dt �÷����� 5���� ���� ���ο� �÷��� ����
SELECT userid, usernm, reg_dt, reg_dt+5
FROM users;

--�ǽ� select2
--prod ���̺��� prod_id, prod_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ� (�� prod_id -> id, prod_name -> name ���� �÷� ��Ī�� ����)
SELECT prod_id id, prod_name name
FROM prod;
--lprod ���̺��� lprod_gu, lprod_nm �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.(�� lprod_gu -> gu, lprod_nm -> nm���� �÷� ��Ī�� ����)
SELECT lprod_gu gu, lprod_nm nm
FROM lprod;
--buyer ���̺��� buyer_id, buyer_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.(�� buyer_id -> ���̾���̵�, buyer_name ->�̸� ���� �÷� ��Ī�� ����)
SELECT buyer_id ���̾���̵� , buyer_name �̸�
FROM buyer;



--���ڿ� �÷��� ����   (�÷� || �÷�, '���ڿ����' || �÷�), (CONCAT(�÷�, �÷�)
SELECT userid, usernm,
       userid || usernm AS id_nm,
       CONCAT(userid, usernm) con_id_nm,
       --||�� �̿��ؼ� userid, usernm, pass
       userid || usernm || pass id_nm_pass,
       --CONCAT�� �̿��ؼ� userid, usernm, pass
       CONCAT(CONCAT(userid, usernm), pass) con_id_nm_pass
FROM users;

--����ڰ� ������ ���̺� ��� ��ȸ
SELECT 'SELECT * FROM '|| table_name||';' query 
--CONCAT �Լ��� �̿��ؼ�
--1.'SELECT * FROM'
--2. table_name
--3. ';'
    --CONCAT('SELECT * FROM ',CONCAT(table_name,';')) query
FROM user_tables;



--WHERE : ������ ��ġ�ϴ� ���� ��ȸ�ϱ����� ���
--      �࿡ ���� ��ȸ ������ �ۼ�
SELECT userid, usernm, alias, reg_dt
FROM users
WHERE userid = 'brown';--userid �÷��� 'brown'�� ��(row)�� ��ȸ   

--emp���̺��� ��ü ������ ��ȸ (�����(row), ��(colum))
SELECT *
FROM emp

--�μ���ȣ(DEPTNO)�� 20���� ũ�ų� ���� �μ����� ���ϴ� ���� ���� ��ȸ
--WHERE deptno >= 20

--�����ȣ��(empno) 7700���� ũ�ų� ���� ����� ������ ��ȸ
WHERE empno >= 7700;


--��� �Ի����ڰ� 1982�� 1�� 1�� ������ ��� ���� ��ȸ
--���ڿ� --> ��¥ Ÿ������ ���� TO_DATE('��¥���ڿ�', '��¥���ڿ�����')
--�ѱ� ��¥ ǥ�� : --�� --�� --�� (2020-01-01)
--�̱� ��¥ ǥ�� : --�� --�� --�� (01-01-2020)
SELECT empno, ename, hiredate,
       2000 no, '���ڿ����' str, TO_DATE('19810101', 'yyyymmdd')
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'yyyymmdd');

--������ȸ (BETWEEN ���۱��� AND �������)
--���۱���, ��������� ����
--����߿��� �޿�(Sal)�� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ������� ��ȸ
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--BETWEEN AND �����ڴ� �ε�ȣ �����ڷ� ��ü ����
SELECT *
FROM emp
WHERE sal >= 1000 AND sal <= 2000;

--emp ���̺��� �Ի����ڰ� 1982�� 1��1�� ���ĺ��� 1983�� 1�� 1�� ������ ����� ename, hiredate �����͸� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
--(�� �����ڴ� between�� ����Ѵ�)
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101', 'yyyymmdd') AND TO_DATE('19830101', 'yyyymmdd');

--������ ������ �� �����ڸ� ����϶�
SELECT ename, TO_CHAR (hiredate, 'yyyy-mm-dd')
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'yyyymmdd') AND hiredate <= TO_DATE('19830101', 'yyyymmdd');