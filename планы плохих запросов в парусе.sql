select distinct(tt2.SQL_TEXT)/*, tt1.**/ FROM (SELECT lpad(' ', p1.POSITION * 10) || p1.OPERATION AS zag,
       p1.OPTIONS,
       p1.OBJECT_OWNER,
       p1.OBJECT_NAME,
       p1.id,
       p1.PARENT_ID,
       p1.address
     
--       p1.*
  FROM V$SQL_PLAN p1
 WHERE p1.address IN (select address
                        from V$SQL_PLAN p, DBA_TABLES t
                       WHERE options LIKE '%FULL%'
                         AND object_owner = 'PARUS'
                         AND t.OWNER = 'PARUS'
                         AND t.TABLE_NAME = p.OBJECT_NAME
                         AND t.BLOCKS > 1000)) tt1, v$sqlarea tt2
/*CONNECT BY PRIOR id = parent_id
 START WITH id = 1*/
 WHERE tt1.address=tt2.ADDRESS
 -- ORDER BY tt1.ADDRESS, ID
