select vv.*, 
       decode((select count(*) from w_kts.oo o where o.dce=vv.dce_stalo and o.vi=vv.vi and rownum<2),1,'+','-') Dvoinik,
       decode((select count(*) from w_kts.n3spr spr where spr.dce=vv.dce and spr.v=vv.vi and rownum<2),1,'+','-') Nomza
from
(SELECT v.dce, v.vi, substr(v.dce,1,a+2)||'.'||substr(v.dce,a+3,2)||'.'||substr(v.dce,a+5) dce_stalo
  FROM (SELECT oo.dce, oo.vi, instr(oo.dce, '.', 1, 2) b, instr(oo.dce, '.', 1, 1) a
           FROM w_kts.oo oo
          WHERE oo.dce LIKE '9Â819%'
             OR oo.dce LIKE '9Â844%') v
 WHERE b < a
intersect
 SELECT v.dce, v.vi, substr(v.dce,1,a+2)||'.'||substr(v.dce,a+3,2)||'.'||substr(v.dce,a+5)
  FROM (SELECT oo.dce, oo.vi, instr(oo.dce, '.', 1, 2) b, instr(oo.dce, '.', 1, 1) a
           FROM w_kts.oo oo
          WHERE oo.dce LIKE '9Â819%'
             OR oo.dce LIKE '9Â844%') v
 WHERE b < a and translate(substr(v.dce,a+1,7),'0123456789','++++++++++') = ('+++++++')
 )vv