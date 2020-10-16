Create table parus.t_license_acnt as
SELECT * FROM parus.license_acnt
AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '90' MINUTE) 
ss
--where ss.owner='W_DCE_ERR'