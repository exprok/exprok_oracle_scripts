select ses.USERNAME,
       ses.SID,
       t.CPU_TIME,
       t.EXECUTIONS,
       to_char(t.CPU_TIME / decode(t.EXECUTIONS, 0, 1, t.EXECUTIONS), 99999999) READS_PER_ONE,
       t.*
  from v$sqlarea t, v$session ses
 where ses.SQL_ADDRESS = t.ADDRESS
   and ses.STATUS = 'ACTIVE'
 order by t.CPU_TIMe desc
