строчка для ошибки create or replace procedure delete_data_pointabon(p_pointabon_Id in number) is
v_rowcnt number;
begin
  

      loop
          delete  from a_saldo_abon sa 
             where sa.is_opening_saldo=0 and sa.arc_id!=0
              and sa.pointabon_id=p_pointabon_Id
              and rownum<=1000;
        v_rowcnt:=(SQL%ROWCOUNT);
        Commit;
        exit when (v_rowcnt=0);
      end loop;
      loop
         delete from real r
            where arc_id!=0 
              and ship_id in (select ship_id from ship s,a_vpointabon avp
                                where s.ship_is_actual=0 and s.arc_id!=0 
                                  and avp.pointabon_xid=s.pointabon_xid
                                  and avp.pointabon_id=p_pointabon_Id
                                 )
              and rownum <1000;
        v_rowcnt:=(SQL%ROWCOUNT);
        Commit;
        exit when (v_rowcnt=0);
      end loop; 
      loop
         delete from real r
            where arc_id!=0 
              and saldo_ship_id in (select ship_id from ship s,a_vpointabon avp
                                      where s.ship_is_actual=0 and s.arc_id!=0 
                                        and avp.pointabon_xid=s.pointabon_xid
                                        and avp.pointabon_id=p_pointabon_Id
                                        )
              and rownum <1000;
        v_rowcnt:=(SQL%ROWCOUNT);
        Commit;
        exit when (v_rowcnt=0);
      end loop; 
        loop
           delete from real r
              where arc_id!=0 
                and r.real_per_unlink=0
                and POINTABON_XID in (select POINTABON_XID from a_vpointabon avp
                                       where avp.pointabon_id=p_pointabon_Id
                                      )
                and rownum <1000;
          v_rowcnt:=(SQL%ROWCOUNT);
          Commit;
          exit when (v_rowcnt=0);
        end loop;  
        loop
           delete from real r
              where arc_id!=0 
                and r.real_per_unlink=r.real_per_link
                and POINTABON_XID in (select POINTABON_XID from a_vpointabon avp
                                       where avp.pointabon_id=p_pointabon_Id
                                       )
                and rownum <1000;
          v_rowcnt:=(SQL%ROWCOUNT);
          Commit;
          exit when (v_rowcnt=0);
        end loop;
      
            loop
                delete from ship s
                  where ship_is_actual=0 and SHIP_POINT_ID is not null 
                  and not exists (select 1 from real d where d.saldo_ship_id=s.ship_id)
                  and not exists (select 1 from real d where d.ship_id=s.ship_id)
                  and not exists (select 1 from ship ss where ss.SHIP_POINT_ID=s.ship_id)
                  and POINTABON_XID in (select POINTABON_XID from a_vpointabon avp
                                           where avp.pointabon_id=p_pointabon_Id
                                      )
                  and rownum<=1000;
              v_rowcnt:=(SQL%ROWCOUNT);
              Commit;
              exit when (v_rowcnt=0);
            end loop; 
            loop
                delete from ship s
                  where arc_id!=0  
                    and ship_is_actual=0
                    and SHIP_POINT_ID is null
                    and not exists (select 1 from real d where d.ship_id=s.ship_id)
                    and not exists (select 1 from real d where d.saldo_ship_id=s.ship_id)
                    and not exists (select 1 from ship ss where ss.SHIP_POINT_ID=s.ship_id)
                    and POINTABON_XID in (select POINTABON_XID from a_vpointabon avp
                                             where avp.pointabon_id=p_pointabon_Id
                                             )
                    and rownum<=1000;
              v_rowcnt:=(SQL%ROWCOUNT);
              Commit;
              exit when (v_rowcnt=0);
            end loop; 
             ----!!!!card_card  
            loop
                delete from card_calc c
                    where not exists (select 1 from ship s,a_vpointabon avp
                                        where  c.card_calc_id=s.card_calc_id
                                        and avp.pointabon_xid=s.pointabon_xid
                                        and avp.pointabon_id=p_pointabon_Id                           )
                    and is_actual=0
                    and arc_id!=0
                    and point_id in (select point_id from p_vpoint where pointabon_id=p_pointabon_Id                  )
                    and rownum <1000;
                v_rowcnt:=(SQL%ROWCOUNT);
              Commit;
              exit when (v_rowcnt=0);
            end loop;
   

end delete_data_pointabon;
/
declare
  N_stream     number := 30;
  v_range_max    number;
  v_range_min    number;
  v_range_cnt    number;
  v_range_b      number;
  v_range_e      number;  
  v_job_action_str varchar2(4000);
  v_pipe_name            varchar2(50) default 'DEL_CALC_ABONS';
begin
  
  Select MIN(ap.pointabon_id), MAX(ap.pointabon_id)
    Into v_range_min, v_range_max
    From a_xpointabon  ap
   Where ap.pointabon_id!=0;
   
  v_range_cnt := trunc((v_range_max - v_range_min)/N_stream);


  for i in 1..N_stream loop
    begin
      v_range_b := v_range_min + v_range_cnt*(i-1);
      v_range_e := v_range_min + (v_range_cnt*i)-1;
      if i = N_stream then
        v_range_e := v_range_max;
      end if;

      v_job_action_str := 
        'DECLARE
            old_group varchar2(30);
            v_rowcnt number;
            cnt_calc number := 0;  
            rindex                 BINARY_INTEGER:=0;
            slno                   BINARY_INTEGER;
             begin
                DBMS_SESSION.SWITCH_CURRENT_CONSUMER_GROUP(''batch'', old_group, FALSE);
                 begin
               rindex := dbms_application_info.set_session_longops_nohint;
             exception
               when others then
                    null;
             end;
            for lst in (select pointabon_Id from a_xpointabon  where pointabon_id between '||v_range_b||' and '||v_range_e||')loop
                delete_data_pointabon(lst.pointabon_Id);
                cnt_calc:=cnt_calc+1;
                  begin
                   dbms_application_info.set_session_longops(rindex, slno,
                  ''DEL_CALC_ABONS'', null, 0, cnt_calc, '||v_range_cnt||');
                exception
                   when others then
                        null;
                end;
            end loop;
         end;';

      DBMS_SCHEDULER.CREATE_JOB
           (job_name        => 'job_clear_'||i||''
           ,start_date      => NULL  
           ,repeat_interval => NULL
           ,end_date        => NULL
           ,job_class       => 'DEFAULT_JOB_CLASS'
           ,job_type        => 'PLSQL_BLOCK'
           ,job_action      => v_job_action_str
           ,enabled         =>true
           ,AUTO_DROP       =>true);
    end;
  end loop;
  
end;
/
