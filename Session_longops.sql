select
*
from sys.V_$SESSION_LONGOPS t
where sid=16
order by t.LAST_UPDATE_TIME desc