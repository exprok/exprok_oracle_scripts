set pagesize 9999
set linesize 110
set heading off
set feedback off
spool cr_group.vbs
select
'On Error Resume Next'||chr(13)||chr(10)|| 
'strComputer = "amy-r.ad.vz"'||chr(13)||chr(10)|| 
'Set colAccounts = GetObject("WinNT://" '||'&'||' strComputer & "")'||chr(13)||chr(10)||
'Set oWshNet = CreateObject("WScript.Network" )'||chr(13)||chr(10)|| 
'sNetBIOSDomain = oWshNet.UserDomain'||chr(13)||chr(10) 
 from dual
 union
select 'Set objUser = colAccounts.Create("group",'||'"ora_main_'||role||'_d"'||')'
||chr(13)||chr(10)||        'objUser.SetInfo' ||chr(13)||chr(10)||   'On Error Resume Next'  ||chr(13)||chr(10)||  
'Set oGroup = GetObject("WinNT://"  '||'&'||'  strComputer & "'||'/ora_main_'||role||'_d,group" )'  ||chr(13)||chr(10)||
'Set oUser = GetObject("WinNT://AD/" &'|| '"ora_main_'||role||'_d' ||'" & ",group" )'  ||chr(13)||chr(10)||
'oGroup.Add(oUser.ADsPath)'||chr(13)||chr(10)
||'oUser = null'||chr(13)||chr(10)
from dba_roles r where r.role like 'R~_%' escape '~';
spool off
exit
