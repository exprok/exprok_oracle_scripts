DECLARE
  PER_ID NUMBER;
BEGIN
  TIGER.ADMISSION.INIT_USER_CONTEXT('ADMIN');

  -- �������� ������� ������
  SELECT AP.ACCOUNT_PER_ID
    INTO PER_ID
    FROM ACCOUNT_PER AP
   WHERE AP.ACCOUNT_PER_DATE_B IN
         (SELECT MAX(APR.ACCOUNT_PER_DATE_E) + 1
            FROM ACCOUNT_PER_CLOSED APC, ACCOUNT_PER APR
           WHERE APC.ACCOUNT_PER_ID = APR.ACCOUNT_PER_ID);

  UPDATE PRIOR_CALC
     SET JOB_NAME   = NULL,
         SESSION_ID = NULL,
         PRIOR_NUM  = NULL,
         STREAM_NUM = NULL,
         IS_FON     = 1;

  UPDATE CALC_SESSION
     SET ARC_ID =
         (SELECT MIN(ARC_ID)
            FROM CALC_SESSION
           WHERE CALC_TYPE = 0 --��������� ������
             AND ACCOUNT_PER_ID = PER_ID) - 1
   WHERE ARC_ID = 0
     AND CALC_TYPE = 0 --��������� ������
     AND ACCOUNT_PER_ID = PER_ID;

  COMMIT;
 
end;
