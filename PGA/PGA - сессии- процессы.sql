
SELECT p.PGA_ALLOC_MEM, S.sid
     , S.username
     , S.machine, S.terminal
     , S.module
     , S.program 
     , P.program, P.pga_used_mem
     , P.pga_alloc_mem, P.pga_max_mem
FROM v$process P
   , v$session S

WHERE p.addr=s.paddr
order by p.PGA_USED_MEM desc
