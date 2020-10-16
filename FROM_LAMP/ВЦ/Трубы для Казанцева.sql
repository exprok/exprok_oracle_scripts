select rownum "#", v.dce, v.naim_dce, v.rz "��������", v.pr_pg "���� ����", 
       v.kdiz "���.��.���", v.ez "�� (���)",
       round(v.Dlina / v.kdiz / 1000, 3) "L1, ��" ,
       CASE v.ez 
          WHEN '��' then round(v.NRM * KF, 3)
          else NULL
        END "L2, ��",
        '      ' "���� ��� ����������"
FROM (SELECT oo.dce, oo.naim_dce, tr.pr_pg, mn.rz, spr.nn NN12, mn.nn nn8, mn.vz, mn.nrm, mn.kdiz, mn.ez,
             decode(W_Uchet.F_COV_WEB(spr.nn, '��', '��'),'-',null,W_Uchet.F_COV_WEB(spr.nn, '��', '��')) KF,
             d140lamp.f_get_truba_length(oo.dce) Dlina
      FROM w_kts.oo oo, w_kts.mn mn, w_bnh.v_dce_mmb_nz_truba tr, w_sprmat.tb_mat_oldnn oldnn, w_sprmat.tb_mat_spr spr
      WHERE oo.kdce = mn.kdce AND tr.kdce_mmv = oo.kdce AND mn.ez <> '��' AND oldnn.oldnn = mn.nn AND spr.rn = oldnn.material_rn and mn.rz<>'������' and oo.kdce in (select distinct cp.kdce_ch from w_kts.cp cp)) v
      ,w_bnh.v_dce_in_shifr dce_in_shifr
where dce_in_shifr.DCE=v.dce
order by v.pr_pg, v.dce
      