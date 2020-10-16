select * from dba_extents e 
where e.tablespace_name='TSSMALLTASK'
order by e.block_id desc