
SELECT
    MAX(DECODE(d, 1, dt)) 일, MAX(DECODE(d, 2, dt)) 월, MAX(DECODE(d, 3, dt)) 화,
    MAX(DECODE(d, 4, dt)) 수, MAX(DECODE(d, 5, dt)) 목, MAX(DECODE(d, 6, dt)) 금, MAX(DECODE(d, 7, dt)) 토
FROM
    (SELECT 
            TO_DATE(:yyyymm, 'YYYYMM') - 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL - 1) dt,
            
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') - 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL - 1), 'D') d,
            
            TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') - 
            (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) + (LEVEL), 'IW') iw
            
    FROM dual
    CONNECT BY LEVEL <=(SELECT LDT-FDT +1
                        FROM  
                          (SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
                           LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) +
                           7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
                           TO_DATE(:yyyymm, 'YYYYMM') -
                           (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
                           FROM dual)))
    GROUP BY dt - (d - 1)
    ORDER BY dt - (d - 1);
    
----------------------------------------------------------------------------------    
--201910 : 35, 첫주의 일요일 : 201909, 마지막 날짜 :20191102
--일(1), 월(2), 화(3), 수(4), 목(5), 금(6), 토(7)
(SELECT LDT-FDT +1
FROM  
      (SELECT LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) dt,
       LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) +
       7 - TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'D') ldt,
       TO_DATE(:yyyymm, 'YYYYMM') -
       (TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM'), 'D') -1) fdt
       FROM dual));




-----------------------------------------------------------------------------------
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1)*3) || deptnm
FROM dept_h
START WITH deptcd='dept0' --시작점은 deptcd = 'dept0' --->XX회사 최상위 조직
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT LEVEL LV, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm AS deptnm, P_deptcd
FROM dept_h
START WITH deptcd='dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT *
FROM dept_h;


/*
    dept0 (xx회사)
        dept0_00 (디자인부)
            dept00_0 (디자인팀)
        dept0_01 (정보기획부)
            dept01_0 (기획팀)
                dept0_00_0_0(기획파트)
        dept0_02 (정보시스템부)
            dept02_0 (개발1팀)
            dept02_1 (개발2팀)*/
            
--디자인팀(dept0_00_0)을 기준으로 상향싱 계충쿼리  작성
--자기 부서의 부모 부서와 연결을 한다


SELECT deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm AS deptnm, P_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd AND PRIOR deptnm LIKE '디자인%'; --AND col = PRIOR col2;

---------------------------------h_4
SELECT LPAD(' ', (LEVEL-1)*4) || s_id AS s_id, value    
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

---------------------------------h_5 (숙제)

SELECT LPAD(' ', (LEVEL-1)*4) || org_cd AS org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

--pruning branch(가지치기)
--계층 쿼리의 실행순서
--FROM --> START WITH - CONNECT BY --> WHERE
--조건을 CONNECT BY 절에 기술한 경우
-- . 조건에 따라 다음 ROW로 연경이 안되고 종료
--조건을 WHERE절에 기술한 경우
--.START WITH ~ CONNECT BY 절에 의해 계층형으로 나온 결과에
-- WHERE 절에 기술한 결과 값에 해당하는 데이터만 조회


-- 최상위 노드에서 하향식으로 탐색
SELECT *
FROM dept_h
WHERE deptcd='dept0';

--CONNECTY BY절에 deptnm != '정보기획부' whrjsdmf 기술한 경우
SELECT *
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '정보기획부';

--WHERE절에 deptnm != '정보기획부' whrjsdmf 기술한 경우
--계층쿼리를 실행하고 나서 최종결괴에 WHERE절 조건을 적용

SELECT *
FROM dept_h
WHERE deptnm != '정보기획부'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--계층쿼리에서 사요가능한 특수함수
--CONNECT_BY ROOT(col) 가장 최상위 row의 col정보 값 조회
-- sys_CONNECT_BY_PATH(col,구분자) : 최상위 row에서 현재 로우까지 col값을
-- 구분자로 연결해준 문자열(ex : xx회사 - 디자인부디자인팅)
--CONNECT_BY_ISLEAF : 해당 ROW가 마지막 노드인지(leaf node)
-- lesf node : 1, node : 0
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm,
        CONNECT_BY_ROOT(deptnm) c_root,
        LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'),'-')  sys_path,
        CONNECT_BY_ISLEAF isleaf 
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;


