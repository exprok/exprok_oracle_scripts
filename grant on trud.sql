select 
'GRANT '||privilege||' ON '||OWNER||'.'||TABLE_NAME||' TO '||GRANTEE||decode(GRANTABLE, 'YES', ' WITH GRANT OPTION')||';'
from dba_tab_privs
where owner in ('W_OTK', 'W_OTKV', 'W_TRUD_SITE3', 'W_MP', 'W_VO', 'W_PROF', 'W_OBNO', 'W_OSNOV', 'W_GROPL', 'W_KTSG', 'W_MMKT', 'W_SPRMAT', 'W_KADR', 'W_AD')