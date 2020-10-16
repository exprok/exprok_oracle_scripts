select s.SID, s.USERNAME, s.ACTION,  s.TERMINAL, s.PROGRAM, s.LOGON_TIME, sw.*
from v$session_wait sw, v$session s
where sw.SID=s.SID and s.USERNAME is not null and event not like '%Net%'
order by 3 desc