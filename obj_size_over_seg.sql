select owner, segment_name, tablespace_name, blocks*8/1024 from dba_segments s 
order by 4 desc
