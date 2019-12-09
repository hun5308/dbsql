--dept���̺� synonym�� �����Ͽ�


--DDL : TABLE ����
--CREATE TABLE [����ڸ�.]���̺��(
--    �÷���1 �÷�Ÿ��1, 
--    �÷���1 �÷�Ÿ��2,...
--    �ķ��� N �÷�Ÿ��N);


--ranger _ no NUMBER        :������ ��ȣ
--ranger_nm VARCHAR2(50)    :������ �̸�
--reg_dt DATE               :������ �������
--���̺� ���� DDL: Date Defination Language(������ ���Ǿ�)
--DDL rollback�� ����(�ڵ�Ŀ�� �ǹǷ� rollback�� �� �� ����)
CREATE TABLE ranger (
 ranger_no NUMBER,
 ranger_nm VARCHAR2(50),
 reg_dt DATE
);
DESC ranger;

--DDL ������ ROLLBACK ó�� �Ұ�!!
ROLLBACK;

SELECT *
FROM user_tables
WHERE table_name = 'RANGER';
--WHERE table_name = 'ranger;
--����Ŭ������ ��ü ������ �ҹ��ڷ� �����ϴ��� ���������δ� �빮�ڷ� �����Ѵ�

INSERT INTO ranger VALUES(1, 'brwon', sysdate);
--�����Ͱ� ��ȸ�Ǵ°��� Ȯ�� ����
SELECT *
FROM ranger;

--DML���� DDL�� �ٸ��� ROLLBACK�� �����ϴ�
ROLLBACK;

--ROLLBACK�� �߱� ������ DML������ ��ҵȴ�
SELECT *
FROM ranger;

--DATE Ÿ�Կ��� �ʵ� �����ϱ�
--EXTRACT(�ʵ�� FROM �÷� /expression)
SELECT TO_CHAR(SYSDATE, 'YYYY') yyyy,
       TO_CHAR(SYSDATE, 'mm') mm,
       EXTRACT(year FROM SYSDATE) ex_yyyy,
       EXTRACT(month FROM SYSDATE) ex_mm
FROM dual;


--���̺� ������ �÷� ���� �������� ����
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13));

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13));

--dept_test ���̺��� deptno �÷��� PRIMARY KEY ���������� �ֱ� ������ 
--deptno�� ������ �����͸� �Է��ϰų� ���� �� �� ����
--���� �������̹Ƿ� �Է¼���
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');

--dept_test �����Ϳ� deptno�� 99���� �����Ͱ� �����Ƿ�
--primary key �������ǿ� ���� �Է� �� �� ����
--ORA-0001 unique constraint ���� ����
--SYS_C007147 ���� ������ � ���� �������� �Ǵ��ϱ� ����Ƿ�
--�������ǿ� �̸��� �ڵ� �꿡 ���� �ٿ��ִ� ���� ���������� ���ϴ�
INSERT INTO dept_test VALUES(99, '���', '����');



--���̺� ������ �������� �̸��� �߰��Ͽ� �����
--primary key : pk_���̺��
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13));
    
--INSERT ���� ����
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, '���, '����');

--PRIMARY KET ���� : UNIQUE  + NOT NULL

--UNIQE : �ش� Į���� ������ ���� �ߺ��� �� ����
--        (ex : emp���̺���empno(���)
--           dept���̺��� deptno(�μ���ȣ))
--            �ش� �÷��� NULL���� ��� �� �� �ִ�
        
--NOT NULL : ������ �Է½� �ش� �÷��� ���� �ݵ�� ���;� �Ѵ�

-- �÷� ������ PRIMARY KEY ���� ����
--����Ŭ�� �������� �̸��� ���Ƿ� ���� (SYS-C00701)
CREATE TABLE dept_test(
    detpno NUMBER(2) PRIMARY KEY,;

--����Ŭ ���������� �̸��� ���Ƿ� ���
--PRIMARY KEY : pk_���̺��
CREATE TABLE dept_test(
    detpno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,;
    
--PAIRWISE : ���� ����
--����� PRIMARY KEY ���� ������ ��� �ϳ��� �÷��� ���������� ����
--���� �ķ��� �������� PRIMARY KEY �������� ���� �� �� �յ�
--�ش� ����� ���� �ΰ��� ����ó�� �÷� ���������� ���� �� �� ����
-->TABLE LEVEL ���� ���� ����

--������ ������ dept_test ���̺� ���� (drop)
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13)), --������ �÷� ������ �ĸ� ������ �ʱ�

--deptno, dname �÷��� ������ ������(�ߺ���)�����ͷ� �ν�
    CONSTRAINT pk_dept_test PRIMARY KEY(deptno, dname)
    );
    
--�μ���ȣ, �μ��̸� ���������� �ߺ� �����͸� ����
--�Ʒ� �ΰ��� insert ������ �μ���ȣ�� ������
--�μ����� �ٸ��Ƿ� ���� �ٸ� �����ͷ� �λ� --> INSERT����
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, '���, '����');

SELECT *
FROM dept_test;

