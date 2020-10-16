select * 
from v$session_event se, v$session s
where se.SID=s.SID and s.USERNAME is not null  and event not like '%Net%'
order by 3 desc