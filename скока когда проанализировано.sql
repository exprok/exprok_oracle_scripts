select /*t.table_name, t.num_rows, */ sum(t.blocks), to_char((sum(t.blocks)*8192), '99G999G999G999'), to_char(t.last_analyzed,'DD:MM:YYYY') from dba_tables t 
where  t.owner = 'PARUS' and t.num_rows is not null 
group by to_char(t.last_analyzed,'DD:MM:YYYY')

--order by to_char(t.last_analyzed,'DD MM YYYY'), t.blocks desc, t.num_rows desc 