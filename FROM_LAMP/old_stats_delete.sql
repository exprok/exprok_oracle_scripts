SELECT s.snap_id, s.snap_time 
from stats$snapshot s
where s.snap_time+10 < sysdate or
      (trunc(s.snap_time)+5 < sysdate and s.snap_time <>
       (select min(s1.snap_time) from stats$snapshot s1 where trunc(s.snap_time,'DD') = trunc(s1.snap_time)))