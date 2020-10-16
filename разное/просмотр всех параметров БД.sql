SELECT rownum, a.ksppinm "Parameter", a.ksppdesc "Description",
b.ksppstvl "Session Value",
c.ksppstvl "Instance Value"
FROM x$ksppi a, x$ksppcv b, x$ksppsv c
WHERE a.indx = b.indx AND a.indx = c.indx -- AND upper(a.ksppinm) LIKE '%_LRU%'
order by 2
