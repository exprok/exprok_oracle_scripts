select a.Att_Audid, sum(1) 
from d140znn.TB_AUDI a
group by Att_Audid
/*order by 2*/
union all
select 9999, count (*) 
from d140znn.TB_AUDI