select 'grant '||t.privilege||' to '||t.grantee||' '||decode(admin_option,'NO',';','YES','WITH ADMIN OPTION;')  from dba_sys_privs t
where t.grantee not in (select role from dba_roles) and t.grantee in (select username from dba_users s where s.default_tablespace = 'PARUS')
