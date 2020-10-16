select * from dba_extents s
where s.file_id=1 and 51306 between s.block_id and s.block_id+s.blocks-1