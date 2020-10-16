select p.spid "Thread ID", b.name "Background Process", s.username "User Name", s.osuser "OS
User", s.status "STATUS", s.sid "SID", s.serial# "Serial No.", s.program "OS Program"  , s.MODULE
        from v$process p, v$bgprocess b, v$session s  
        where s.paddr = p.addr 
        and b.paddr(+) = p.addr 
        and p.spid= 7752  -- тут вписать  TID нити

-- TID нити смотреть procecxp.exe на магик в папке c:\tools
