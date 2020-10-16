select myt.*, 'alter index tiger.'||segment_name||' rebuild tablespace TIGER_SLOW parallel 8;' from (select t3.object_name,
       t3.all_iops,
       t3.g,
       tt.segment_name,
       round(tt.bytes / (1024 * 1024)) bytes,
       tt.segment_type,
       tt.owner,
       tt.tablespace_name
       
  from t3 t3, dba_segments tt
 where --t3.object_type = 'TABLE'
   --and tt.OWNER = 'TIGER'
    tt.segment_name = t3.object_name(+)) myt
    where segment_type='INDEX'
    and owner='TIGER'
    and (all_iops=0 or all_iops is null)
    and tablespace_name='TIGER'
    order by all_iops desc nulls last, bytes desc
