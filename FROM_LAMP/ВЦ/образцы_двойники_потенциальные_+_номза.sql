SELECT *
  FROM (SELECT o1.dce DCE_�������,
                nvl((SELECT '+' FROM w_kts.n3spr ss WHERE ss.dce = o1.dce),
                     '-') "�����", o1.naim_dce Naim_�������, o2.dce DCE_����,
                o3.dce "DCE_����_2-�_����������",
                w_webkts.fn_mo_long(o1.kdce) mmv_mo
           FROM w_kts.oo o1, w_kts.oo o2, w_kts.cp cp1, w_kts.oo o3,
                w_kts.cp cp2,
                (SELECT kdce_ch kdce
                    FROM (SELECT cp.kdce_ch, cp.kdce_k
                             FROM w_kts.oo o, w_kts.cp cp
                            WHERE o.spr = '9'
                              AND o.kdce = cp.kdce_ch)
                   GROUP BY kdce_ch
                  HAVING COUNT(*) > 1) v
          WHERE o1.kdce = v.kdce
            AND v.kdce = cp1.kdce_ch
            AND cp1.kdce_k = o2.kdce
            AND o2.kdce = cp2.kdce_ch
            AND cp2.kdce_k = o3.kdce) v
 WHERE v.mmv_mo not LIKE '%�/�%'
    and v.mmv_mo not LIKE '%���%'
 ORDER BY 2, 1, 4,5