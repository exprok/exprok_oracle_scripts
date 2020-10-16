select o.object_type, count(*)
from dba_objects o
where o.status='INVALID'
group by o.object_type
union all
select 'ALL', count(*)
from dba_objects o
where o.status='INVALID'
