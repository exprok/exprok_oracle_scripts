select o.OWNER, o.OBJECT_NAME, o.OBJECT_TYPE, l.SLEEPS, l.MISSES 
from v$latch_children l, x$bh x, dba_objects o
where l.name = 'cache buffers chains' and l.ADDR = x.hladdr and o.OBJECT_ID = x.obj
order by 1 asc,2 asc,4 desc, 5 desc
