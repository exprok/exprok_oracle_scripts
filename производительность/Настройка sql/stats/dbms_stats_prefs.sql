SELECT 
  DBMS_STATS.get_prefs(pname=>'INCREMENTAL') incremental,
  DBMS_STATS.get_prefs(pname=>'GRANULARITY') granularity,
  DBMS_STATS.get_prefs(pname=>'STALE_PERCENT') publish,
  DBMS_STATS.get_prefs(pname=>'ESTIMATE_PERCENT') estimate_percent,
  DBMS_STATS.get_prefs(pname=>'CASCADE') cascade,
  DBMS_STATS.get_prefs(pname=>'METHOD_OPT') method_opt
FROM dual;
