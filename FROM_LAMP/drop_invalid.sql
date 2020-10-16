select 'drop '||o.object_type||' '||o.owner||'."'||o.object_name||'";'
from dba_objects o
where o.status='INVALID' and o.object_type='JAVA_CLASS';