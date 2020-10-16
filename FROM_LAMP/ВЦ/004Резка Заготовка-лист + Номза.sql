create or replace view d140lamp.Rezka004_gorbunovu as 
SELECT oo.kdce, oo.dce, mn.viz, mmo.vo, mn.rz,
       nvl((SELECT '+' FROM w_kts.n3spr ss WHERE ss.dce = oo.dce), '-') "Íîìçà",
       (SELECT DISTINCT ceil(potr.potg) --, nom.bng
           FROM W_KTS.N3SPR spr, w_uchet.n3potr potr
          WHERE spr.kdce = potr.kdce
            AND potr.isg = '004'
            AND potr.pol = '000'
            AND spr.dce = oo.dce) "Ïëàí ãîäà",
       (SELECT SUM(nom.bng)
           FROM W_KTS.N3SPR spr, w_kts.n3nom nom
          WHERE spr.kdce = nom.kdce
            AND nom.isg = '004'
            AND nom.mu = '1'
            AND spr.dce = oo.dce) "Ñîñòîÿíèå",
       substr(replace(w_webkts.fn_mo_long(oo.kdce),'ÑÊË/ÕÐÍ->'),1,34) "ÌÎ_ÌÌÂ",
       substr(w_webkts.FN_MO_nomza_Long((SELECT spr.kdce
                                    FROM w_kts.n3spr spr
                                   WHERE spr.dce = oo.dce
                                     AND spr.v = oo.vi)),1,13) "ÌÎ_ÍÎÌÇÀ"
  FROM w_kts.mn mn, w_kts.oo oo,
       (SELECT mo.kdce, mo.vo
           FROM w_kts.mo mo
          WHERE mo.cex = '004'
            AND (mo.vo IN ( 'ÐÅÇ'/*,'ÃÇÐ', 'ÐÇÃ'*/))) mmo

 WHERE mn.kdce = oo.kdce
   AND oo.kdce = mmo.kdce
   AND mn.viz IN ('31', '41', '37')

 ORDER BY mmo.vo, oo.dce