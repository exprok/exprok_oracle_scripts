select p.spid thread, s.username,
    decode(nvl(p.background,0),1,bg.description,
         s.program ) program,
    ss.value/100 CPU,physical_reads disk_io
 from v$process p,
    v$session s,
    v$sesstat ss,
    v$sess_io si,
    v$bgprocess bg
 where s.paddr=p.addr
  and ss.sid=s.sid
  and ss.statistic#=12 
  and si.sid=s.sid
  and bg.paddr(+)=p.addr
 order by ss.value desc;
