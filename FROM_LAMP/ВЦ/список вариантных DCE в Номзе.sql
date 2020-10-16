select vv.dce_variant from 
(
select oo1.dce dce_main, v.dce dce_variant, to_number(substr(v.dce,v.pos+1)) cex
from
    (select oo.dce, instr(oo.dce,'/',-1,1) pos
     from w_kts.n3spr oo
     where instr(oo.dce,'/',-1,1) >0
    ) v, 
    w_kts.oo oo1
where oo1.dce=substr(v.dce,1,v.pos-1) 
      and translate(substr(v.dce,v.pos+1),'0123456789','++++++++++') in ('+','++','+++')
) vv,
(SELECT DISTINCT cex
  FROM (SELECT pol cex
           FROM w_kts.n3nom
         UNION ALL
         SELECT isg cex FROM w_kts.n3nom)
intersect
select distinct mo.cex
from w_kts.mo mo
) v_cex
where translate(v_cex.cex,'0123456789','++++++++++') in ('+','++','+++') and vv.cex=v_cex.cex
minus select oo2.dce from w_kts.oo oo2
