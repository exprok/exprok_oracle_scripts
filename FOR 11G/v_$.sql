select 'grant select on '||table_name||' to public;' from dba_tab_privs p where grantee='PUBLIC' and p.table_name like 'V`_$%' escape '`'
