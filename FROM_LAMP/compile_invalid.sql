select rownum rn,'alter '||o.object_type||' '||o.owner||'.'||o.object_name||' compile;'
from dba_objects o
where o.status='INVALID' and o.object_type='PROCEDURE'
