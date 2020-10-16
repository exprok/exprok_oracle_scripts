select now.STAT_ID, now.NAME, now.value - history.value delta_value, snaps.begin_interval_time
  from 
    v$sysstat now,
    dba_hist_sysstat history,
    dba_hist_snapshot snaps
  where 
       to_date('02.10.2017 16:01:00', 'DD.MM.YYYY HH24:MI:SS') between snaps.begin_interval_time and snaps.end_interval_time 
   and snaps.instance_number = sys_context('userenv', 'INSTANCE')
   and history.snap_id = snaps.snap_id - 1
   and history.instance_number = sys_context('userenv', 'INSTANCE')
   and now.STAT_ID = history.stat_id
   and now.name = 'redo size'
/
