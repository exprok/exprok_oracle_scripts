select o.owner, o.object_name, o.object_type
from dba_objects o
where o.owner='W_KART_RAZR'
order by 2