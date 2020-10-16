select *
  from (select t.owner, t.table_name, 'TABLE', t.last_analyzed,t.num_rows as "ROWS"
        from dba_tables t
        where t.temporary='N'
--           and t.owner = 'D140AGAFONOVA'
        union all
        select i.owner, i.index_name, 'INDEX', i.last_analyzed, i.leaf_blocks 
        from dba_indexes i
        where i.temporary='N'
--           and i.owner = 'D140AGAFONOVA'
        )
 where owner not in ('SYS')
 order by last_analyzed desc nulls last