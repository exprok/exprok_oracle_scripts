select c.table_name, c.column_name, c.data_type, h.endpoint_number, h.endpoint_value, h.endpoint_actual_value
from dba_tab_histograms h, dba_tab_cols c
where h.owner='D140ZNN' and h.owner=c.owner and h.table_name=c.table_name and h.column_name=c.column_name and c.table_name in ('TB_AUDI', 'TB_CP')
order by 1,2,4