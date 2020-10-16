select s.PLAN_HASH_VALUE,
       s.ADDRESS,
       (s.ELAPSED_TIME / s.EXECUTIONS) / 1000000,
       s.EXECUTIONS,
       s.CHILD_NUMBER,
       s.*
  from v$sql s
 where s.SQL_ID = '6nc15cb4pubx8'
