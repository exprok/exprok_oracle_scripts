select --+ RULE
*
from (
select vv.*, 
       case when "L2, ��" is not null and ("L2, ��"/decode("L1, ��",0,0.0000000001,null,0.0000000001,"L1, ��") between 1 and 1.25) then round("L2, ��"/"L1, ��",2)
            else null 
       end "L2/L1"
from (
select v.dce, v.naim_dce, v.rz "��������", 
       v.kdiz "���.��.���", v.ez "�� (���)",
       round(v.Dlina / v.kdiz / 1000, 3) "L1, ��" ,
       CASE v.ez 
          WHEN '��' then round(v.NRM * KF, 3)
          else NULL
        END "L2, ��"
--        ,'      ' "���� ��� ����������"
FROM (SELECT oo.dce, oo.naim_dce, mn.rz, spr.nn NN12, mn.nn nn8, mn.vz, mn.nrm, mn.kdiz, mn.ez,
             decode(W_Uchet.F_COV_WEB(spr.nn, '��', '��'),'-',null,W_Uchet.F_COV_WEB(spr.nn, '��', '��')) KF,
             d140lamp.f_get_truba_length(oo.dce) Dlina
      FROM w_kts.oo oo, w_kts.mn mn, w_sprmat.tb_mat_oldnn oldnn, w_sprmat.tb_mat_spr spr
      WHERE oo.kdce = mn.kdce AND mn.ez <> '��' AND oldnn.oldnn = mn.nn AND spr.rn = oldnn.material_rn and mn.rz<>'������') v
/*      ,w_bnh.v_dce_in_shifr dce_in_shifr
where dce_in_shifr.DCE=v.dce
*/
) vv
)vvv

where "L2/L1" is not null
order by dce

