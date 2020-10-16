SELECT TO_CHAR(end_interval_time, 'dd-mm-yyyy hh24:mi') snap_time,
       ROUND(SUM(tablespace_size) * 8192 / 1024 / 1024 / 1024, 1) size_gb,
       ROUND(SUM(tablespace_usedsize) * 8192 / 1024 / 1024 / 1024, 1) usedsize_gb
  FROM sys.dba_hist_tbspc_space_usage tsu, sys.dba_hist_snapshot s
 WHERE tsu.snap_id = s.snap_id
   and s.INSTANCE_NUMBER=1
   AND s.snap_id IN
       (SELECT snap_id
          FROM sys.dba_hist_snapshot
         WHERE TO_CHAR(end_interval_time, 'HH24') = '00'
         and TO_CHAR(end_interval_time, 'MI') = '00'
         and   TO_CHAR(end_interval_time, 'DD') = '01') 
 GROUP BY end_interval_time
 ORDER BY end_interval_time;
