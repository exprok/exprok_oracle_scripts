SELECT   DECODE (LOB.kglobtyp,
                 0, 'NEXT OBJECT',
                 1, 'INDEX',
                 2, 'TABLE',
                 3, 'CLUSTER',
                 4, 'VIEW',
                 5, 'SYNONYM',
                 6, 'SEQUENCE',
                 7, 'PROCEDURE',
                 8, 'FUNCTION',
                 9, 'PACKAGE',
                 11, 'PACKAGE BODY',
                 12, 'TRIGGER',
                 13, 'TYPE',
                 14, 'TYPE BODY',
                 19, 'TABLE PARTITION',
                 20, 'INDEX PARTITION',
                 21, 'LOB',
                 22, 'LIBRARY',
                 23, 'DIRECTORY',
                 24, 'QUEUE',
                 28, 'JAVA SOURCE',
                 29, 'JAVA CLASS',
                 30, 'JAVA RESOURCE',
                 32, 'INDEXTYPE',
                 33, 'OPERATOR',
                 34, 'TABLE SUBPARTITION',
                 35, 'INDEX SUBPARTITION',
                 40, 'LOB PARTITION',
                 41, 'LOB SUBPARTITION',
                 42, 'MATERIALIZED VIEW',
                 43, 'DIMENSION',
                 44, 'CONTEXT',
                 46, 'RULE SET',
                 47, 'RESOURCE PLAN',
                 48, 'CONSUMER GROUP',
                 51, 'SUBSCRIPTION',
                 52, 'LOCATION',
                 55, 'XML SCHEMA',
                 56, 'JAVA DATA',
                 57, 'SECURITY PROFILE',
                 59, 'RULE',
                 62, 'EVALUATION CONTEXT',
                 'UNDEFINED'
                ) object_type,
         LOB.kglnaobj object_name, pn.kglpnmod lock_mode_held, pn.kglpnreq lock_mode_requested, ses.SID,
         ses.serial#, ses.username, ses.osuser, ses.machine, ses.program, ses.module
    FROM x$kglpn pn,
         v$session ses,
         x$kglob LOB,
         v$session_wait vsw
         
 --   where upper(LOB.kglnaobj
   WHERE pn.kglpnuse = ses.saddr
        AND pn.kglpnhdl = LOB.kglhdadr
       and upper(LOB.kglnaobj)='PK_VALUES'
   --   vsw.event = 'library cache pin'
ORDER BY lock_mode_held DESC   w_otk.p_sravn_baz