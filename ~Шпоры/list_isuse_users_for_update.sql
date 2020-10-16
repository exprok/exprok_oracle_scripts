select * from adms_vuser where arc_id=0;

select upper(x.user_code) user_code,v.user_name,v.user_password,  v.user_xid, v.user_id, v.user_name,
       rawtohex(UTL_RAW.CAST_TO_RAW(user_password)) r,
       'update adms_vuser v set v.user_password = utl_raw.cast_to_varchar2(hextoraw('''||rawtohex(UTL_RAW.CAST_TO_RAW(user_password))||''')) where user_xid='||v.user_xid||' and user_id='||v.user_id||' and arc_id=0;' line
              from adms_vuser v,adms_xuser x
              where   v.user_id=x.user_id
                and v.arc_id=0
                and x.user_code != 'TECH_RECORD'
