select --'OS Busy Time' series,
       --instance_number in1,
       trunc(snaptime, 'HH24') snap_time,
       round(busydelta / (busydelta + idledelta) * 100, 2) "CPU Use (%) inst1",
       t2."CPU Use (%) inst2"
  from (select round(s.begin_interval_time, 'HH24') snaptime,
               s.instance_number,
               os1.value - lag(os1.value) over(order by s.snap_id, s.instance_number) busydelta,
               os2.value - lag(os2.value) over(order by s.snap_id, s.instance_number) idledelta

          from dba_hist_snapshot s, dba_hist_osstat os1, dba_hist_osstat os2
         where s.snap_id = os1.snap_id
           and s.snap_id = os2.snap_id
           and s.instance_number = os1.instance_number
           and s.instance_number = os2.instance_number
           and s.dbid = os1.dbid
           and s.dbid = os2.dbid
           and s.instance_number = 1
           and s.dbid = (select dbid from v$database)
           and os1.stat_name = 'BUSY_TIME'
           and os2.stat_name = 'IDLE_TIME'
           and s.snap_id between 27776 and 29820
           and round(cast(s.begin_interval_time as date), 'HH24') - cast (s.begin_interval_time as date) < 1/(24*3) ) t1
 
join (select --'OS Busy Time' series,
       instance_number in2,
       round(snaptime, 'MI') snap_time,
       round(busydelta / (busydelta + idledelta) * 100, 2) "CPU Use (%) inst2"
  from (select s.begin_interval_time snaptime,
               s.instance_number,
               os1.value - lag(os1.value) over(order by s.snap_id, s.instance_number) busydelta,
               os2.value - lag(os2.value) over(order by s.snap_id, s.instance_number) idledelta

          from dba_hist_snapshot s, dba_hist_osstat os1, dba_hist_osstat os2
         where s.snap_id = os1.snap_id
           and s.snap_id = os2.snap_id
           and s.instance_number = os1.instance_number
           and s.instance_number = os2.instance_number
           and s.dbid = os1.dbid
           and s.dbid = os2.dbid
           and s.instance_number = 2
           and s.dbid = (select dbid from v$database)
           and os1.stat_name = 'BUSY_TIME'
           and os2.stat_name = 'IDLE_TIME'
           and s.snap_id between 27776 and 29820
           and round(cast(s.begin_interval_time as date), 'HH24') - cast (s.begin_interval_time as date) < 1/(24*3)
           )) t2 on t1.snaptime=t2.snap_time
 order by 1 




--select * from dba_hist_snapshot order by snap_id desc
