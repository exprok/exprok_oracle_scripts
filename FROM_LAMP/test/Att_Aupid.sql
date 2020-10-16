select a.Att_Aupid, sum(1) 
from d140znn.TB_AUDI a
where Att_Aupid < 1000
group by Att_Aupid
/*order by 2*/
union all
select 9999, count (*) 
from d140znn.TB_AUDI