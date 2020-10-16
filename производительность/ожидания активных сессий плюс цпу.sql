select 
       s.inst_id,
       s.SID,
       

       s.USERNAME,
       sa.SQL_ID sqlid,
       sa.PLAN_HASH_VALUE plan,
       w.EVENT,
       w.STATE,
       sa.SQL_TEXT,
       sa.SQL_FULLTEXT,
       (select value from (select sid, sum(value) value
          from v$sesstat sta, v$statname n
         where sta.STATISTIC# = n.STATISTIC#
           and upper(n.NAME) like '%CPU USED BY THIS%'
           group by sid) where SID = w.SID) cpu,
       w.*,
       s.*
  from gv$session_wait w, gv$session s, gv$sqlarea sa
 where s.STATUS = 'ACTIVE'
   and s.USERNAME is not null
   and w.SID = s.SID 
   and s.USERNAME not in ('DBSNMP', 'SYSMAN')
   and w.EVENT not like 'SQL*Net%'
   and s.SQL_ID = sa.SQL_ID(+)
   and s.inst_id=w.inst_id
   and s.inst_id=sa.inst_id
 order by 2,7, 1 
