SELECT 
DECODE(GROUPING(s.username),1,'Total session pga memory:',s.username) program, COUNT(*) sessions,
ROUND(SUM(t.VALUE)/(1024 * 1024),1) "Pga(MB) всего по польз",
ROUND(MAX(t.VALUE)/(1024 * 1024),1) "Pga_max(MB) из всех сесс",
ROUND(SUM(t.VALUE)/(COUNT(*) * 1024 * 1024),1) "Pga_aver(MB)",
ROUND(MIN(t.VALUE)/(1024 * 1024),1) "Pga_min(MB)"
FROM v$session s, v$sesstat t, v$statname n
WHERE n.NAME = 'session pga memory'
AND t.statistic# = n.statistic#
AND t.SID = s.SID 
GROUP BY ROLLUP(s.username)
ORDER BY 3 DESC;