select a.VALUE Total, b.VALUE Hard, a.VALUE-b.VALUE Soft, round(b.VALUE/a.VALUE*100,1) "HARD%"
from v$sysstat A, v$sysstat B
where a.STATISTIC#=179 and b.STATISTIC#=180