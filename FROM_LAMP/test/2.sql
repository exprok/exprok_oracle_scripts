select t.num_rows, s.table_name, s.column_name, s.num_distinct, s.density, s.num_nulls, s.num_buckets, s.sample_size, s.num_buckets/s.num_distinct "ratio", s.low_value, s.high_value
from dba_tab_col_statistics s, dba_tables t
where s.owner='D140ZNN' and s.table_name in ('TB_AUDI', 'TB_CP') and s.owner=t.owner and s.table_name=t.table_name
order by 2,3