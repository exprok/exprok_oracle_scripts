
declare
  v_int pls_integer;
begin
  v_int := dbms_spm.load_plans_from_sqlset(sqlset_name  => 'sneg_job_set',
                                           sqlset_owner => 'SYS',
                                           basic_filter => 'sql_id = ''fssrd4a3ggurn'' and plan_hash_value = 3632835907',
                                           fixed        => 'YES',
                                           enabled      => 'YES');
  DBMS_OUTPUT.PUT_line(v_int);
end;


--sql_id => 'fssrd4a3ggurn',plan_hash_value => 3632835907

/*declare
  ref_cur DBMS_SQLTUNE.SQLSET_CURSOR;
begin
  open ref_cur for
    select VALUE(p)
      from table(DBMS_SQLTUNE.SELECT_WORKLOAD_REPOSITORY(24496,
                                                         24525,
                                                         basic_filter   => 'sql_id = ''fssrd4a3ggurn''',
                                                         attribute_list => 'ALL')) p;
  DBMS_SQLTUNE.LOAD_SQLSET('sneg_job_set', ref_cur);
end;
*/
