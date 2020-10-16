select sl.SID, START_TIME,TOTALWORK, sofar, (sofar/totalwork) * 100 done,
sysdate + TIME_REMAINING/3600/24 end_at, s.USERNAME, s.MODULE,s.ACTION
from v$session_longops sl, v$session s  
where totalwork > sofar
and s.SID=sl.SID
union 
select 1,sysdate,1,1,1,sysdate,'1','1','1' from dual
order by 6 desc
--AND opname NOT LIKE '%aggregate%'
--AND opname like 'RMAN%'
