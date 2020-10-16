select  'alter table '||t.owner||'.'||t.table_name||' move tablespace MATERIAL nologging;'
from dba_tables t
where t.owner='W_RASKOMP' and t.tablespace_name<>'MATERIAL'
