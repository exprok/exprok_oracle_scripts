spool dropall.log
PROMPT Dropping existing objects...

drop public synonym PSP_Mail;
drop public synonym UTL_B64;
drop public synonym "Base64";
drop package PSP_Mail;
drop package UTL_B64;

spool off
exit
