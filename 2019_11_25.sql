--rownum_1
SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

--rownum_2
SELECT ROWNUM, A.*  --*이게 올경우 콤마가 올수 없다.
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


--DUAL 테이블 : sys 계정에 있는 누구나 사용 가능한 테이블이며
--데이터는 한행만 존재하며 컬럼(dummy)도 하나 존재

SELECT *
FROM dual;

--SINGLE ROW FUNCTION : 행당 한번의 FUNCTION이 실행
--1개의 행 INPUT -> 1개의 행으로 OUTPUT (COLRUM)
--'Hello World'
SELECT   LOWER('Hello World'), UPPER('Hello World') upper,
         INITCAP ('Hello World')
FROM dual;

--emp 테이브렝는 총 14건의 데이터(직원)가 존재 (14개의 행)
--아래쿼리는 결과도 14개의 행

SELECT  emp.*, LOWER('Hello World') low, UPPER('Hello World') upper,
         INITCAP ('Hello World')
FROM emp;


--컬럼에 fumction 적용
SELECT empno, LOWER(ename) low_ename
FROM emp
WHERE ename = UPPER ('smith');  --직원이름이 smith인 사람을 조회하려면 대문자 (뽑아올때만 소문자, 기본 데이터 형식은 대문자)

--테이블 컬럼을 가공해도 동일한 결과를 얻을 수 있지만
--테이블 컬럼보다는 상수쪾을 가공하는 것이 속도면에서 유리
--해당 컬럼에 인덱스가 존재하더라도 함수를 적용하게 되면 값이 달라지게 되어 
--인덱스를 활욜 할 수 없게 된다
--예외 : FBI(Function Based Index)
SELECT empno, LOWER(ename) low_ename
FROM emp
WHERE LOWER(ename) = 'smith';

--HELLO
--,
--WORLD
--HELLO, WORLD (위 3가지 문자열 상수를 이용, CONCAT함수를 사용하여 문자열 결합)
SELECT CONCAT(CONCAT('HELLO', ', '), 'WORLD') cl,
       'HELLO' || ', ' || 'WORLD' c2,
       --시작인덱스는 1부터, 종료인덱스는 문자열까지 포함한다
       SUBSTR ('HELLO, WORLD', 1, 5) s1, --SUBSTR (문자열, 시작인덱스, 종료인덱스)
       
       --INSTR :문자열에 특정 문자열이 존재하는지 존재할 경우 문자의 인덱스를 리턴
        INSTR('HELLO, WORLD', 'O') i1,  --5
        --'HELLO, WORLD' 문자열의 6번째 인덱스 이후에 등장하는 'o'문자열의 인덱스 리턴
       INSTR('HELLO, WORLD', 'O', 6) i2, --문자열의 특정 인덱스 이후부터 검색 하도록 옵션

        INSTR('HELLO, WORLD', 'O', INSTR('HELLO, WORLD', 'O') + 1) i3,

    --L/RPAD 특정 문자열의 왼쪽 / 오른쪽에 설정한 문자열 길이보다 부족한 만큼 문자열을
    --채워 넣는다
    
    LPAD('HELLO, WORLD', 15, '*') L1,
    LPAD('HELLO, WORLD', 15) L2, --DEFAULT 채움 문자는 공백이다
    RPAD('HELLO, WORLD', 15, '*') R2,
   
   
   --REPALCE (대상문자열, 검색문자열, 변경할문자열)
   --대상문자열에서 검색 문자열을 변경할 문자열로 치환
   
   REPLACE('HELLO, WORLD', 'HELLO', 'hello') rep1, --hello, WORLD
   
   --문자열 앞, 뒤의 공백을 제거
   '   HELLO, WORLD   ' before_trim,
   TRIM('   HELLO, WORLD   ') after_trim,
   TRIM('H' FROM 'HELLO, WORLD') after_trim2
FROM dual;


--숫자 조작함수
--ROUND : 반올림 - ROUND(숫자, 반올림 자리)
--TRUNC : 절삭   - TRUNC ( 숫자, 절삭 자리)
--MOD : 나머지 연산 (자바에서의 %) //  MOD(5, 2) : 1

SELECT --반올림 결과가 소수점 한자리까지 나오도록(소수점 둘째자리에서 반올림)
    ROUND(105.54, 1) r1,
    ROUND(105.55, 1) r2,
    ROUND(105.55, 0) r3, --소수점 첫번쨰 자리에서 반올림
    ROUND(105.54, -1) r4 --정수 첫번쨰 자리에서 반올림
FROM dual;


SELECT --절삭 결과가 소수점 한자리까지 나오도록(소수점 둘째자리에서 절삭)
    TRUNC(105.54, 1) r1,
    TRUNC(105.55, 1) r2,
    TRUNC(105.55, 0) r3, --소수점 첫번쨰 자리에서 절삭
    TRUNC(105.55, -1) r4 --정수 첫번쨰 자리에서 절삭
FROM dual;

--MOD(피제수, 제수) 피제수를 제수로 나눈 나머지 값
-- MOD (M,2) 의 결과 종류 : 0, 1( 0 ~ 제수 -1)        
SELECT MOD(5, 2) M1 -- 5/2 == 몫2 나머지가 1
FROM dual;

--emp테이블의 sal컬럼을 1000으로 나눴을때 사원별 나머지 값을 조회하는 sql작석
SELECT ename, sal,TRUNC(sal /1000, 0) 몫 ,MOD(sal, 1000) 나머지
FROM emp;

--DATE : 년 월 일, 시간, 분, 초
--도구 환경설정 -> 데이타베이스 -> NLS 에서 년월일 보는 방식 수정 가능
SELECT ename, hiredate, TO_CHAR(hiredate, 'YYYY_MM_DD hh24-mi-ss') --YYYY/MM/DD
FROM emp;

--STSDATE : 서버의 현재 DATE를 리턴하는 내장함수, 특별한 인자가 없다
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24:mi:ss')
FROM dual;

--DATE 연산 : DATE + 정수N = N일자 만큼 더한다
--DATE 연산에 있어서 정수는 일자
--하루는 24시간
--DATE 타임에 시간을 더할 수 도 잇다 1시간 = 1/24
SELECT TO_CHAR(SYSDATE + 5, 'YYYY-MM-DD hh24:mi:ss') AFTER5_DAY,
       TO_CHAR(SYSDATE + 5/24, 'YYYY-MM-DD hh24:mi:ss') AFTER5_HOURS,
       TO_CHAR(SYSDATE + 5/24/60, 'YYYY-MM-DD hh24:mi:ss') AFTER5_MIN
FROM dual;

--date 실습
SELECT TO_DATE ('2019-12-31', 'YYYY-MM-DD')  LASTDAY ,
       TO_DATE ('2019-12-31', 'YYYY-MM-DD')-5 LASTDATE_BEFORE5,
       SYSDATE NOW,
       SYSDATE -3
FROm dual;

--YYYY, MM, DD, D(요일을 숫자로 : 일요일 1, 월요일2, 화요일 3 .... 토요일 : 7)
--IW(주차 1 ~ 53), HH, MI, SS
SELECT TO_CHAR(SYSDATE, 'YYYY') YYYY,--현재 년도
       TO_CHAR(SYSDATE, 'MM') MM,--현재월
       TO_CHAR(SYSDATE, 'DD') DD, --현재일
       TO_CHAR(SYSDATE, 'D') D, --현재 요일(주간일자 1 ~ 7)
       TO_CHAR(SYSDATE, 'IW') IW, --현재 일자의 주차
--2019년 12월 31일은 몇주차가 나오는가
       TO_CHAR(TO_DATE('2019-12-13', 'YYYY-MM-DD'), 'IW') IW_20191213
FROM dual;

--date 실습 fn2

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')DT_DASH, 
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')DT_DASH_WIDTH_TIME,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY')DT_MM_YYYY_YYYY
FROM dual;

--DATE 타입의 ROUND, TRUNC 적용
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24:mi:ss') now
       ,TO_CHAR(TRUNC(SYSDATE, 'YYYY'), 'YYYY-MM-DD hh24:mi:ss') now_YYYY
       
       --DD에서 반올림 ( 25일 -> 1개월)
       ,TO_CHAR(TRUNC(SYSDATE, 'MM'), 'YYYY-MM-DD hh24:mi:ss') now_MM
       
       --시간에서 반올림
       ,TO_CHAR(TRUNC(SYSDATE, 'DD'), 'YYYY-MM-DD hh24:mi:ss') now_DD
FROM dual;

--날짜 조작 함수
--MONTHS_BETWEEN(date1, date2) : date2와 date1 사이의 계월수
--ADD_MONTH(date, 가감할 걔월수) : date에서 특정 개월수를 더하거나 뺀 날짜
--NEXT_DAT(date, weekday(1~7)) : date이후 첫번쨰 weekdat 날짜
--LAST DAT(date) : date가 속한 월의 마지막 날짜

--MONTHS_BETWEEN(date1, date2)
SELECT MONTHS_BETWEEN(TO_DATE('2019-11-25', 'YYYY-MM-DD'),
                    TO_DATE('2019-03-31', 'YYYY-MM-DD')) m_bet,
    TO_DATE('2019-11-25', 'YYYY-MM-DD') -
    TO_DATE('2019-03-31', 'YYYY-MM-DD')) d_m --두 날짜 사이의 일자수
FROM dual;

--ADD_MONTHS(date, number(+,-) )
SELECT ADD_MONTHS(TO_DATE('20191125', 'YYYYMMDD'), 5) NOW_AFTER5M,
       ADD_MONTHS(TO_DATE('20191125', 'YYYYMMDD'), -5) NOW_BEFORE5M
      ,SYSDATE + 100 --100일 뒤의 날짜 (월 개념 3-31, 2-28/29)
FROM dual;


--NEXT_DAT(date, weekday number(1~7))
SELECT NEXT_DAY(SYSDATE, 7)--오늘날짜(2019/11/25)일 이후 등장하는 첫번째 토요일
FROM dual;
