select 'alter user '||u.username||' account lock;'
from dba_users u
where u.account_status<>'LOCKED' and 
      username not in ('SYS','SYSTEM','ADMIN','OUTLN','DBSNMP','PARUS')
order by u.user_id