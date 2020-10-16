select ATT_ARVER, sum(1) 
from d140znn.TB_AUDI
group by ATT_ARVER
/*order by 2*/
union all
select 9999, count (*) 
from d140znn.TB_AUDI

