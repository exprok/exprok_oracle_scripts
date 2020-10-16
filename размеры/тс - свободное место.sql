select m.TABLESPACE_NAME name, round(m.USED_SPACE*8192/(1024*1024*1024)) used, round((m.TABLESPACE_SIZE-m.USED_SPACE)*8192/(1024*1024*1024)) free from dba_tablespace_usage_metrics m
