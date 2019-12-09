--deptÅ×ÀÌºí¿¡ synonymÀ» »ý¼ºÇÏ¿©


--DDL : TABLE »ý¼º
--CREATE TABLE [»ç¿ëÀÚ¸í.]Å×ÀÌºí¸í(
--    ÄÃ·³¸í1 ÄÃ·³Å¸ÀÔ1, 
--    ÄÃ·³¸í1 ÄÃ·³Å¸ÀÔ2,...
--    ÄÄ·³¸í N ÄÃ·³Å¸ÀÔN);


--ranger _ no NUMBER        :·¹ÀÎÀú ¹øÈ£
--ranger_nm VARCHAR2(50)    :·¹ÀÎÀú ÀÌ¸§
--reg_dt DATE               :·¹ÀÎÀú µî·ÏÀÏÀÚ
--Å×ÀÌºí »ý¼º DDL: Date Defination Language(µ¥ÀÌÅÍ Á¤ÀÇ¾î)
--DDL rollbackÀÌ ¾ø´Ù(ÀÚµ¿Ä¿¹Ô µÇ¹Ç·Î rollbackÀ» ÇÒ ¼ö ¾ø´Ù)
CREATE TABLE ranger (
 ranger_no NUMBER,
 ranger_nm VARCHAR2(50),
 reg_dt DATE
);
DESC ranger;

--DDL ¹®ÀåÀº ROLLBACK Ã³¸® ºÒ°¡!!
ROLLBACK;

SELECT *
FROM user_tables
WHERE table_name = 'RANGER';
--WHERE table_name = 'ranger;
--¿À¶óÅ¬¿¡¼­´Â °´Ã¼ »ý¼º½Ã ¼Ò¹®ÀÚ·Î »ý¼ºÇÏ´õ¶óµµ ³»ºÎÀûÀ¸·Î´Â ´ë¹®ÀÚ·Î °ü¸®ÇÑ´Ù

INSERT INTO ranger VALUES(1, 'brwon', sysdate);
--µ¥ÀÌÅÍ°¡ Á¶È¸µÇ´Â°ÍÀ» È®ÀÎ ÇßÀ½
SELECT *
FROM ranger;

--DML¹®Àº DDL°ú ´Ù¸£°Ô ROLLBACKÀÌ °¡´ÉÇÏ´Ù
ROLLBACK;

--ROLLBACKÀ» Çß±â ¶§¹®¿¡ DML¹®ÀåÀÌ Ãë¼ÒµÈ´Ù
SELECT *
FROM ranger;

--DATE Å¸ÀÔ¿¡¼­ ÇÊµå ÃßÃâÇÏ±â
--EXTRACT(ÇÊµå¸í FROM ÄÃ·³ /expression)
SELECT TO_CHAR(SYSDATE, 'YYYY') yyyy,
       TO_CHAR(SYSDATE, 'mm') mm,
       EXTRACT(year FROM SYSDATE) ex_yyyy,
       EXTRACT(month FROM SYSDATE) ex_mm
FROM dual;


--Å×ÀÌºí »ý¼º½Ã ÄÃ·³ ·¹º§ Á¦¾àÁ¶°Ç »ý¼º
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13));

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13));

--dept_test Å×ÀÌºíÀÇ deptno ÄÃ·³¿¡ PRIMARY KEY Á¦¾àÁ¶°ÇÀÌ ÀÖ±â ¶§¹®¿¡ 
--deptno°¡ µ¿ÀÏÇÑ µ¥ÀÌÅÍ¸¦ ÀÔ·ÂÇÏ°Å³ª ¼öÁ¤ ÇÒ ¼ö ¾ø´Ù
--ÃÖÃÊ µ¥ÀÌÅÍÀÌ¹Ç·Î ÀÔ·Â¼º°ø
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');

--dept_test µ¥ÀÌÅÍ¿¡ deptno°¡ 99¹øÀÎ µ¥ÀÌÅÍ°¡ ÀÖÀ¸¹Ç·Î
--primary key Á¦¾àÁ¶°Ç¿¡ ÀÇÇØ ÀÔ·Â µÉ ¼ö ¾ø´Ù
--ORA-0001 unique constraint Á¦¾à À§¹è
--SYS_C007147 Á¦¾à Á¶°ÇÀ» ¾î¶² Á¦¾à Á¶°ÇÀÎÁö ÆÇ´ÜÇÏ±â Èûµå¹Ç·Î
--Á¦¾àÁ¶°Ç¿¡ ÀÌ¸§À» ÄÚµù ·ê¿¡ ÀÇÇØ ºÙ¿©ÁÖ´Â ÆíÀÌ À¯Áöº¸¼ö½Ã ÆíÇÏ´Ù
INSERT INTO dept_test VALUES(99, '´ë´ö', '´ëÀü');



--Å×ÀÌºí »èÁ¦ÈÄ Á¦¾àÁ¶°Ç ÀÌ¸§À» Ãß°¡ÇÏ¿© Àç»ý¼º
--primary key : pk_Å×ÀÌºí¸í
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13));
    
--INSERT ±¸¹® º¹»ç
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, '´ë´ö, '´ëÀü');

--PRIMARY KET Á¦¾à : UNIQUE  + NOT NULL

--UNIQE : ÇØ´ç Ä®·³¿¡ µ¿ÀÏÇÑ °ªÀÌ Áßº¹µÉ ¼ö ¾ø´Ù
--        (ex : empÅ×ÀÌºíÀÇempno(»ç¹ø)
--           deptÅ×ÀÌºíÀÇ deptno(ºÎ¼­¹øÈ£))
--            ÇØ´ç ÄÃ·³¿¡ NULL°ªÀº µé¾î °¥ ¼ö ÀÖ´Ù
        
--NOT NULL : µ¥ÀÌÅÍ ÀÔ·Â½Ã ÇØ´ç ÄÃ·³¿¡ °ªÀÌ ¹Ýµå½Ã µé¾î¿Í¾ß ÇÑ´Ù

-- ÄÃ·³ ·¹º§ÀÇ PRIMARY KEY Á¦¾à »ý¼º
--¿À¶óÅ¬ÀÇ Á¦¾àÁ¶°Ç ÀÌ¸§À» ÀÓÀÇ·Î »ý¼º (SYS-C00701)
CREATE TABLE dept_test(
    detpno NUMBER(2) PRIMARY KEY,;

--¿À¶óÅ¬ Á¦¾àÁ¶°ÇÀÇ ÀÌ¸§À» ÀÓÀÇ·Î ¸í¸í
--PRIMARY KEY : pk_Å×ÀÌºí¸í
CREATE TABLE dept_test(
    detpno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,;
    
--PAIRWISE : ½ÖÀÇ °³³ä
--»ó´ÜÀÇ PRIMARY KEY Á¦¾à Á¶°ÇÀÇ °æ¿ì ÇÏ³ªÀÇ ÄÃ·³¿¡ Á¦¾àÁ¶°ÇÀ» »ý¼º
--¿©·¯ ÄÄ·³À» º¹ÇÕÀ¸·Î PRIMARY KEY Á¦¾àÀ¸·Î »ý¼º ÇÒ ¼ö ÀÕµû
--ÇØ´ç ¹æ¹ýÀº À§ÀÇ µÎ°¡Áö ¿¹½ÃÃ³·³ ÄÃ·³ ·¹º§¿¡¼­´Â »ý¼º ÇÒ ¼ö ¾ø´Ù
-->TABLE LEVEL Á¦¾à Á¶°Ç »ý¼º

--±âÁ¸¿¡ »ý¼ºÇÑ dept_test Å×ÀÌºí »èÁ¦ (drop)
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13)), --¸¶Áö¸· ÄÃ·³ ¼±¾ðÈÄ ÄÄ¸¶ •û¸ÔÁö ¾Ê±â

--deptno, dname ÄÃ·³ÀÌ ¯˜À»‹š µ¿ÀÏÇÑ(Áßº¹µÈ)µ¥ÀÌÅÍ·Î ÀÎ½Ä
    CONSTRAINT pk_dept_test PRIMARY KEY(deptno, dname)
    );
    
--ºÎ¼­¹øÈ£, ºÎ¼­ÀÌ¸§ ¼ø¼­½ÖÀ¸·Î Áßº¹ µ¥ÀÌÅÍ¸¦ °ËÁõ
--¾Æ·¡ µÎ°³ÀÇ insert ±¸¹®Àº ºÎ¼­¹øÈ£´Â °°Áö¸¸
--ºÎ¼­¸íÀº ´Ù¸£¹Ç·Î ¼­·Î ´Ù¸¥ µ¥ÀÌÅÍ·Î ÀÎ»è --> INSERT°¡´É
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, '´ë´ö, '´ëÀü');

SELECT *
FROM dept_test;

