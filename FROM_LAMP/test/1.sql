select * 
from dba_tab_histograms h
where h.owner='D140ZNN' and h.table_name in ('TB_AUDI', 'TB_CP')
order by 2,3,4