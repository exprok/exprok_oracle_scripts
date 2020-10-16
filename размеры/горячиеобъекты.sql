select 
tt.*,  pct_to_total_r+pct_to_total_w all_iops from 
(with x as
 (select o.OBJECT_ID,
         o.owner,
         o.object_name,
         o.object_type,
         sum(st.physical_writes_delta) v,
         sum(st.physical_reads_delta) v2,
         s.BYTES,
         s.tablespace_name
  --       st.physical_writes_delta
    from dba_hist_seg_stat st
   inner join dba_objects o
      on (o.OBJECT_ID = st.obj#)
   inner join dba_segments s
      on (s.owner = o.OWNER and s.segment_name = o.OBJECT_NAME)
   where st.snap_id between 716 and 735
   group by o.OBJECT_ID, o.owner, o.object_name, o.object_type, s.BYTES, s.tablespace_name
   order by 5 desc)
select x.object_id,
       x.owner,
       x.object_name,
       x.tablespace_name,
       x.object_type,
       round(100 * ((sum(x.v)
              over(partition by x.owner, x.object_name, x.object_type)) /
             (sum(x.v) over())),3) pct_to_total_w,
       round(100 * ((sum(x.v2)
              over(partition by x.owner, x.object_name, x.object_type)) /
             (sum(x.v2) over())),3) pct_to_total_r,
       round(x.BYTES / (1024 * 1024 * 1024)) g
  from x
  
 order by 5 desc) tt --, dba_objects
 where 
 pct_to_total_r+pct_to_total_w >=0
 and owner not in ('SYS', 'DEV', 'CS')
 and owner like 'PES_TIGER'
 and tablespace_name='TEST_TIGER'
-- and object_type ='TABLE'
 order by 7 desc, 6 desc
 ;
