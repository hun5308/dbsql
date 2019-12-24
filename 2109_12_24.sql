--FOR LOOP에서 명시적 커서 사용하기
--부서테이블의 모든 행의 부서이름, 위치, 지역 정보를 출력 (CURSOR)를 이용
SET SERVEROUTPUT ON;
DECLARE
--커서 선언
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

--커서에서 인자가 들어가는 경우
DECLARE
--커서 선언
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

