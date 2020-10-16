SELECT decode(ses.STATUS,
              'ACTIVE',
              '===== ' || ses.USERNAME,
              '             ' || ses.USERNAME) un,
       st.SID,
       st.VALUE,
       decode(sn.NAME, 'session logical reads', 'лог', 'физ') AS sn,
       sa.SQL_TEXT
  FROM V$SESSTAT st, V$STATNAME sn, v$session ses, v$sqlarea sa
 WHERE st.STATISTIC# = sn.STATISTIC#
   AND sn.NAME IN ('session logical reads', 'physical reads')
   AND ses.SID = st.SID
      --AND ses.STATUS='ACTIVE'
   AND ses.SQL_ADDRESS = sa.ADDRESS(+)
   AND ses.USERNAME IS NOT NULL
   AND st.VALUE > '5000'
 ORDER BY 4 DESC, 3 DESC
