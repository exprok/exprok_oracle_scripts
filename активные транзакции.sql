-- ���������� ������� ����������, SID � SERIAL � 
--USERNAME ������������ ������ � ������� ���������� � ����� ������� ����� ����
select tran.ADDR,
       sess.SID,
       SESS.SERIAL#,
       sess.USERNAME,
       (SELECT SQLA.SQL_TEXT
          FROM v$sqlarea sqla
         WHERE SESS.SQL_ADDRESS = SQLA.ADDRESS)
  from v$session sess, v$transaction tran
 where sess.taddr = tran.ADDR
