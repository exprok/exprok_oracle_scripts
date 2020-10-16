spool loadall.log
PROMPT PSP_Mail v1.4.5  Copyright(c) 2000-2004 by Hit-Media LLC.
PROMPT .........................................................
PROMPT Loading functions and packages...

set feedback on

PROMPT Creating LICENSE Package and view...
@LICENSE.SQL
@LICENSE.PLB
PROMPT Trying to upgrade current license...
@LICUPGR.SQL
set define on
ACC pri_dns      CHAR PROMPT 'Enter your primary DNS server address [192.9.9.3]: ' DEFAULT '192.9.9.3'
ACC site_name    CHAR PROMPT 'Enter your site name to be used in HELO: '
ACC mail_relay   CHAR PROMPT 'Enter your default SMTP server (relay): '
ACC def_port     NUMBER PROMPT 'Enter default SMTP port [25]: ' DEFAULT 25
ACC do_relay     CHAR PROMPT 'Always relay mail through default SMTP (Y/N)? [N] ' DEFAULT 'N'
ACC gmt_diff     NUMBER PROMPT 'Enter offset from GMT in hours [0]: ' DEFAULT 0

SET FEEDBACK OFF HEADING OFF TERMOUT OFF VERIFY OFF
COL relay NOPRI NEW_V always_relay
SELECT DECODE(UPPER('&do_relay'),'Y','TRUE','FALSE') RELAY FROM SYS.DUAL;

SET FEEDBACK ON TERMOUT ON
PROMPT Creating PSP_Mail Package Specification...
@PSP_MAIL.PLH
PROMPT Creating UTL_B64 Package Specification and Body...
@UTL_B64.PKG
PROMPT Creating PSP_Mail Package Body...
@PSP_MAIL.PLB
PROMPT Creating UTL_BinFile Package Specification and Body...
@UTLBFILE.SQL

PROMPT Creating PUBLIC synomyms...
create or replace public synonym UTL_B64 for SYS.UTL_B64;
create or replace public synonym PSP_Mail for SYS.PSP_Mail;
create or replace public synonym "Base64" for SYS."Base64";

PROMPT Granting EXECUTE privilege to PUBLIC...
grant execute on SYS.UTL_B64 to PUBLIC;
grant execute on SYS.PSP_Mail to PUBLIC;
grant execute on SYS."Base64" to PUBLIC;

spool off
exit
