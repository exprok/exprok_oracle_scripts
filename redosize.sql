select s.SID, s.USERNAME, s.TERMINAL,s.LOGON_TIME,s.PROGRAM,sn.NAME,ss.VALUE
from v$sesstat ss, v$statname sn, v$session s
where ss.STATISTIC#=sn.STATISTIC# and sn.NAME='redo size' and ss.SID=s.sid
order by ss.VALUE desc