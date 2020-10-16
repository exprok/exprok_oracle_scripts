/*
   reqcheck.sql

   PSP_Mail prerequisite packages/Java classes check script
   Copyright(c) 2002,2003 by N-Networks. Written by Bobby Z.

*/
exit 0
set serveroutput on feedback off
WHENEVER SQLERROR EXIT 1
declare
 v      user_objects.object_name%type;
begin

 if USER != 'SYS' then
   dbms_output.put_line('Please run this script as SYS');
   raise_application_error(-20000, 'Wrong user runs the script.');
 end if;
  
 begin
  select object_name into v from user_objects
   where object_type='PACKAGE' 
     and object_name='UTL_SMTP';
 exception
   when no_data_found then
    dbms_output.put_line('Required package not found: UTL_SMTP');
    dbms_output.put_line('Please load this package from [ORACLE_HOME]/rdbms/admin as SYS');
    raise;
 end;
 if TO_NUMBER(SUBSTR('&_O_RELEASE',1,3)) < 902 then
  -- this check is not needed on 9.2+ as UTL_TCP was rewritten to native C
  -- instead of Java and these classes are no longer necessary
  begin
   select object_name into v from user_objects
    where object_type='JAVA CLASS'
      and object_name='oracle/plsql/net/TCPConnection';
  exception
    when no_data_found then
     dbms_output.put_line('Required Java class not found: oracle.plsql.net.TCPConnection');
     dbms_output.put_line('Please loadjava it from [ORACLE_HOME]/plsql/jlib/plsql.jar as SYS');
     raise;
  end;
 end if;
exception
 when no_data_found then
  raise_application_error(-20000, 'Some prerequisites were not satisfied.');
end;
/
exit 0
