select * from dba_scheduler_job_run_details rd where job_name like 'CALC_JOB_STREAM%' and log_date> sysdate-2 order by rd.LOG_DATE desc;

select inst_id, count(1) from gv$session s where s.ACTION like  'CALC_JOB_STREAM%' group by inst_id;

select 'осталось посчитать зон' z, count(1) from dba_scheduler_jobs js where js.job_name like 'CALC_JOB_STREAM%'
union
select 'зон посчитано', count(1) from dba_scheduler_job_run_details rd where job_name like 'CALC_JOB_STREAM%' and log_date> sysdate-1/5 ;

.
--select * from prior_calc
