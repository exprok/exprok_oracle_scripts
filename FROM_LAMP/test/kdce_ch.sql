select a.kdce_ch, sum(1) 
from d140znn.TB_CP a
group by a.kdce_ch
/*order by 2*/
union all
select 9999, count (*) 
from d140znn.TB_CP
