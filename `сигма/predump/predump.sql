select distinct owner from dba_segments s where s.tablespace_name  IN ('TIGER', 'DEV') union
select distinct owner from dba_tables t where t.TABLESPACE_NAME IN ('TIGER', 'DEV') union
select distinct owner from dba_indexes i where i.TABLESPACE_NAME IN ('TIGER', 'DEV')

expdp \"/ sys as sysdba\" DIRECTORY=EXP_DIR_OEK DUMPFILE=tiger_cs_oth_predump2_14.06.2020_%U.DMP SCHEMAS=CS,CSF,DEV,MIGR_FL,MIGR_FL1,MIGR_FL2,MIGR_FL3,MIGR_FL_OBL,MIGR_FL_OLD,SCOTT,TIGER CLUSTER=NO parallel=30 flashback_time=systimestamp COMPRESSION=ALL


select * from dba_directories

CS,CSF,DEV,MIGR_FL,MIGR_FL1,MIGR_FL2,MIGR_FL3,MIGR_FL_OBL,MIGR_FL_OLD,SCOTT,TIGER






drop user CSF cascade;
drop user MIGR_FL cascade;
drop user MIGR_FL1 cascade;
drop user MIGR_FL2 cascade;
drop user MIGR_FL3 cascade;
drop user MIGR_FL_OBL cascade;
drop user MIGR_FL_OLD cascade;
drop user SCOTT cascade;
drop user TIGER cascade;
drop user DEV cascade;
drop user CS cascade;







