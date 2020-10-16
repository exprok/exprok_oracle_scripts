select * from v$sqlarea t where t.SQL_ID = (select sql_id from v$session where sid=701)
