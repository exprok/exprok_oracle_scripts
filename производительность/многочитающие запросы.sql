select b.username username, a.DISK_READS reads, a.EXECUTIONS exec,
a.DISK_READS/decode(a.EXECUTIONS,0,1,a.EXECUTIONS) exec_ratio,
a.SQL_TEXT text
from v$sqlarea a, dba_users b
where
a.PARSING_USER_ID=b.user_id
and a.DISK_READS>100000
order by a.DISK_READS desc
