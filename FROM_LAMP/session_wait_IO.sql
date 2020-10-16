select e.owner, e.segment_name, e.segment_type, e.tablespace_name, sw.*, s.* 
from v$session_wait sw, v$session s, dba_extents e
where sw.SID=s.SID and s.USERNAME is not null and event not like '%Net%' and sw.P1TEXT like 'file%' 
 and e.block_id <=sw.P2 and e.block_id+e.blocks>sw.P2 and e.file_id=sw.P1
order by 3 desc
