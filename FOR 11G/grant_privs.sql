select 'grant '||privilege||' to '||grantee||';' from dba_sys_privs where grantee like 'W%`_%' escape '`'
