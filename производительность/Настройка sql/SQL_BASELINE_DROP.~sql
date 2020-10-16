

-----получаем sql handle

DECLARE
  v_dropped_plans number;
  v_sqlhandle varchar2(120);  
BEGIN
  

  SELECT SQL_HANDLE into v_sqlhandle --, SQL_TEXT, PLAN_NAME, ORIGIN,
--        ENABLED, ACCEPTED
  FROM   DBA_SQL_PLAN_BASELINES
  WHERE  plan_name='SQL_PLAN_09qz0jbcw7wwcfd56655c';

---- дроппаем план
  v_dropped_plans := DBMS_SPM.DROP_SQL_PLAN_BASELINE (
      sql_handle => v_sqlhandle
  );
  DBMS_OUTPUT.PUT_LINE('dropped ' || v_dropped_plans || ' plans');
END;
/


/*

-- смотрм v$sql на предмет SQL_baseline
  select s.PLAN_HASH_VALUE,
       s.ADDRESS,
       (s.ELAPSED_TIME / s.EXECUTIONS) / 1000000,
       s.EXECUTIONS,
       s.CHILD_NUMBER,
       s.*
  from v$sql s
 where s.SQL_ID = '6nc15cb4pubx8'

*/
