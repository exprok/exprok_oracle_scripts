
-- Подсчет сожранного в схеме места
select sum(blocks)*8 from
(select a.segment_name, a.bytes, a.* from dba_segments a where a.owner='W_KTS' order by 2 desc)

-- Показ сожранного в схеме места, по объектам, крупные вверху списка
select a.segment_name, a.bytes, a.* from dba_segments a where a.owner='W_KTS' order by 2 desc