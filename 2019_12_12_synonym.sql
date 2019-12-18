SELECT *
FROM users;

SELECT *
FROM USER_TABLES;

--78
SELECT *
FROM ALL_TABLES
WHERE OWNER = 'HUN';

SELECT *
FROM hun.fastfood;

--hun.fastfood --> fastfood 시노님으로 생성
--생성후 다음 sql이 정상적으로 동작하는지 확인
CREATE SYNONYM fastfood FOR hun.fastfood;

SELECT *
FROM fastfood;


