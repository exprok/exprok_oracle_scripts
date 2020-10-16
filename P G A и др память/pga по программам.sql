SELECT DECODE(GROUPING(s.program),1,'Total session pga memory:',s.program) program, COUNT(*) sessions,
ROUND(SUM(t.VALUE)/(1024 * 1024),1) "Pga(MB)",
ROUND(MAX(t.VALUE)/(1024 * 1024),1) "Pga_max(MB)",
ROUND(SUM(t.VALUE)/(COUNT(*) * 1024 * 1024),1) "Pga_aver(MB)",
ROUND(MIN(t.VALUE)/(1024 * 1024),1) "Pga_min(MB)"
FROM v$session s, v$sesstat t, v$statname n
WHERE n.NAME = 'session pga memory'
AND t.statistic# = n.statistic#
AND t.SID = s.SID
GROUP BY ROLLUP(s.program)
ORDER BY 3 DESC;