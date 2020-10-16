SELECT vv.*, s.dce, s.naim
  FROM (SELECT v.kdce, COUNT(*) count_KPP
           FROM (SELECT DISTINCT n.kdce, n.zak FROM w_kts.n3pri n) v
          GROUP BY v.kdce) vv, w_kts.n3spr s
 WHERE vv.kdce = s.kdce
 order by 2 desc