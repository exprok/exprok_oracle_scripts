select 'alter user "'|| q.username||'" QUOTA '||max_blocks*8192/(1024*1024)||'M ON ' ||tablespace_name||';' 
  from dba_ts_quotas q
 where tablespace_name in ('MATERIAL', 'TS_INDEX', 'TS_LOB', 'TS_NOTLOG')
   and max_blocks not in (0,-1) and username like 'W%`_%' escape '`'
union
select 'alter user "'|| q.username||'" QUOTA UNLIMITED ON ' ||tablespace_name||';' 
  from dba_ts_quotas q
 where tablespace_name in ('MATERIAL', 'TS_INDEX', 'TS_LOB', 'TS_NOTLOG')
   and max_blocks in (-1) and username like 'W%`_%' escape '`'
