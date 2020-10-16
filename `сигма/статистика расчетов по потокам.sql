select cs.account_per_id,
       ct.terra_name,
       ct.terra_id,
       cs.calc_session_date_b date_begin,
       cs.calc_session_date_e date_end,
       round((cs.calc_session_date_e - cs.calc_session_date_b) * 24,2) hours,
       cs.actual_point_calculated,
       round(cs.actual_point_calculated /  (((cs.calc_session_date_e - cs.calc_session_date_b)*24*3600)+0.00001), 2) speed
  from calc_session cs, c_terra ct
 where 
    ct.terra_id=cs.terra_id and
    cs.calc_type <> 1
   and trunc(cs.calc_session_date_b) >= to_date('27.02.2019', 'DD.MM.YYYY')
order by cs.calc_session_date_e  desc nulls last
