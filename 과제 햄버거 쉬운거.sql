--하나의 SQL로 작성하지 마세요
--fastfood 테이블을 이용하여 여러번의sql실행 결과를 
--손으로 계산해서 도시발전지수를 계산
--대전시 유성구
--대전시 동구
--대전시 서구
--대전시 중구
--대전시 대덕구
SELECT *
FROM fastfood
WHERE sido = '대전광역시'
AND gb NOT IN ('맘스터치','파파이스')
ORDER BY sigungu, gb;