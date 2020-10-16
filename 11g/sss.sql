DECLARE
  cur DBMS_SQLTUNE.SQLSET_CURSOR;
BEGIN
  OPEN cur FOR 
    SELECT VALUE(P) FROM TABLE( DBMS_SQLTUNE.SELECT_CURSOR_CACHE(basic_filter=>  'elapsed_time > 0', attribute_list =>'ALL' ))  P;
  DBMS_SQLTUNE.LOAD_SQLSET(sqlset_name=> 'my_workload',
                             populate_cursor => cur);
END;
