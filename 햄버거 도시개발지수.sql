        
--���ù��������� ���� ������ ����
--���� ���� ���� = (����ŷ���� + KFC���� + �Ƶ����尳��) / �Ե����� ����
--���� / �õ� / �ñ��� / ���� ���� ����(�Ҽ��� ù��° �ڸ�����/ ��° �ڸ����� �ݿø�)
--1 / ����Ư����/ ���ʱ� / 7.5
--2/ ����Ư���� / ���� / 72.3

--�ش� �õ� , �ñ����� ���������� ���� �ʿ�
SELECT ROWNUM ����, sido, sigungu, ���ù�������
FROM(SELECT a.sido, a.sigungu,/*a.cnt,b.cnt*/ROUND(a.cnt/b.cnt,1) as ���ù�������  
    FROM(SELECT sido, sigungu, COUNT(*) cnt --����ŷ, KFC, �Ƶ����� �Ǽ�
    FROM fastfood
    WHERE gb IN('�Ƶ�����', '����ŷ', 'KFC')
    GROUP BY sido, sigungu) a,
    (SELECT sido, sigungu, COUNT(*) cnt --�Ե����� �Ǽ�
    FROM fastfood
    WHERE gb IN('�Ե�����')
    GROUP BY sido, sigungu) b
WHERE a.sido = b.sido  
AND a.sigungu = b.sigungu
ORDER BY ���ù������� DESC);





