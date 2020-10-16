select 'alter index w_kts.'||i.index_name||' rebuild online;' from dba_indexes i where i.owner='W_KTS'
