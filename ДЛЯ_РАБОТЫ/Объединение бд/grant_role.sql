select 'grant "'|| granted_role|| '" to "'||grantee||'";' from dba_role_privs p 
where grantee in (select username from dba_users u where u.default_tablespace = 'PARUS')
