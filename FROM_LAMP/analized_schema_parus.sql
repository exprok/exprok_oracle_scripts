select *
  from (select t.owner, t.table_name, 'TABLE', t.last_analyzed,t.num_rows as "ROWS"
        from dba_tables t
        where t.temporary='N'
           and t.owner = 'PARUS'
        union all
        select i.owner, i.index_name, 'INDEX', i.last_analyzed, i.leaf_blocks 
        from dba_indexes i
        where i.temporary='N'
           and i.owner = 'PARUS'
        )
 where owner not in ('SYS') and last_analyzed>sysdate-1/2
 order by last_analyzed desc nulls last
