select
   operation, 
   options, 
   object_name                        name,
   trunc(bytes/1024/1024)             "input(MB)",
   trunc(last_memory_used/1024)       last_mem,
   trunc(estimated_optimal_size/1024) opt_mem, 
   trunc(estimated_onepass_size/1024) onepass_mem, 
   decode(optimal_executions, null, null, 
          optimal_executions||'/'||onepass_executions||'/'||
          w.MULTIPASSES_EXECUTIONS)  
from 
   v$sql_plan     p,
   v$sql_workarea w
where
   p.address=w.address(+)
and 
   p.hash_value=w.hash_value(+) 
and 
   p.id=w.operation_id(+) 
and 
   p.address=
   (select
       address
       from
          v$sql
       where
          sql_text like '%TABLES');
          