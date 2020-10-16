


-- удаление sql_profile
BEGIN
  DBMS_SQLTUNE.DROP_SQL_PROFILE ( 
    name => 'SYS_SQLPROF_015f25781a3b008a' 
);
END;
