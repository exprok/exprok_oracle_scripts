/*begin
  Dbms_Scheduler.create_job(job_name =>  'W_MAIL.ddd',
                            job_type => 'PLSQL_BLOCK',
                            job_action =>  'begin null; end;',
                            schedule_name => 'ADMIN.SCHED_NIGHT',
                            job_class => 'SCHEDCLASS',
                            enabled => TRUE);
end; */                      

begin
  dbms_scheduler.drop_job('W_MAIL.MY_FIRST_JOB');
end;
