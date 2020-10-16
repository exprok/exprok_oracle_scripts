
select a.tablespace_name, SIZEGB, USAGEGB, (SIZEGB - USAGEGB) FREEGB
  from (select round(sum(bytes) / 1024 / 1024 /1024) SIZEGB, b.tablespace_name
          from dba_data_files a, dba_tablespaces b
         where a.tablespace_name = b.tablespace_name
           and b.contents = 'UNDO'
         group by b.tablespace_name) a,
       (select c.tablespace_name, round(sum(bytes) / 1024 / 1024 /1024) USAGEGB
          from DBA_UNDO_EXTENTS c
         where status <> 'EXPIRED'
         group by c.tablespace_name) b
 where a.tablespace_name = b.tablespace_name;
