select s.SID,
       s.USERNAME,
       s.RESOURCE_CONSUMER_GROUP,
       s.MODULE,
       s.PROGRAM,
       s.ACTION,
       sysdate
  from v$session s
 where s.STATUS = 'ACTIVE'
   and s.USERNAME is not null
