--select * from sys.optstat_hist_control$;
select

 ' exec DBMS_STATS.SET_TABLE_PREFS('''||o.owner||''','''||o.object_name||''',''PUBLISH'', ''TRUE'');', p.*, o.owner, o.object_name
  from sys.optstat_user_prefs$ p, dba_objects o
 where o.object_id = p.obj#
   and o.owner not in ('SYSTEM')
