select v.SQL_FULLTEXT,sql_text,v.EXECUTIONS,buffer_gets,disk_reads from v$sql v
where v.BUFFER_GETS>100000
or v.DISK_READS>100000
order by v.BUFFER_GETS+100*v.DISK_READS desc
