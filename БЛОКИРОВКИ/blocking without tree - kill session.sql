 WITH
    -- global lock view
    gl AS
     (select lo.inst_id || '-' || lo.sid || '-' || se.SERIAL# instsid, se.MODULE, se.ACTION, se.USERNAME,
             'alter system kill session ''' || lo.sid || ',' || se.SERIAL# || ',@' ||
             lo.INST_ID || ''';' oper_,
             id1,
             id2,
             ctime,
             lmode,
             block,
             request
        from gv$lock lo, gv$session se
       where se.INST_ID = lo.INST_ID
         and lo.SID = se.SID),
    -- joins the global lock view on itself to identify locks
    l AS
     (SELECT l1.instsid holding_session,
             l2.instsid waiting_session,
             l1.oper_   oper, l1.module,l1.action,l1.username
        FROM gl l1, gl l2
       WHERE l1.block > 0
         AND l2.request > 0
         AND l1.id1 = l2.id1
         AND l1.id2 = l2.id2)
    -- result view (tree of locked sessions)
     (SELECT '-' holding_session, holding_session waiting_session, oper, module, action, username
        FROM l
      MINUS
      SELECT '-', waiting_session, oper, module, action, username
        FROM l) UNION ALL
    -- second insert as in utllockt
    SELECT holding_session, waiting_session, oper, module, action, username FROM l
