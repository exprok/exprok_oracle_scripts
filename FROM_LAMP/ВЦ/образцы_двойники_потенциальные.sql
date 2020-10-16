SELECT o1.dce, o1.spr, o1.naim_dce, o2.dce, o3.dce
  FROM w_kts.oo o1, w_kts.oo o2, w_kts.cp cp1, w_kts.oo o3, w_kts.cp cp2,
       (SELECT kdce_ch kdce
           FROM (SELECT cp.kdce_ch, cp.kdce_k
                    FROM w_kts.oo o, w_kts.cp cp, w_kts.n3spr spr
                   WHERE o.spr = '9'
                     AND o.kdce = cp.kdce_ch and o.dce in spr.dce)
          GROUP BY kdce_ch
         HAVING COUNT(*) > 1) v
 WHERE o1.kdce = v.kdce
   AND v.kdce = cp1.kdce_ch
   AND cp1.kdce_k = o2.kdce
   and o2.kdce=cp2.kdce_ch and cp2.kdce_k=o3.kdce