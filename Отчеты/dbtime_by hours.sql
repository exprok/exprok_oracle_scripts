select t1.snap_begin_time,
       t1.db_time_min     db_time_min1,
       t2.db_time_min     db_time_min2
  from (SELECT A.INSTANCE_NUMBER,
               trunc(cast(B.BEGIN_INTERVAL_TIME as date), 'MI') SNAP_BEGIN_TIME,
               ROUND((A.VALUE - LAG(A.VALUE) OVER(ORDER BY A.SNAP_ID)) /
                     1000000 / 60,
                     2) DB_TIME_MIN
          FROM DBA_HIST_SYS_TIME_MODEL A, DBA_HIST_SNAPSHOT B
         WHERE A.SNAP_ID = B.SNAP_ID
           AND A.INSTANCE_NUMBER = B.INSTANCE_NUMBER
           AND A.STAT_NAME = 'DB time'
           and a.instance_number = 1
           and round(cast(b.begin_interval_time as date), 'HH24') -
               cast(b.begin_interval_time as date) < 1 / (24 * 3)) t1
  join (SELECT A.INSTANCE_NUMBER,
               trunc(cast(B.BEGIN_INTERVAL_TIME as date), 'MI') SNAP_BEGIN_TIME,
               ROUND((A.VALUE - LAG(A.VALUE) OVER(ORDER BY A.SNAP_ID)) /
                     1000000 / 60,
                     2) DB_TIME_MIN
          FROM DBA_HIST_SYS_TIME_MODEL A, DBA_HIST_SNAPSHOT B
         WHERE A.SNAP_ID = B.SNAP_ID
           AND A.INSTANCE_NUMBER = B.INSTANCE_NUMBER
           AND A.STAT_NAME = 'DB time'
           and a.instance_number = 3
           
           and round(cast(b.begin_interval_time as date), 'HH24') -
               cast(b.begin_interval_time as date) < 1 / (24 * 3)) t2
    on t2.SNAP_BEGIN_TIME = t1.SNAP_BEGIN_TIME

--ORDER BY 2 DESC;
