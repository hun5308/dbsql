
SELECT
    MAX(DECODE(d, 1, dt)) ��, MAX(DECODE(d, 2, dt)) ��, MAX(DECODE(d, 3, dt)) ȭ,
    MAX(DECODE(d, 4, dt)) ��, MAX(DECODE(d, 5, dt)) ��, MAX(DECODE(d, 6, dt)) ��, MAX(DECODE(d, 7, dt)) ��
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
--201910 : 35, ù���� �Ͽ��� : 201909, ������ ��¥ :20191102
--��(1), ��(2), ȭ(3), ��(4), ��(5), ��(6), ��(7)
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
START WITH deptcd='dept0' --�������� deptcd = 'dept0' --->XXȸ�� �ֻ��� ����
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT LEVEL LV, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm AS deptnm, P_deptcd
FROM dept_h
START WITH deptcd='dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT *
FROM dept_h;


/*
    dept0 (xxȸ��)
        dept0_00 (�����κ�)
            dept00_0 (��������)
        dept0_01 (������ȹ��)
            dept01_0 (��ȹ��)
                dept0_00_0_0(��ȹ��Ʈ)
        dept0_02 (�����ý��ۺ�)
            dept02_0 (����1��)
            dept02_1 (����2��)*/
            
--��������(dept0_00_0)�� �������� ����� ��������  �ۼ�
--�ڱ� �μ��� �θ� �μ��� ������ �Ѵ�


SELECT deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm AS deptnm, P_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY deptcd = PRIOR p_deptcd AND PRIOR deptnm LIKE '������%'; --AND col = PRIOR col2;

---------------------------------h_4
SELECT LPAD(' ', (LEVEL-1)*4) || s_id AS s_id, value    
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

---------------------------------h_5 (����)

SELECT LPAD(' ', (LEVEL-1)*4) || org_cd AS org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

--pruning branch(����ġ��)
--���� ������ �������
--FROM --> START WITH - CONNECT BY --> WHERE
--������ CONNECT BY ���� ����� ���
-- . ���ǿ� ���� ���� ROW�� ������ �ȵǰ� ����
--������ WHERE���� ����� ���
--.START WITH ~ CONNECT BY ���� ���� ���������� ���� �����
-- WHERE ���� ����� ��� ���� �ش��ϴ� �����͸� ��ȸ


-- �ֻ��� ��忡�� ��������� Ž��
SELECT *
FROM dept_h
WHERE deptcd='dept0';

--CONNECTY BY���� deptnm != '������ȹ��' whrjsdmf ����� ���
SELECT *
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '������ȹ��';

--WHERE���� deptnm != '������ȹ��' whrjsdmf ����� ���
--���������� �����ϰ� ���� �����ᱫ�� WHERE�� ������ ����

SELECT *
FROM dept_h
WHERE deptnm != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--������������ ��䰡���� Ư���Լ�
--CONNECT_BY ROOT(col) ���� �ֻ��� row�� col���� �� ��ȸ
-- sys_CONNECT_BY_PATH(col,������) : �ֻ��� row���� ���� �ο���� col����
-- �����ڷ� �������� ���ڿ�(ex : xxȸ�� - �����κε�������)
--CONNECT_BY_ISLEAF : �ش� ROW�� ������ �������(leaf node)
-- lesf node : 1, node : 0
SELECT deptcd, LPAD(' ', 4*(LEVEL-1)) || deptnm,
        CONNECT_BY_ROOT(deptnm) c_root,
        LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'),'-')  sys_path,
        CONNECT_BY_ISLEAF isleaf 
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;


