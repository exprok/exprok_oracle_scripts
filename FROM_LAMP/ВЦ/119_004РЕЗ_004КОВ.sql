SELECT *
  FROM (SELECT W_WebKTS.fn_mo_long(t.kdce) MO, t.*
           FROM w_kts.oo t
          WHERE t.kdce IN (SELECT mo.kdce
                             FROM w_kts.mo mo
                            WHERE mo.cex = '004'
                              AND mo.vo = 'пег')) v
 WHERE v.mo LIKE '%004/пег->004/йнб%'