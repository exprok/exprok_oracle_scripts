insert into tgrant_to_w_www select o.owner, o.object_name
from dba_objects o
where o.owner='W_TRUD_EX' and o.object_name like '%AGAFONOVA'
order by 2