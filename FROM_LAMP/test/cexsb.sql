select a.cexsb, sum(1) 
from d140znn.TB_CP a
group by cexsb
/*order by 2*/
union all
select '9999', count (*) 
from d140znn.TB_CP