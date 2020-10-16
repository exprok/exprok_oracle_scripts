WITH
-- global lock view
gl AS
 (select inst_id || '-' || sid instsid,
         id1,
         id2,
         ctime,
         lmode,
         block,
         request
    from gv$lock),
-- joins the global lock view on itself to identify locks
l AS
 (SELECT l1.instsid holding_session, l2.instsid waiting_session
    FROM gl l1, gl l2
   WHERE l1.block > 0
     AND l2.request > 0
     AND l1.id1 = l2.id1
     AND l1.id2 = l2.id2)
-- result view (tree of locked sessions)
          (SELECT '-' holding_session, holding_session waiting_session
             FROM l
           MINUS
           SELECT '-', waiting_session
             FROM l) UNION ALL
         -- second insert as in utllockt
          SELECT holding_session, waiting_session FROM l

