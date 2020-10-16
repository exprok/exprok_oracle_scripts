select  distinct o.owner,  o.object_name, avg( b.tch)  --b.tim, b.class, b.tch, o.owner || '.' || o.object_name, b.*
  from x$bh b, dba_objects o, v$latch_children l
 where b.obj = o.data_object_id
   and owner not in ('SYS', 'SYSTEM')
   and b.hladdr = l.addr
   and l.name = 'cache buffers chains'       
   and b.TCH >1000
 group by o.owner, o.object_name  
 order by avg( b.tch) desc
