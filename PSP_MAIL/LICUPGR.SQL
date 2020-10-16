set lin 200
set serveroutput on define off
exec License.UpgradeLicense(200101,'PSP_Mail','1.4.5','Unregistered User','','TRIAL','ANY','ANY','00009CDC00009CDC00F00369035CFFECA1B4DEA00640FD00FDEAD585164A50000918600051120008EF2AA')
-- package body will get invalidated after license view update
ALTER PACKAGE License COMPILE BODY;

