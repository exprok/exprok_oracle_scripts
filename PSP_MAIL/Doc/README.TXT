... PSP_Mail ............................................... Version 1.4.5 ...
                                   Copyright(c) 2001-2004 by Hit-Media LLC.
                                                       All rights reserved.

 README.txt for PSP_Mail Suite.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 This document describes the suite installation.

 PSP_Mail is a Dynamic PSP(tm) add-on suite for Oracle8i(R)/9i that provides
 an easy-to-use interface for sending e-mail from within Oracle PL/SQL stored
 programs. PSP_Mail utilizes the standard UTL_SMTP package and several Java(tm)
 classes for implementing its functionality. It provides several routines
 that allow sending simple email, attach one or several LOBs to the message
 and target several recipients with one call, and much more. Refer to the 
 PSP_Mail.PDF file for complete suite documentation and examples of use.

 Files in Distribution Set.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~

 loadmail.bat           - load script - Windows version
 loadmail.sh            - load script - Unix version
 loadmail9i.bat         - load script for Oracle9i - Windows version
 loadmail9i.sh          - load script for Oracle9i - Unix version
 dropall.sql            - cleanup DDL script - drops all PSP_Mail objects
 loadall.sql            - package load DDL script for SQL*Plus
 reqcheck.sql		- required packages/Java classes check script
 UTL_B64.PKG            - UTL_B64 package source code
 PSP_MAIL.PLH           - PSP_Mail package header (specification)
 PSP_MAIL.PLB           - PSP_Mail package body (wrapped)
 psp_mail.jar           - PSP_Mail Java classes archive
 FileOps.jar		- UTL_BinFile Java classes archive for Oracle8i
 FileOps9i.jar		- UTL_BinFile Java classes archive for Oracle9i+
 UTLBFILE.SQL		- UTL_BinFile package source code
 LICENSE.PLB		- License enforcement package
 LICENSE.SQL            - Trial License file
 LICUPGR.SQL            - Trial License file
 Doc\PSP_Mail.PDF       - PSP_Mail User's Guide (Adobe Acrobat format)
 Doc\RelNotes.PDF       - PSP_Mail Release Notes for current version
 Doc\FAQ.txt            - PSP_Mail FAQ (Frequently Asked Questions)
 Doc\README.txt         - this file


 Requirements.
 ~~~~~~~~~~~~~
 * Oracle8i Release 2 (8.1.6) with JServer/Oracle VM or later.
 * DNS server accessible from the host where PSP_Mail is installed
   if local mail relay server is not [always] used.
 * For direct sends, Oracle host should be able to establish outgoing 
   connections to hosts outside the local network on port 25 (default SMTP 
   port) - please contact your network administrator to ensure your firewall 
   is configured to allow this.


               
 Installation
 ~~~~~~~~~~~~

 Run load script provided with this package (loadmail{9i}.bat on Windows 
 systems, or loadmail{9i}.sh on unix systems):

 loadmail{9i} yoursyspassword[@TNSAlias]
  or
 /bin/sh loadmail{9i}.sh yoursyspassword[@TNSAlias]

 where yoursyspassword is password for SYS user in your Oracle database and
 [@TNSAlias] is optional Oracle TNS alias (brackets denote that it is optional 
 parameter, you should invoke script without brackets if you specify the alias:
 loadmail yoursyspassword@ORCL ). Use loadmail9i scripts if your target
 database is 9i or later.

 The script in turn will call two Oracle command-line utilities - loadjava
 and SQL*Plus - which will load Java classes and PL/SQL objects respectively 
 into your Oracle database. These utilities must be on PATH and ORACLE_HOME 
 environment variable should point to correct Oracle home directory for these
 utilities to operate correctly. 

 The script will verify if required packages and/or Java classes exist in
 the database and stop if they do not exist. Required components checked are
 UTL_SMTP package and oracle.plsql.net.TCPConnection Java class. If these
 components do not exist in the target database, the script will print an
 error message and a recommended action hint.

 After that, script will prompt you to provide values for several package
 configuration parameters. Parameters and their meaning are as follows:

 PRIMARY_DNS     - this is the address of your DNS server. You can use
                   either IP address or alias.
                   Default is 193.9.9.3 (ns.sun.com)
                   All DNS lookups will be performed against this server,
                   so it must be able to do recursive lookups. Consult your
                   network administrator to obtain correct address.

 SITE_NAME       - this is name of your site or Oracle host - this name
                   is sent to the receiving SMTP server to identify the
                   mail originator host. Some SMTP servers are set up to
                   verify the name of host they receive with alias assigned
                   to the IP address of originator via DNS and deny
                   connection if they do not match - so be sure to set this
                   parameter to correct name.

 DEFAULT_SMTP    - this is address of default SMTP gateway that will be
                   used for mail delivery in case DNS lookup fails to locate
                   mail server for particular recipient. This server must
                   be able to relay mail originating from senders you will
                   specify or mail coming from IP address of your Oracle
                   server (consult your network or mail administrator to
                   obtain this address and ensure it is configured to allow
                   mail relay from your Oracle host).
                   Set this parameter to NULL to disable sending mail through
                   mail relay if it can't be delivered directly. SendMail
                   functions will return 510 error code if DNS lookup fails
                   and this parameter is NULL.

 SMTP_PORT       - this is DEFAULT_SMTP server TCP port. Default value is 25,
                   standard SMTP port. This value should not be changed unless
                   instructed to do so by network administrator (for example,
                   if relaying SMTP server was set up to listen on different
                   port to prevent spamming).

 ALWAYS_RELAY    - this parameter is of type Boolean and is FALSE by default.
                   If you want all your mail to go through mail relay host
                   (configured with DEFAULT_SMTP), set this parameter to True.
                   No DNS lookups will be performed and all mail will be sent
                   using DEFAULT_SMTP.
 
 GMT_DIFF	 - this parameter sets offset in hours from GMT (Greenwich
                   Mean Time, currently known as UTC, or Universal Coordinated
                   Time) and is used to generate correct timestamps for email 
                   messages. Default value is 0 (no offset).
                   This parameter is ignored on Oracle9i and later databases,
                   built-in time zone-related functionality is used to determine 
                   the server's time zone.

 Answer to the prompts to fill the above parameters. Installation will
 automatically continue once all parameters are entered.

 Once the script is complete, verify the installation:

 1) go to SQL*Plus, login and run

    SELECT PSP_Mail.Version FROM SYS.DUAL;

    This should print current version number for PSP_Mail.

 2) send a test email to yourself. In SQL*Plus, type the following code
    (substitute fake emails with correct addresses).

    declare
     res    VarChar2(32767);
     msg    psp_mail.strings;
    begin
     msg(1) := 'Hello,
This is a test message, please delete and do not respond.';

     res := psp_mail.SendMailEx(
     'john.doe@company.com', 'John Doe',        -- sender
     'richard.roe@company.com', 'Richard Roe',  -- recipient
     'test message',                            -- subject
     msg                                        -- message body
     );
     if res is null then
      null; -- success
     else
      raise_application_error(-20000,res);
     end if;
    end;
    /

 The above code should complete without errors. If it throws the error,
 see the error message and correct the problem, then rerun this code.
 Errors raised here may only be transport-related (which are thrown in
 UTL_SMTP package) or Java permissions-related (which are thrown in Java
 code used by UTL_SMTP for network operations). Thus you will need to
 check the error message thoroughly and take appropriate action to
 correct the issue. Permissions-related errors are not likely to occur
 here, because PSP_Mail is installed into SYS schema with AUTHID DEFINER
 privilege directive, and SYS is unrestricted Java user by default.

 If you are getting error complaining that oracle.plsql.net.TCPConnection
 class is not found in the database or 'User-defined exception' error, you
 need to install this class into the database by issuing

 @?/rdbms/admin/initplsj.sql

 in SQL*Plus when connected as SYS. This script will reload proper Java
 classes into the database VM. This error should not appear on Oracle9i Rel.2
 or later, because UTL_TCP was re-implemented in native C starting with this
 release and the abovementioned class is no longer necessary.

 Please note that in case of invalid recipient address, mail will still be
 sent through the DEFAULT_SMTP gateway because PSP_Mail routes all mail it
 can't deliver directly to the DEFAULT_SMTP relay without inspecting the error
 returned by the SMTP server. Such mail will be bounced back to sender's
 address immediately or after relay server-configured timeout.  If you want 
 such mail to be rejected by PSP_Mail itself, set DEFAULT_SMTP to NULL. Note 
 that setting DEFAULT_SMTP to NULL will disable using relay host for sending 
 mail altogether.


 Upgrade From Previous Versions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Since there were changes in published API, full reinstallation is necessary.
 Your current license key will be replaced with trial key shipped with the
 product and you will need to reinstall your key according to the instructions
 you received with it. 



 Turning your Trial version into full-featured version
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 PSP_Mail uses Hit-Media's proprietary license enforcement system. We do
 not tolerate software piracy and therefore are protecting our software
 with license keys.

 Trial license key comes with the distribution archive, in LICENSE.SQL file.
 It is installed as LICENSEINFO view into target Oracle database, into SYS
 schema, and is used to determine current license type. Trial version of the
 PSP_Mail will append a banner to each message sent through it indicating it
 was sent using trial version. Also, your trial license key may be
 time-limited. In this case, PSP_Mail will stop functioning after particular
 date. If the license view already present in target schema (for example, if 
 you have other Hit-Media products installed), it will NOT be replaced, but 
 current PSP_Mail license will be updated with trial license.

 *** BE SURE TO BACKUP your current LICENSEINFO view before installing
 *** PSP_Mail. Not doing so puts you at risk of losing your licenses for
 *** our products. Just extract LICENSEINFO view DDL and save it in a
 *** file using your favorite Oracle development tool.

 When you purchase PSP_Mail, you will receive new LICUPGR.SQL file containing
 new key for PSP_Mail. To install new license key, simply run this script with
 SQL*Plus under SYS credentials. It will upgrade your license for PSP_Mail
 while leaving other licenses you might have intact. New license will be 
 effective immediately after you upgrade it.


 Getting Support
 ~~~~~~~~~~~~~~~

 In case you have problems with package installation or use, please read
 the documentation provided first. If documentation does not contain an
 answer to your problem, please visit our web site at

 http://www.dynamicpsp.com

 and join our support forum where you can ask your questions and they
 will be answered either by our support crew or by other users of DPSP
 and its addons.

 Also, you may write an e-mail to support@dynamicpsp.com. Please include
 your registration ID with your e-mail. We do not provide support for
 unregistered users.
