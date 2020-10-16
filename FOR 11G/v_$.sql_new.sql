select 'grant '||PRIViLEGE||' on SYS.'||table_name||' to '||r.grantee||';' from 
(select grantee, table_name, p.privilege from dba_tab_privs p where p.owner ='SYS'
and 
  (table_name  like 'DBA%'
    or table_name  like 'V`_%' escape '`')
and (grantee ='PUBLIC'
or grantee like 'W`_%' escape '`'
or grantee='ADMIN')
union 
select 'PUBLIC', 'DBMS_LOCK', 'EXECUTE' from dual) r

