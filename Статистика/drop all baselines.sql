declare
  n integer;
  v varchar2(128);
begin

  for c in (select distinct sql_handle  from dba_sql_plan_baselines b) loop
    dbms_output.put_line(c.sql_handle);
     n:=  DBMS_SPM.DROP_SQL_PLAN_BASELINE (  sql_handle => c.sql_handle);
  end loop;
end;
