SELECT oo.dce, oo.vi, mn.viz, mmo.vo, mn.rz, w_webkts.fn_mo_long(oo.kdce)
FROM w_kts.mn mn, w_kts.oo oo,
     (select mo.kdce, mo.vo
      from w_kts.mo mo
      WHERE mo.cex = '004' AND (mo.vo in ('ÐÅÇ','ÃÇÐ','ÐÇÃ'))) mmo
where mn.kdce = oo.kdce and oo.kdce=mmo.kdce
  and mn.viz IN ('31', '41', '37')
order by mmo.vo, oo.dce