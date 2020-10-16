select stat.SID, ses.USERNAME, stat.VALUE, name.NAME
  from v$sesstat stat, v$statname name, v$session ses
 where stat.STATISTIC# = name.STATISTIC#
   and name.NAME like '%physical read%'
   and ses.sid=stat.SID
   and ses.STATUS = 'ACTIVE'
   and ses.USER#<>0
   order by name.name, stat.VALUE desc
