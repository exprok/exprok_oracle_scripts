SELECT v.module, COUNT(*)
  FROM (SELECT DISTINCT ss.module, ss.machine
           FROM V$SESSION ss
          WHERE module IN (SELECT upper(a.appcode) FROM parus.applist a)
            AND STATUS IN ('INACTIVE', 'ACTIVE')) v
 GROUP BY v.module
