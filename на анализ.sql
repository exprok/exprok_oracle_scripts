select 'analyze table parus.'||t.table_name||' compute statistics;' /*, t.num_rows,  t.blocks,  to_char(t.last_analyzed,'DD:MM:YYYY') rr*/ from dba_tables t 
where  t.owner = 'PARUS' and t.num_rows is not null and to_char(t.last_analyzed,'DD:MM:YYYY')='17:02:2007'
--group by to_char(t.last_analyzed,'DD:MM:YYYY')

--order by to_char(t.last_analyzed,'DD MM YYYY'), t.blocks desc, t.num_rows desc 