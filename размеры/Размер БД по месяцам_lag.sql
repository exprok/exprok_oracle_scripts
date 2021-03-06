with t as
 (SELECT TO_CHAR(end_interval_time, 'dd-mm-yyyy hh24:mi') snap_time,
         ROUND(SUM(tablespace_size) * 8192 / 1024 / 1024 / 1024, 1) size_gb,
         ROUND(SUM(tablespace_usedsize) * 8192 / 1024 / 1024 / 1024, 1) usedsize_gb
  --lag (tablespace_size) over (order by tablespace_size)
    FROM sys.dba_hist_tbspc_space_usage tsu, sys.dba_hist_snapshot s
   WHERE tsu.snap_id = s.snap_id
     and s.INSTANCE_NUMBER = 1
     AND s.snap_id IN
         (SELECT snap_id
            FROM sys.dba_hist_snapshot
           WHERE TO_CHAR(end_interval_time, 'HH24') = '00'
             and TO_CHAR(end_interval_time, 'MI') = '00'
             and TO_CHAR(end_interval_time, 'DD') = '01')
   GROUP BY end_interval_time
   ORDER BY end_interval_time),
t1 as
 (select substr(snap_time, 1, 10),
         size_gb,
         size_gb - lag(size_gb) over(order by size_gb) as lag_
    from t)

select *
  from t1
union all
select '������� ������� � �����:',
       null,
       round(avg(lag_))
  from t1
