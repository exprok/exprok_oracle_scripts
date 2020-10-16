select rownum "#", v.dce, v.naim_dce, v.rz "МАТЕРИАЛ", v.pr_pg "Есть План", v.nn12 "NN12 (Парус)", v.KF "KF кг->мп (Парус)", 
       v.kdiz "кол.из.заг", v.ez "ЕИ (ММВ)", v.Dlina "Длина",
       round(v.Dlina / v.kdiz / 1000, 3) "L1, мп" ,
       CASE v.ez 
          WHEN 'КГ' then round(v.NRM * KF, 3)
          else NULL
        END "L2, мп",
        '      ' "Поле для заполнения",
        round((Dlina / v.kdiz / 1000) / KF, 3) "G1=L1/KF, кг", round(v.nrm,3) "НОРМА РАСХОДА", round(v.vz,3) "ВЕС ЗАГОТОВКИ"
FROM (SELECT oo.dce, oo.naim_dce, tr.pr_pg, mn.rz, spr.nn NN12,mn.vz, mn.nrm, mn.kdiz, mn.ez,
             decode(W_Uchet.F_COV_WEB(spr.nn, 'КГ', 'МП'),'-',null,W_Uchet.F_COV_WEB(spr.nn, 'КГ', 'МП')) KF,
             d140lamp.f_get_truba_length(oo.dce) Dlina
      FROM w_kts.oo oo, w_kts.mn mn, w_bnh.v_dce_mmb_nz_truba tr, w_sprmat.tb_mat_oldnn oldnn, w_sprmat.tb_mat_spr spr
      WHERE oo.kdce = mn.kdce AND tr.kdce_mmv = oo.kdce AND mn.ez <> 'МП' AND oldnn.oldnn = mn.nn AND spr.rn = oldnn.material_rn and mn.rz<>'СБОРКА') v
order by v.pr_pg desc, v.dce
      