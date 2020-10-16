select to_date('01.01.1970','DD.MM.YYYY')+st.VALUE/(60*60*24)+4/24 as activity, ss.*
from v$session ss, v$sesstat st, v$statname sn
where st.STATISTIC#=sn.STATISTIC# and sn.NAME='process last non-idle time' and st.SID=ss.sid
order by 1 desc