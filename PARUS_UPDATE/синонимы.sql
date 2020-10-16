select 'create or replace synonym ' || t.owner || '.' || t.synonym_name ||
       ' for ' || t.table_owner || '.' || T.table_name || ';'
  from dba_synonyms t
 where t.table_owner = 'PARUS'
   and t.owner != 'PUBLIC'
union all
select 'create or replace public synonym ' || t.synonym_name ||
       ' for ' || t.table_owner || '.' || T.table_name || ';'
  from dba_synonyms t
 where t.table_owner = 'PARUS'
   and t.owner = 'PUBLIC'
    
