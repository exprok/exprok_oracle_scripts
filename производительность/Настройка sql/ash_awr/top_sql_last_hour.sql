 select
     *
  from (
     select
        sql_id,
        count(*) as db_time,
        round(count(*)*100/sum(count(*)) over (), 2) as pct_activity
     from
        gv$active_session_history sh
     where
        sample_time >= sysdate - (1/24)
        and session_type <> 'BACKGROUND'
     group by
        sql_id
     order by

        count(*) desc)

  where
    

     rownum <=5;
