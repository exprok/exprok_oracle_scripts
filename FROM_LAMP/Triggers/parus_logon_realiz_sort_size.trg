create or replace trigger SYS.parus_logon after logon on database
declare
 i number;
begin
 select count(*) into i from v$session s
 where s.AUDSID=userenv('SESSIONID') and upper(s.PROGRAM)=upper('Realiz.exe');
 if i=1 then
 execute immediate 'alter session set sort_area_size=10485760';
 execute immediate 'alter session set sort_area_retained_size=10485760';
 end if;
end;
/
