select 'grant select on '||table_name||' to public;'  from dba_tab_privs where owner='SYS' and table_name  like 'V%' and grantee='PUBLIC'
