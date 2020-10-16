select s.status, s.SID, s.USERNAME,s.OSUSER, sa.SQL_ID,s.SQL_CHILD_NUMBER, sa.SQL_TEXT,sa.SQL_FULLTEXT, w.* from v$session_wait w, v$session s, v$sqlarea sa
where w.EVENT not like 'SQL*N%' --and sid=208
and w.SID(+)=s.SID 
and s.SQL_ADDRESS=sa.ADDRESS(+)
and username is not null
and username not in ('SYSMAN')
order by w.SECONDS_IN_WAIT desc
