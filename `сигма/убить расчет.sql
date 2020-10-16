select 'alter system kill session '''||s.SID||','||s.SERIAL#||''';'   from v$session s where s.ACTION like '%CALC%'
