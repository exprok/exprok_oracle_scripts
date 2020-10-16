conn admin/cfn219dbl@prog.ora.vz
set timing off
set heading off
set feed off
set pagesize 999
column in_use format 9999
column warning format 9999
column  critical format 9999
select  in_use, warning,  critical  from v_mon_nagios_pga;
exit

