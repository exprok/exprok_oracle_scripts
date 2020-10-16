SELECT OUTPUT
FROM TABLE (dbms_workload_repository.awr_global_report_html(l_dbid => 2772456466,l_inst_num => '',l_bid => 47957 ,l_eid => 47973));


select * from v$database

select * from dba_hist_snapshot s order by s.snap_id desc
