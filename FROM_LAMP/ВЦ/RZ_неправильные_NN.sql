SELECT v.dce, v.vi, v.spr, v.naim_dce, v.nn, v.ez, v.nrm, v.rz, oo.dce dce_куда
  FROM w_kts.v_oo_mn v, w_kts.cp cp, w_kts.oo oo, w_bnh.v_dce_in_shifr sh
 WHERE v.nn IN ('01111111', '02222222', '03333333', '04444444', '05555555', 
                '06666666', '07777777', '08888888', '09999999', '00000000',
                '11111111', '22222222', '33333333', '44444444', '55555555',
                '66666666', '77777777', '88888888', '99999999')
   and cp.kdce_ch=v.kdce and cp.kdce_k=oo.kdce
   AND v.dce = sh.DCE
   AND v.vi = sh.VI
 ORDER BY nn