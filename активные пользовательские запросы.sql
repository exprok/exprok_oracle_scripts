-- Активные пользовательские запросы, 

SELECT vs.USERNAME,  sa.sql_text, ceil(sa.CPU_TIME/decode(0,sa.executions,1,sa.executions)) ex_per_one,  sa.CPU_TIME all_cpu, sa.DISK_READS, sa.EXECUTIONS, vs.logon_time, vs.machine , vs.osuser
  FROM v$session vs, v$sqlarea sa
 WHERE vs.sql_hash_value = sa.hash_value
   AND status = 'ACTIVE'
   AND RAWTOHEX(vs.sql_address) <> '00'
   AND vs.username IS NOT NULL
 order by ex_per_one desc
