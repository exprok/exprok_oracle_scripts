select * 
from v$sysstat s, v$statname sn
where s.STATISTIC#=sn.STATISTIC# and sn.NAME like 'sort%'