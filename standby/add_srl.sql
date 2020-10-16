select 'alter database add stanby logfile thread ' || l.THREAD# ||
       ' group ' || l.GROUP# || ' ''+REDO1/epr/srl' || l.THREAD# ||
       to_char(l.GROUP#, '00') || ''
  from v$logfile lf, v$log l
 where l.GROUP# = lf.GROUP#
