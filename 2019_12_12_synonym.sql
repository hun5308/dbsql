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

--hun.fastfood --> fastfood �ó������ ����
--������ ���� sql�� ���������� �����ϴ��� Ȯ��
CREATE SYNONYM fastfood FOR hun.fastfood;

SELECT *
FROM fastfood;


