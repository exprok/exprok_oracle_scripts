declare
  stmt_task VARCHAR2(40);
begin
  stmt_task := DBMS_SQLTUNE.CREATE_TUNING_TASK(sql_id     => '8jphu6bg2gpty',
                                               time_limit => 300);
  DBMS_OUTPUT.put_line('task_id: ' || stmt_task);

  DBMS_SQLTUNE.EXECUTE_TUNING_TASK(task_name => stmt_task);
end;
-----------------
SELECT TASK_NAME, STATUS
  FROM DBA_ADVISOR_LOG
 WHERE TASK_NAME = 'TASK_127677'
-----------
  SELECT DBMS_SQLTUNE.REPORT_TUNING_TASK('TASK_116711') AS recommendations           FROM dual;


begin
 dbms_sqltune.accept_sql_profile(task_name => 'TASK_116707',
            task_owner => 'TIGER', replace => TRUE);
end;
