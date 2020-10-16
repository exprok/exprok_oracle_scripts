select 'create index dev.'||c.INDEX_NAME||' on dev.'||c.TABLE_NAME||' ('|| listagg(column_name, ',') within group(order by column_position)||') tablespace tiger poarallel 24;'
,c.index_name, c.table_name,
         listagg(column_name, ',') within group(order by column_position) cols, i.index_type
    from dba_ind_columns c 
    right join dba_indexes i on i.owner=c.INDEX_OWNER and i.index_name=c.INDEX_NAME
   where index_owner = 'TIGER' and  c.TABLE_NAME in ('A_SALDO_ABON', 'SHIP', 'CARD_CALC', 'REAL', 'PAY_ABON')
      group by c.index_name, c.table_name, i.index_type
   
   
   
--   a_saldo_abon, ship,card_calc,real,pay_abon
