select distinct owner from dba_segments s where s.tablespace_name ='TIGER'

select * from dba_segments s where s.owner='DEV'

expdp directory=EXPRIR, DUMPFILE=predump_tiger_dev_cs_csf_%U.dmp schemas=DEV,TIGER,CS,CSF parallel=10 flashback_time=systimestamp

Starting "SYS"."SYS_EXPORT_SCHEMA_07":  /******** AS SYSDBA directory=EXP_DIR COMPRESSION=ALL CLUSTER=NO DUMPFILE=predump_tiger_dev_cs_csf_%U.dmp schemas=DEV,TIGER,CS,CSF parallel=10 flashback_time=systimestamp

select * from dba_directories


=DEV,TIGER,CS,CSF
