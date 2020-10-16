@echo off
echo Checking for prerequisites...
sqlplus -S "sys/%1 as sysdba" @reqcheck
if errorlevel 1 goto rcf
echo Dropping previous instance...
sqlplus -S "sys/%1 as sysdba" @dropall
call dropjava -user sys/%1 psp_mail.jar
call dropjava -user sys/%1 FileOps9i.jar
echo Loading new code...
call loadjava -user sys/%1 -definer -resolve -verbose psp_mail.jar
call loadjava -user sys/%1 -resolve -verbose -grant public FileOps9i.jar
sqlplus -S "sys/%1 as sysdba" @loadall
goto done
:rcf
echo Some prerequisites were not satisfied, please see the actual
echo error message above for details.
:done