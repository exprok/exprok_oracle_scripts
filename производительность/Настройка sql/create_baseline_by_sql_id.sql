BEGIN
  DBMS_SQLTUNE.DROP_SQLSET(
    sqlset_name => 'MySTS01');
END;
 
-- Create SQL Tuning Set (STS)
BEGIN
  DBMS_SQLTUNE.CREATE_SQLSET(
    sqlset_name => 'MySTS01',
    description => 'SQL Tuning Set for sharonov');
END;
 
-- Populate STS from AWR, using a time duration when the desired plan was used
--  List out snapshot times using :   SELECT SNAP_ID, BEGIN_INTERVAL_TIME, END_INTERVAL_TIME FROM dba_hist_snapshot ORDER BY END_INTERVAL_TIME DESC;
--  Specify the sql_id in the basic_filter (other predicates are available, see documentation)
DECLARE
  cur sys_refcursor;
BEGIN
  OPEN cur FOR
    SELECT VALUE(P)
    FROM TABLE(dbms_sqltune.select_cursor_cache(basic_filter => 'sql_id = ''58nnny2bvyg0x''')) p;
--       select_workload_repository(basic_filter=>'sql_id = ''939abmqmvcc4d''',attribute_list=>'ALL')
--              ) p;
     DBMS_SQLTUNE.LOAD_SQLSET( sqlset_name=> 'MySTS01', populate_cursor=>cur);
  CLOSE cur;
END;


SELECT
  first_load_time          ,
  executions as execs              ,
  parsing_schema_name      ,
  elapsed_time  / 1000000 as elapsed_time_secs  ,
  cpu_time / 1000000 as cpu_time_secs           ,
  buffer_gets              ,
  disk_reads               ,
  direct_writes            ,
  rows_processed           ,
  fetches                  ,
  optimizer_cost           ,
  sql_plan                ,
  plan_hash_value          ,
  sql_id                   ,
  sql_text
   FROM TABLE(DBMS_SQLTUNE.SELECT_SQLSET(sqlset_name => 'MySTS01')
             );
             
             
DECLARE
my_plans pls_integer;
BEGIN
  my_plans := DBMS_SPM.LOAD_PLANS_FROM_SQLSET(
    sqlset_name => 'MySTS01', 
    basic_filter=>'plan_hash_value = ''154867601'''
    );
END;
