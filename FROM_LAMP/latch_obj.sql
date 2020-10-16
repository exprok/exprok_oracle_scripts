select z.obj, a.owner, a.object_name, a.object_type, v.NAME, v.GETS, v.MISSES
from v$latch_children v, sys.x$bh z, all_objects a
where v.ADDR= z.hladdr and z.hladdr = '06C33D64' and a.object_id=z.obj