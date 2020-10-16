select s.owner, s.segment_type, count(*), sum(s.blocks)*8/1024 MB
from dba_segments s
where s.tablespace_name='TSSMALLTASK'
group by s.owner, s.segment_type