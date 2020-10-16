CREATE TYPE xx_pass_row AS OBJECT (
  
  description_  VARCHAR2(50),
  username varchar2(50),
  passwd varchar2(50)
);
  

create type xx_pass_tab is table of xx_pass_row;

CREATE OR REPLACE FUNCTION xx_get_passw 
declare
    v_user_passw adms_vuser.user_password%TYPE;
begin
  for lst in (select upper(x.user_code) user_code,v.user_name,v.user_password
              from adms_vuser v,adms_xuser x
              where   v.user_id=x.user_id
                and v.arc_id=0 and upper(x.user_code) like '%%') ---правило для поиска польз
                loop
                begin
    v_user_passw:=replace(dbms_obfuscation_toolkit.DES3Decrypt(input_string=>lst.user_password, key_string=>'rctybz1234567890'),'-');
    exception
     when others then v_user_passw:='';
     end;
      pipe row (xx_pass_row(lst.user_name,lst.user_code,v_user_passw))k 
      
      --(||'|'||||'|'||);
  end loop;
  RETURN;
end;
