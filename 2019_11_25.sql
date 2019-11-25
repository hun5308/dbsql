--rownum_1
SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

--rownum_2
SELECT ROWNUM, A.*  --*�̰� �ð�� �޸��� �ü� ����.
FROM
(SELECT ROWNUM rn, empno, ename
FROM emp) A
WHERE rn BETWEEN 11 AND 14;

--rownum_3
SELECT rn, empno, ename
FROM
    (SELECT ROWNUM rn, a.*
    FROM
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a)
WHERE rn BETWEEN 11 AND 14;


--DUAL ���̺� : sys ������ �ִ� ������ ��� ������ ���̺��̸�
--�����ʹ� ���ุ �����ϸ� �÷�(dummy)�� �ϳ� ����

SELECT *
FROM dual;

--SINGLE ROW FUNCTION : ��� �ѹ��� FUNCTION�� ����
--1���� �� INPUT -> 1���� ������ OUTPUT (COLRUM)
--'Hello World'
SELECT   LOWER('Hello World'), UPPER('Hello World') upper,
         INITCAP ('Hello World')
FROM dual;

--emp ���̺���� �� 14���� ������(����)�� ���� (14���� ��)
--�Ʒ������� ����� 14���� ��

SELECT  emp.*, LOWER('Hello World') low, UPPER('Hello World') upper,
         INITCAP ('Hello World')
FROM emp;


--�÷��� fumction ����
SELECT empno, LOWER(ename) low_ename
FROM emp
WHERE ename = UPPER ('smith');  --�����̸��� smith�� ����� ��ȸ�Ϸ��� �빮�� (�̾ƿö��� �ҹ���, �⺻ ������ ������ �빮��)

--���̺� �÷��� �����ص� ������ ����� ���� �� ������
--���̺� �÷����ٴ� ����U�� �����ϴ� ���� �ӵ��鿡�� ����
--�ش� �÷��� �ε����� �����ϴ��� �Լ��� �����ϰ� �Ǹ� ���� �޶����� �Ǿ� 
--�ε����� Ȱ�� �� �� ���� �ȴ�
--���� : FBI(Function Based Index)
SELECT empno, LOWER(ename) low_ename
FROM emp
WHERE LOWER(ename) = 'smith';

--HELLO
--,
--WORLD
--HELLO, WORLD (�� 3���� ���ڿ� ����� �̿�, CONCAT�Լ��� ����Ͽ� ���ڿ� ����)
SELECT CONCAT(CONCAT('HELLO', ', '), 'WORLD') cl,
       'HELLO' || ', ' || 'WORLD' c2,
       --�����ε����� 1����, �����ε����� ���ڿ����� �����Ѵ�
       SUBSTR ('HELLO, WORLD', 1, 5) s1, --SUBSTR (���ڿ�, �����ε���, �����ε���)
       
       --INSTR :���ڿ��� Ư�� ���ڿ��� �����ϴ��� ������ ��� ������ �ε����� ����
        INSTR('HELLO, WORLD', 'O') i1,  --5
        --'HELLO, WORLD' ���ڿ��� 6��° �ε��� ���Ŀ� �����ϴ� 'o'���ڿ��� �ε��� ����
       INSTR('HELLO, WORLD', 'O', 6) i2, --���ڿ��� Ư�� �ε��� ���ĺ��� �˻� �ϵ��� �ɼ�

        INSTR('HELLO, WORLD', 'O', INSTR('HELLO, WORLD', 'O') + 1) i3,

    --L/RPAD Ư�� ���ڿ��� ���� / �����ʿ� ������ ���ڿ� ���̺��� ������ ��ŭ ���ڿ���
    --ä�� �ִ´�
    
    LPAD('HELLO, WORLD', 15, '*') L1,
    LPAD('HELLO, WORLD', 15) L2, --DEFAULT ä�� ���ڴ� �����̴�
    RPAD('HELLO, WORLD', 15, '*') R2,
   
   
   --REPALCE (����ڿ�, �˻����ڿ�, �����ҹ��ڿ�)
   --����ڿ����� �˻� ���ڿ��� ������ ���ڿ��� ġȯ
   
   REPLACE('HELLO, WORLD', 'HELLO', 'hello') rep1, --hello, WORLD
   
   --���ڿ� ��, ���� ������ ����
   '   HELLO, WORLD   ' before_trim,
   TRIM('   HELLO, WORLD   ') after_trim,
   TRIM('H' FROM 'HELLO, WORLD') after_trim2
FROM dual;


--���� �����Լ�
--ROUND : �ݿø� - ROUND(����, �ݿø� �ڸ�)
--TRUNC : ����   - TRUNC ( ����, ���� �ڸ�)
--MOD : ������ ���� (�ڹٿ����� %) //  MOD(5, 2) : 1

SELECT --�ݿø� ����� �Ҽ��� ���ڸ����� ��������(�Ҽ��� ��°�ڸ����� �ݿø�)
    ROUND(105.54, 1) r1,
    ROUND(105.55, 1) r2,
    ROUND(105.55, 0) r3, --�Ҽ��� ù���� �ڸ����� �ݿø�
    ROUND(105.54, -1) r4 --���� ù���� �ڸ����� �ݿø�
FROM dual;


SELECT --���� ����� �Ҽ��� ���ڸ����� ��������(�Ҽ��� ��°�ڸ����� ����)
    TRUNC(105.54, 1) r1,
    TRUNC(105.55, 1) r2,
    TRUNC(105.55, 0) r3, --�Ҽ��� ù���� �ڸ����� ����
    TRUNC(105.55, -1) r4 --���� ù���� �ڸ����� ����
FROM dual;

--MOD(������, ����) �������� ������ ���� ������ ��
-- MOD (M,2) �� ��� ���� : 0, 1( 0 ~ ���� -1)        
SELECT MOD(5, 2) M1 -- 5/2 == ��2 �������� 1
FROM dual;

--emp���̺��� sal�÷��� 1000���� �������� ����� ������ ���� ��ȸ�ϴ� sql�ۼ�
SELECT ename, sal,TRUNC(sal /1000, 0) �� ,MOD(sal, 1000) ������
FROM emp;

--DATE : �� �� ��, �ð�, ��, ��
--���� ȯ�漳�� -> ����Ÿ���̽� -> NLS ���� ����� ���� ��� ���� ����
SELECT ename, hiredate, TO_CHAR(hiredate, 'YYYY_MM_DD hh24-mi-ss') --YYYY/MM/DD
FROM emp;

--STSDATE : ������ ���� DATE�� �����ϴ� �����Լ�, Ư���� ���ڰ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24:mi:ss')
FROM dual;

--DATE ���� : DATE + ����N = N���� ��ŭ ���Ѵ�
--DATE ���꿡 �־ ������ ����
--�Ϸ�� 24�ð�
--DATE Ÿ�ӿ� �ð��� ���� �� �� �մ� 1�ð� = 1/24
SELECT TO_CHAR(SYSDATE + 5, 'YYYY-MM-DD hh24:mi:ss') AFTER5_DAY,
       TO_CHAR(SYSDATE + 5/24, 'YYYY-MM-DD hh24:mi:ss') AFTER5_HOURS,
       TO_CHAR(SYSDATE + 5/24/60, 'YYYY-MM-DD hh24:mi:ss') AFTER5_MIN
FROM dual;

--date �ǽ�
SELECT TO_DATE ('2019-12-31', 'YYYY-MM-DD')  LASTDAY ,
       TO_DATE ('2019-12-31', 'YYYY-MM-DD')-5 LASTDATE_BEFORE5,
       SYSDATE NOW,
       SYSDATE -3
FROm dual;

--YYYY, MM, DD, D(������ ���ڷ� : �Ͽ��� 1, ������2, ȭ���� 3 .... ����� : 7)
--IW(���� 1 ~ 53), HH, MI, SS
SELECT TO_CHAR(SYSDATE, 'YYYY') YYYY,--���� �⵵
       TO_CHAR(SYSDATE, 'MM') MM,--�����
       TO_CHAR(SYSDATE, 'DD') DD, --������
       TO_CHAR(SYSDATE, 'D') D, --���� ����(�ְ����� 1 ~ 7)
       TO_CHAR(SYSDATE, 'IW') IW, --���� ������ ����
--2019�� 12�� 31���� �������� �����°�
       TO_CHAR(TO_DATE('2019-12-13', 'YYYY-MM-DD'), 'IW') IW_20191213
FROM dual;

--date �ǽ� fn2

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')DT_DASH, 
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')DT_DASH_WIDTH_TIME,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY')DT_MM_YYYY_YYYY
FROM dual;

--DATE Ÿ���� ROUND, TRUNC ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24:mi:ss') now
       ,TO_CHAR(TRUNC(SYSDATE, 'YYYY'), 'YYYY-MM-DD hh24:mi:ss') now_YYYY
       
       --DD���� �ݿø� ( 25�� -> 1����)
       ,TO_CHAR(TRUNC(SYSDATE, 'MM'), 'YYYY-MM-DD hh24:mi:ss') now_MM
       
       --�ð����� �ݿø�
       ,TO_CHAR(TRUNC(SYSDATE, 'DD'), 'YYYY-MM-DD hh24:mi:ss') now_DD
FROM dual;

--��¥ ���� �Լ�
--MONTHS_BETWEEN(date1, date2) : date2�� date1 ������ �����
--ADD_MONTH(date, ������ �¿���) : date���� Ư�� �������� ���ϰų� �� ��¥
--NEXT_DAT(date, weekday(1~7)) : date���� ù���� weekdat ��¥
--LAST DAT(date) : date�� ���� ���� ������ ��¥

--MONTHS_BETWEEN(date1, date2)
SELECT MONTHS_BETWEEN(TO_DATE('2019-11-25', 'YYYY-MM-DD'),
                    TO_DATE('2019-03-31', 'YYYY-MM-DD')) m_bet,
    TO_DATE('2019-11-25', 'YYYY-MM-DD') -
    TO_DATE('2019-03-31', 'YYYY-MM-DD')) d_m --�� ��¥ ������ ���ڼ�
FROM dual;

--ADD_MONTHS(date, number(+,-) )
SELECT ADD_MONTHS(TO_DATE('20191125', 'YYYYMMDD'), 5) NOW_AFTER5M,
       ADD_MONTHS(TO_DATE('20191125', 'YYYYMMDD'), -5) NOW_BEFORE5M
      ,SYSDATE + 100 --100�� ���� ��¥ (�� ���� 3-31, 2-28/29)
FROM dual;


--NEXT_DAT(date, weekday number(1~7))
SELECT NEXT_DAY(SYSDATE, 7)--���ó�¥(2019/11/25)�� ���� �����ϴ� ù��° �����
FROM dual;
