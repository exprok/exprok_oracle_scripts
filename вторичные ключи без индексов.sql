select cons.table_name, cons.column_name, ind.TABLE_NAME, ind.column_name
  from (select c.owner, c.table_name, c.column_name, c.constraint_name  
          from DBA_CONS_COLUMNS c
         where c.owner = 'PARUS'
           and c.constraint_name in
               (select cc.constraint_name
                  from dba_constraints cc
                 where cc.constraint_type = 'R'
                   and cc.owner = 'PARUS')) cons,
       
       (select i.TABLE_OWNER, i.TABLE_NAME, i.INDEX_NAME, i.COLUMN_NAME
          from dba_ind_columns i
         where table_owner = 'PARUS'
         and i.COLUMN_POSITION=1) ind
         where cons.table_name = ind.table_name(+)
         and cons.column_name = ind.column_name(+)
         order by 4  nulls first, 1,2
