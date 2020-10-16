SELECT   s.inst_id,S.sid , S.username, S.osuser, P.spid, S.module,
S.program, round ( SUM (T.blocks) * TBS.block_size / 1024 / 1024 /1024) gb_used, T.tablespace,
COUNT(*) sort_ops
FROM     gv$sort_usage T, gv$session S, dba_tablespaces TBS, gv$process P
WHERE    T.session_addr = S.saddr
AND      S.paddr = P.addr
AND      T.tablespace = TBS.tablespace_name
and t.inst_id=s.inst_id
and t.inst_id=p.inst_id
GROUP BY s.inst_id, s.sid, S.serial#, S.username, S.osuser, P.spid, S.module,
S.program, TBS.block_size, T.tablespace
ORDER BY gb_used desc;
