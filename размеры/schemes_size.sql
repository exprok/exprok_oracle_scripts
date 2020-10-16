select owner, s.tablespace_name, round(sum(s.BYTES)/(1024*1024*1024)) size_ from dba_segments s group by s.owner, s.tablespace_name order by sum(s.BYTES) desc
