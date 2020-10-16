set define off
declare
 C Char(1);
begin
 execute immediate 'select '' '' into :1 from LicenseInfo' using OUT C;
 exception
  when others then
  execute immediate replace('CREATE OR REPLACE VIEW LicenseInfo
                       (ID,
                        Product,
                        Version,
                        Licensee,
                        ExpDate,
                        Status,
                        SID,
                        Host,
                        Key )
AS
SELECT 200101,
       ''PSP_Mail'',
       ''1.4.5'',
       ''Unregistered User'',
       '''',
       ''TRIAL'',
       ''ANY'',
       ''ANY'',
       ''00009CDC00009CDC00F00369035CFFECA1B4DEA00640FD00FDEAD585164A50000918600051120008EF2AA''
       FROM DUAL', chr(13) );
end;
/
