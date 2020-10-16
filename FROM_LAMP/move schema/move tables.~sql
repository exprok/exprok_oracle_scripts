select 'alter index '||i.owner||'.'||i.index_name||' rebuild tablespace MATERIAL nologging;'
from dba_indexes i
where i.owner='W_SPRMAT_TEST' and i.tablespace_name<>'MATERIAL'

