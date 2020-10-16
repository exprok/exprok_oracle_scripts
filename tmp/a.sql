SELECT  'orakill prog '||p.SPID FROM v$process P
   , v$session S
WHERE p.addr=s.paddr
and pga_alloc_mem >800000000;
