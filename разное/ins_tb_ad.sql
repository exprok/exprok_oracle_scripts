begin
   for cu in (select ua.tn, ua.login 
  from w_puz.t_user_ad_dop ua
 where tn is not null
   and ua.inn is not null
   and ua.inn not in (select inn
                        from (select inn, count(2)
                                from w_puz.t_user_ad_dop
                               where inn is not null having count(2) > 1
                               group by inn
                               order by 2 desc))) loop
                               
     NULL;
     begin
         w_ad.p_tb_ad_insert(L_LOGIN => cu.login,L_TAB_NOMER => cu.tn);
         DBMS_OUTPUT.put_line('OKOKOKOK --------- '||cu.login);
     exception
         when others then  
          DBMS_OUTPUT.put_line('-------------------- '||cu.login||'     '||SQLERRM);
     end;    
     end loop;
end;
                               
