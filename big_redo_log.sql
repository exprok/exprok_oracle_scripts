select s.SID, sn.NAME, s.VALUE
from v$sesstat s, v$statname sn
where s.STATISTIC#=sn.STATISTIC# and sn.NAME='redo size'
order by 3 desc