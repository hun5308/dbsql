        
--도시발전지수가 높은 순으로 나열
--도시 발전 지수 = (버거킹개수 + KFC개수 + 맥도날드개수) / 롯데리아 개수
--순위 / 시도 / 시군구 / 도시 발전 지수(소수점 첫번째 자리까지/ 둘째 자리에서 반올림)
--1 / 서울특별시/ 서초구 / 7.5
--2/ 서울특별시 / 강남 / 72.3

--해당 시도 , 시군구별 프랜차이즈 숫자 필요
SELECT ROWNUM 순위, sido, sigungu, 도시발전지수
FROM(SELECT a.sido, a.sigungu,/*a.cnt,b.cnt*/ROUND(a.cnt/b.cnt,1) as 도시발전지수  
    FROM(SELECT sido, sigungu, COUNT(*) cnt --버거킹, KFC, 맥도날드 건수
    FROM fastfood
    WHERE gb IN('맥도날드', '버거킹', 'KFC')
    GROUP BY sido, sigungu) a,
    (SELECT sido, sigungu, COUNT(*) cnt --롯데리아 건수
    FROM fastfood
    WHERE gb IN('롯데리아')
    GROUP BY sido, sigungu) b
WHERE a.sido = b.sido  
AND a.sigungu = b.sigungu
ORDER BY 도시발전지수 DESC);





