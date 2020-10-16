#!/bin/sh
echo Checking prerequisites...
sqlplus -S "sys/$1 as sysdba" @reqcheck
if [ $? -eq 0 ] ; then
echo Dropping existing instance...
sqlplus -S "sys/$1 as sysdba" @dropall
dropjava -user sys/$1 -verbose psp_mail.jar
dropjava -user sys/$1 -verbose FileOps9i.jar
echo Loading new code...
loadjava -user sys/$1 -resolve -definer -verbose psp_mail.jar
loadjava -user sys/$1 -resolve -verbose -grant public FileOps9i.jar
sqlplus -S "sys/$1 as sysdba" @loadall
else
echo Some prerequisites were not satisfied, please see the actual
echo error message above for details.
fi