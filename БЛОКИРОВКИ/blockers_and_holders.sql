select s.BLOCKING_SESSION, s.* from v$session s where s.BLOCKING_SESSIOn is not null
union select 0, ss.* from v$session ss where sid in (select BLOCKING_SESSION from v$session where BLOCKING_SESSIOn is not null)
