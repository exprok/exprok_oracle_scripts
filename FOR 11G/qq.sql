select 'truncate table '||owner||'.'||table_name||';' from dba_tables t where t.logging like '%NO%' and owner like 'W`_%' escape '`'
