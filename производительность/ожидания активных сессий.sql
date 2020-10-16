select s.SID, s.USERNAME, w.EVENT, sa.SQL_TEXT, w.*, s.*
  from v$session_wait w, v$session s, v$sqlarea sa
 where
    s.STATUS = 'ACTIVE'
   and  s.USERNAME is not null
   and w.SID = s.SID
   and s.USERNAME not in ('DBSNMP','SYSMAN')
   and w.EVENT not like 'SQL*Net%'
   and s.SQL_ID=sa.SQL_ID(+)
