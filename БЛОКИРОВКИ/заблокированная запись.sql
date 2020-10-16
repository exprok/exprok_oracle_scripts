select o.object_name,
       row_wait_obj#, 
       row_wait_file#,
       row_wait_block#,
       row_wait_row#,
       dbms_rowid.rowid_create(1, o.DATA_OBJECT_ID, ROW_WAIT_FILE#, ROW_WAIT_BLOCK#, ROW_WAIT_ROW#) 
  from gv$session s, dba_objects o
 where sid = 489
    and s.INST_ID=2
   and s.ROW_WAIT_OBJ# = o.OBJECT_ID;
--Informe o valor para waiting_sid :94 antigo 3 :from v$session s, dba_objects o where sid = &waiting_sid and s.ROW_WAIT_OBJ# = o.OBJECT_ID novo 3 :from v$session s, dba_objects o where sid = 94 and s.ROW_WAIT_OBJ# = o.OBJECT_ID
--AABwBFAAcAAAIYLABO
--AABwBFAAcAAAIYLABO
--AABwBFAAcAAAIYLABO
--AABwBFAAcAAAIYLABO
