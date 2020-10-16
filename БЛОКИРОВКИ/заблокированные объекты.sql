select * from v$lock l, dba_objects o where id1=o.OBJECT_ID and owner='W_KALC' and object_name='TB_FOR_MATNORM1'
