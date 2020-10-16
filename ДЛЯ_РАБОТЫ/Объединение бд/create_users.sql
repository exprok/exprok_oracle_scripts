select  'create user "'||u.username|| '" identified by values '''||u1.PASSWORD||''' default tablespace PARUS temporary tablespace TEMP profile '|| u.profile||';'
  from dba_users u, sys.user$ u1
where u.user_id=u1.user#
and u.default_tablespace='PARUS'

order by 1
