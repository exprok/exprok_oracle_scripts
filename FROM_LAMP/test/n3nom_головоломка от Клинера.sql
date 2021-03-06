with t as
  (select pos,isg,pol from w_kts.n3nom )
-- ������� �� w_kts.n3nom ������, 1 ������� ��� �������� �� �������� pos, isg,pol, 
-- � � 2-4 �������� ���-�� ����� �������� ��� ������� �������
select pos.pos, count_pos, count_isg, count_pol
from
  (select t.pos, count(*) count_pos from t group by t.pos) pos,
  (select t.isg, count(*) count_isg from t group by t.isg) isg,
  (select t.pol, count(*) count_pol from t group by t.pol) pol,
  (select distinct cex from
    (select t.pos cex from t
      union all
     select t.isg cex from t
      union all
     select t.pol cex from t
    ) 
  )v
where pos.pos(+)=v.cex and isg.isg(+)=v.cex and pol.pol(+)=v.cex
