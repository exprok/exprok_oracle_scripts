select b.tablespace_name,
       b.owner,
       ceil(b.bytes_ / (1024 * 1024)) mb_used,
       ceil(q.max_bytes / (1024 * 1024))mb_quota,
       decode(q.max_bytes,
              -1,
              -1,
              q.max_bytes,
              ceil(b.bytes_ / (q.max_bytes / 100))) as percent_used
  from dba_ts_quotas q,
       (select tablespace_name, owner, sum(bytes) bytes_
          from dba_segments
         where tablespace_name in ('NOTLOG', 'MATERIAL', 'PROK_TEMP')
         group by tablespace_name, owner) b
 where b.owner = q.username
   and b.tablespace_name = q.tablespace_name
   and (b.bytes_ / (q.max_bytes / 100) >=80 or  q.max_blocks=-1)
 order by 1, 2
