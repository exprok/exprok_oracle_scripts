with t1 as (select 'datafiles' df, round(sum(bytes)/(1024*1024*1024)) GB from dba_data_files
union all
select 'tempfiles', round(sum(bytes)/(1024*1024*1024)) GB from dba_temp_files
union all
select 'Redo_logs', round(sum(bytes)/(1024*1024*1024)) GB from v$log
union all
select 'Arclogs_last_24_hours', round(sum(blocks*al.BLOCK_SIZE)/(1024*1024*1024)) from v$archived_log al  where al.COMPLETION_TIME>sysdate-1)
select * from t1
union all
select 'full_without_arclogs', sum(gb)  from t1 where df not like 'Arclogs%'
