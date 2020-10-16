select 'alter user "'||u.username||'" account unlock;' from dba_users u
where u.account_status <> 'OPEN'
order by u.username
