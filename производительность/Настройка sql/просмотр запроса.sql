select s.inst_id,
       s.PLAN_HASH_VALUE,
       s.PARSING_SCHEMA_NAME,
       s.EXECUTIONS,
       round(s.ELAPSED_TIME / decode(s.EXECUTIONS,0,1,s.EXECUTIONS)),
       s.ELAPSED_TIME,
       s.SQL_PLAN_BASELINE,
       s.SQL_PROFILE,
       s.*
  from gv$sql s
 where sql_id = 'dfv03jar1a1n6'
 order by 3 desc

--select * from v$instance
