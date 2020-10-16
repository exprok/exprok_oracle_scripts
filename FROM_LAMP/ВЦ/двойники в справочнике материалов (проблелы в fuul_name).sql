/*with tb_decode as (select upper(trim(name_full)) name
      from w_sprmat.tb_mat_spr)*/
select t.nn, t.name_full, t.fact_who
from w_sprmat.tb_mat_spr t 
where upper(trim(t.name_full)) in
     (select upper(trim(t.name_full))
      from w_sprmat.tb_mat_spr t
      group by upper(trim(t.name_full))
      having count(*)>1
     )
order by 2,1