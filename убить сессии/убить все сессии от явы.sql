begin

  for op in (SELECT 'ALTER SYSTEM KILL SESSION ''' || S.SID || ',' ||
                    S.SERIAL# || ', @' || S.INST_ID || ''' IMMEDIATE' AS KILL_SESSION
               FROM GV$SESSION S
              WHERE UPPER(MODULE) LIKE '%JDBC T%') loop
              
              dbms_output.put_line('оператор = '||op.kill_session );
              execute immediate op.kill_session;
  
  end loop;
end;
