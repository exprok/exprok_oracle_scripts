select 'grant '||dp.privilege||' on '||dp.owner||'.'||dp.table_name||' to '||dp.grantee||decode(dp.grantable,'YES',' with grant option;',';')
from dba_tab_privs dp
where dp.grantee='PARUS'