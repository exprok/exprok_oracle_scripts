select t.TOTALWORK "All abons", t.SOFAR "Calc abons", round(t.SOFAR/(t.TOTALWORK/100)) "Percent",
trunc(t.ELAPSED_SECONDS/3600)||' ч. '||
trunc(mod(t.ELAPSED_SECONDS/3600, 1) *60)||' мин.' "Time elapsed",
trunc(t.TIME_REMAINING/3600)||' ч. '||
trunc(mod(t.TIME_REMAINING/3600, 1) *60)||' мин.' "Time remaining", 
/*t.MESSAGE,*/ t.ELAPSED_SECONDS, t.START_TIME, ROUND(T.SOFAR/T.ELAPSED_SECONDS,2) SPEED, t.SID
from gV$SESSION_LONGOPS t where t.OPNAME like 'ABONENT GROUP%' and t.START_TIME >= trunc(sysdate)
and t.SOFAR <> t.TOTALWORK order by t.TIME_REMAINING desc
