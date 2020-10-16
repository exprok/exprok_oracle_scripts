select account_per_id,
       case calc_session_type when    0 then case calc_type when 0 then '������' else '���' end else '�����' end calc_type,
       min(calc_session_date_b) date_begin,
       max(calc_session_date_e) date_end,
       round((max(calc_session_date_e) - min(calc_session_date_b))*24,1) hours,
       sum(actual_point_calculated),
       --trunc(calc_session_date_b,'HH24')
       round(sum (actual_point_calculated)/(max(calc_session_date_e)- min(calc_session_date_b))/24 /3600, 2) speed,
       count(*) streams
 from calc_session where calc_type = 0
-- where arc_id = 0
 having
         sum(actual_point_calculated) is not null and sum(actual_point_calculated) !=0 and
         min(calc_session_date_b) > to_date('01.01.2015', 'DD.MM.YYYY')
 group by account_per_id, calc_session_type, calc_type, trunc(calc_session_date_b,'DD' )
 order by account_per_id desc , trunc(calc_session_date_b, 'DD') desc; 
