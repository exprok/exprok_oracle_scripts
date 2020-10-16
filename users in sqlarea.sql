select b.username, a.* from v$sqlarea a, dba_users b 
where a.PARSING_USER_ID=b.user_id order by 2