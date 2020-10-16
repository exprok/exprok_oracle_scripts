select * from v$archive_dest_status;

LOG_ARCHIVE_DEST_2
alter system set LOG_ARCHIVE_DEST_state_2=defer scope=memory;
alter system set LOG_ARCHIVE_DEST_state_2=enable scope=memory;
alter system archive log current;

LOG_ARCHIVE_DEST_3
alter system set LOG_ARCHIVE_DEST_state_3=defer scope=memory;
alter system set LOG_ARCHIVE_DEST_state_3=enable scope=memory;
alter system archive log current;

LOG_ARCHIVE_DEST_4
alter system set LOG_ARCHIVE_DEST_state_4=defer scope=memory;
alter system set LOG_ARCHIVE_DEST_state_4=enable scope=memory;

-- Get min SCN on standby
select 'select scn_to_timestamp('||min(fhscn)||') from dual;' line from x$kcvfh;
select scn_to_timestamp(537573552355) from dual;
select dbms_flashback.get_system_change_number scn from dual;

-- Convert scn <> time on primary
select timestamp_to_scn(to_date('27.11.2016 18:20:00', 'DD.MM.YYYY HH24:MI:SS')) s from dual;
select scn_to_timestamp(512742710109) from dual;
select systimestamp from dual;
thread 2 sequence 53657
select * from v$log_history lh where lh.SEQUENCE# = 53657 and lh.THREAD# = 2;

-- Restore on primary:
run {
 allocate channel c0 type disk;
 allocate channel c1 type disk;
 allocate channel c2 type disk;
 allocate channel c3 type disk;
 allocate channel c4 type disk;
 allocate channel c5 type disk;
 allocate channel c6 type disk;
 restore archivelog from scn 554485176090 until scn 555334330612;
}

-- 514894646069 514894646069
select least(514894646069, 514894646069) from dual;

-- Reset corrupted SRLs
select 'alter database clear logfile group '||sl.GROUP#||';' l from v$standby_log sl;

select * from v$archived_log al
  where al.NEXT_CHANGE# > 515258492442 and  al.DEST_ID=1
  order by al.COMPLETION_TIME;

-- Archived log backupset size
select * from v$backup_archivelog_summary;
select * from v$backup_archivelog_details ad where ad.NEXT_CHANGE# > 524005067333 order by ad.FIRST_CHANGE# desc;
select * -- sum(bytes)/(1024*1024*1024) gb
  from v$backup_piece_details where tag like '%_AL_%' and deleted='NO' order by completion_time desc;

select /*+ RULE */ distinct(replace(bp.HANDLE, '/nfs/backup/SIGMA/rman', '.')) piece
  from v$backup_piece_details bp, v$backup_archivelog_details ad
  where ad.NEXT_CHANGE# > 554485176090 and ad.BTYPE_KEY = bp.BS_KEY and  bp.DELETED='NO';

-- AL backup files
select * from v$backup_files fs where fs.fname like '%al%';  

-- Cumulative AL size by thread
select (sum(blocks*block_size)
         OVER(partition by thread# 
              order by al.completion_time desc
              range between unbounded preceding and current row
             ))/(1024*1024*1024) gbs_by_thr,
       (sum(blocks*block_size)
         OVER(ORDER BY al.COMPLETION_TIME desc RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))/(1024*1024*1024) gbs,
       al.* from v$archived_log al 
  where al.NEXT_CHANGE# > 555186992007 and al.DEST_ID=1 and al.name is null 
  order by al.COMPLETION_TIME desc;

restore archivelog from sequence 3803 thread 1 until sequence 3888 thread 1;
alter system archive log current;

-- Enough room on standby? Restore archivelog on standby after copy and catalog
run {
 allocate channel c0 type disk;
 allocate channel c1 type disk;
 allocate channel c2 type disk;
 allocate channel c3 type disk;
 allocate channel c4 type disk;
 restore archivelog from scn 537890552817 until scn 537993937365;
}

sql "alter database recover managed standby database disconnect";

-- Not enough room on standby. Restore & recover, use temp area.
run {
 allocate channel c0 type disk;
 allocate channel c1 type disk;
 allocate channel c2 type disk;
 allocate channel c3 type disk;
 allocate channel c4 type disk;
 set archivelog destination to '/u02/oradata/arch/';
 recover database until scn 524075800406 parallel 4 delete archivelog maxsize 64G;
}

select * from gv$session_longops sl where sl.OPNAME like 'RMAN%' order by sl.START_TIME desc;

select distinct 'alter database clear logfile group '||group#||';' l from
 (select group# from v$log union all select group# from v$standby_log);

select 'alter database drop logfile group '||group#||';' l from v$standby_log; 
