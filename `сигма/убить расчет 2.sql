SELECT 'ALTER SYSTEM KILL SESSION ''' || S.SID || ',' ||
                     S.SERIAL# || ', @' || S.INST_ID || ''' IMMEDIATE;' AS KILL_SESSION
                FROM GV$SESSION S
               WHERE UPPER(ACTION) LIKE '%CALC%STREAM%'
