SELECT sa.DISK_READS, sa.BUFFER_GETS, sa.EXECUTIONS, sa.*
  FROM v$sqlarea sa
 WHERE sa.ADDRESS IN
       (SELECT pl.ADDRESS
          FROM V$SQL_PLAN pl
         WHERE pl.OPTIONS LIKE '%FULL%'
           AND pl.OBJECT_OWNER = 'PARUS'
           AND pl.OBJECT_NAME IN
               (select t.TABLE_NAME
                  from dba_tables t
                 WHERE t.BLOCKS IS NOT NULL
                   AND t.BLOCKS * 8192 / (1024 * 1024) > 0.1
                   )
                   )
 ORDER BY 1  DESC
