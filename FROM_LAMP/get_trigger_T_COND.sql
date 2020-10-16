select o.status,'drop trigger PARUS.'||o.object_name||';'
from dba_objects o where o.object_name like 'T_COND%'
