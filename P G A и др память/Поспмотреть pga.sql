select name, to_char(sum(value),'0G999G999G999') from (
select a.name, b.value from v$statname a, v$SESSTAT b
WHERE A.STATISTIC#=B.STATISTIC# AND A.NAME LIKE 'session %memory%'
) group by name