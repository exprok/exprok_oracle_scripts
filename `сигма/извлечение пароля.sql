declare
    v_user_passw adms_vuser.user_password%TYPE;
begin
  for lst in (select upper(x.user_code) user_code,v.user_name,v.user_password
              from adms_vuser v,adms_xuser x
              where   v.user_id=x.user_id
                and v.arc_id=0 and upper(x.user_code) like '%ADM%') ---правило для поиска польз
                loop
                begin
    v_user_passw:=replace(dbms_obfuscation_toolkit.DES3Decrypt(input_string=>lst.user_password, key_string=>'rctybz1234567890'),'-');
    exception
     when others then v_user_passw:='';
     end;
    dbms_output.put_line(lst.user_code||'|'||lst.user_name||'|'||v_user_passw);
  end loop;
end;


--k6n6686o
