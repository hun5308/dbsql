--FOR LOOP���� ����� Ŀ�� ����ϱ�
--�μ����̺��� ��� ���� �μ��̸�, ��ġ, ���� ������ ��� (CURSOR)�� �̿�
SET SERVEROUTPUT ON;
DECLARE
--Ŀ�� ����
    CURSOR dept_cursor IS
        SELECT dname, loc
        FROM dept;
        v_dname dept.dname%TYPE;
        v_loc dept.loc%TYPE;
BEGIN
    FOR record_row IN dept_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(record_row.dname || ', ' || record_row.loc);
END LOOP;
END;
/

--Ŀ������ ���ڰ� ���� ���
DECLARE
--Ŀ�� ����
    CURSOR dept_cursor(p_deptno dept.deptno%TYPE)IS
        SELECT dname, loc
        FROM dept;
        v_dname dept.dname%TYPE;
        v_loc dept.loc%TYPE;
BEGIN
    FOR record_row IN dept_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(record_row.dname || ', ' || record_row.loc);
END LOOP;
END;
/

