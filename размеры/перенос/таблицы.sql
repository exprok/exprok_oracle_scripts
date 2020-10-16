select * from (select t4.object_name,
       t4.all_iops,
       t4.g,
       tt.segment_name,
       round(tt.bytes / (1024 * 1024)) bytes,
       tt.segment_type,
       tt.owner, 'alter table '||tt.segment_name||'  move tablespace TIGER_SLOW;'
  from t4, dba_segments tt
 where --t3.object_type = 'TABLE'
   --and tt.OWNER = 'TIGER'
    tt.segment_name = t4.object_name(+)) where segment_type='TABLE'
    and owner='TIGER'
    and (all_iops<1 or all_iops is null)
    order by all_iops desc nulls last, bytes desc
