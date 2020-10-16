select spid, osuser, s.program, s.LOGON_TIME, s.sid, 'orakill '||d.NAME||' '||spid as orakill 
from v$process p, v$session s, v$database d
where p.addr=s.paddr and sid=97
order by 4 
