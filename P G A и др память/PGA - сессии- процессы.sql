SELECT sum(trunc(p.PGA_ALLOC_MEM/(1024*1024), 1)) "PGA (MB)", 
     0 SID
     , '' USERNAME
     , '' OSUSER
     , '' MACHINE, '' TERMINAL
     , '' MODULE
     , '' PROGRAM
     ,'' P_PROGRAMM, NULL USED
     , NULL ALLOC, NULL MAX
FROM v$process P
   , v$session S

WHERE p.addr=s.paddr
union
SELECT trunc(p.PGA_ALLOC_MEM/(1024*1024), 1) "PGA (MB)", S.sid
     , S.username, s.OSUSER
     , S.machine, S.terminal
     , S.module
     , S.program 
     , P.program, P.pga_used_mem
     , P.pga_alloc_mem, P.pga_max_mem
FROM v$process P
   , v$session S

WHERE p.addr=s.paddr
order by 1 desc
