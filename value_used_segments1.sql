select sum(blocks)*8/1000 from
(select a.segment_name, a.bytes, a.* from user_segments a order by 2 desc)

