select t.blocks, t.table_name from dba_tables t where t.blocks is not null and owner='PARUS' order by t.blocks desc
 
