declare
  ret integer;
begin
  ret := dbms_spm.alter_sql_plan_baseline
       (plan_name=>'SQL_PLAN_4tvwr96pc5r15ecfb2e27', 
        attribute_name=>'ENABLED',  
        attribute_value=>'NO') ;
end;
