--dept 테이블에 부서번호 99, 부서명 ddit, 위치 daejeon
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
COMMIT;

--UPDATE : 테이블에 저장된 컬럼의 값을 변경
--UPDATE 테이블명 SET 컬럼명  1 = 적용하려고 하는 값1, 컬럼명2=적용하려고 하는값......
--[WHERE row 조회조건] -- 조회조건에 해당하는 데이터만 업데이트가 된다

--부서번호가 99인 부서의 부서명을 대덕IT로, 지역을 영민 빌딩으로 변경
UPDATE dept SET dname = '대덕IT', loc = '영민빌딩'
WHERE deptno = 99;

--업데이트전에 업데이트 하려고하는 테이블을 WHERE절에 기술한 조건으로 SELECT를 하여 업데이트 대상 ROW를 확인해 보자

SELECT *
FROM dept
WHERE deptno = 99; 

--다음 쿼리를 실행하면 WHERE절에 ROW제한 조건이 없기 떄문에
--dept 테이블의 모든행에 대해 부서명, 위치 정보를 수정한다
UPDATE dept SET dname = '대덕IT', loc = '영민빌딩';

--서비스 오픈전 테스트 데이터 삭제 --> 프로그램

--서브쿼리를 이용한UPDATE
--emp테이블에 신규데이터 입력
---사원번호 9999, 사원이름 brown, 업무 : null
INSERT INTO emp(empno, ename) VALUES (9999, 'brown');
COMMIT;

--사원번호가 9999인 사원의 소속부서와, 담당 없무를 SMITH 사원의 부서, 업무로 업데이트
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
                job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;
COMMIT;
SELECT *
FROM emp
WHERE empno = 9999;

--DELETE : 조건에 해당하는 ROW를 삭제
--컬럼의 값을 삭제??(null)값으로 변경하려면 --> UPDATE

--DELETE 테이블명
--[WHERE 조건]

--UPDATE쿼리와 마찬가지로 DELETE 쿼리 실행전에는 해당 테이블을 WHERE조건을 동인하게 하여
--SELECT를 실행, 삭제될 ROW를 먼저 확인해보자

--emp테이블에 존재하는 사원번호 9999인 사원을 삭제
DELETE emp
WHERE empno = 9999;

SELECT *
FROM emp
WHERE empno = 9999;

COMMIT;

--매니저가 7698인 모든 사원을 삭제
-- 서브쿼리를 사용

DELETE emp
WHERE empno IN (SELECT empno
                FROM emp
                WHERE mgr = 7698);
ROLLBACK;
--위 쿼리는 아래 쿼리와 동인
DELETE emp WHERE mgr = 7698;

