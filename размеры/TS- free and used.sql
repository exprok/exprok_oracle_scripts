select fs.TABLESPACE_NAME ts_name,
       round(fs.BYTES_COALESCED / (1024 * 1024 * 1024)) free_gb,
       round(m.TABLESPACE_SIZE*8192/(1024*1024*1024)) total
  from dba_free_space_coalesced fs, dba_tablespace_usage_metrics m
  where m.TABLESPACE_NAME=fs.TABLESPACE_NAME
  order by 3 desc
