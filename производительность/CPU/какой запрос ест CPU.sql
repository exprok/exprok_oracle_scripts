  select s2.sql_text , s1.SID, s1.USERNAME, s1.TERMINAL
        from v$process p,v$session s1,v$sqlarea s2 
        where p.addr = s1.paddr 
        and s1.SQL_HASH_VALUE = s2.HASH_VALUE  
        and p.spid= 7752 --тут вписать TID 
        ---запрос, который жрёть CPU  
        -- TID смотреть на магике программой c:\tools\procexp.exe
