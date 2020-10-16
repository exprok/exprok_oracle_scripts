select --+ RULE
*
from (
select vv.*, 
       case when "L2, мп" is not null and ("L2, мп"/decode("L1, мп",0,0.0000000001,null,0.0000000001,"L1, мп") between 1 and 1.25) then round("L2, мп"/"L1, мп",2)
            else null 
       end "L2/L1"
from (
select v.dce, v.naim_dce, v.rz "МАТЕРИАЛ", 
       v.kdiz "кол.из.заг", v.ez "ЕИ (ММВ)",
       round(v.Dlina / v.kdiz / 1000, 3) "L1, мп" ,
       CASE v.ez 
          WHEN 'КГ' then round(v.NRM * KF, 3)
          else NULL
        END "L2, мп"
--        ,'      ' "Поле для заполнения"
FROM (SELECT oo.dce, oo.naim_dce, mn.rz, spr.nn NN12, mn.nn nn8, mn.vz, mn.nrm, mn.kdiz, mn.ez,
             decode(W_Uchet.F_COV_WEB(spr.nn, 'КГ', 'МП'),'-',null,W_Uchet.F_COV_WEB(spr.nn, 'КГ', 'МП')) KF,
             d140lamp.f_get_truba_length(oo.dce) Dlina
      FROM w_kts.oo oo, w_kts.mn mn, w_sprmat.tb_mat_oldnn oldnn, w_sprmat.tb_mat_spr spr
      WHERE oo.kdce = mn.kdce AND mn.ez <> 'МП' AND oldnn.oldnn = mn.nn AND spr.rn = oldnn.material_rn and mn.rz<>'СБОРКА') v
/*      ,w_bnh.v_dce_in_shifr dce_in_shifr
where dce_in_shifr.DCE=v.dce
*/
) vv
)vvv

where "L2/L1" is not null
order by dce

