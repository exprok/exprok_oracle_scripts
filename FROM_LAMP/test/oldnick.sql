select count(*)
from 
(select -- + USE_HASH(tb_audi, tb_mo)
       KDCE,
       NMP,
       CEX,
       VO,
       TD
from d140znn.tb_AUDI, d140znn.TB_MO
where TB_MO.att_arid=tb_AUDI.att_arid
and tb_AUDI.att_ardis IS NULL
and tb_AUDI.att_arver=0
and tb_AUDI.att_arstart<=SysDate
and tb_AUDI.att_arend>SysDate
) mo
where mo.CEX='015'
