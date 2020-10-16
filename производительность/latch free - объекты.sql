select  o.owner, o.object_name, --p.*
ln.NAME, sa.SQL_TEXT, ses.SID, ses.USERNAME, ses.MODULE, ses.ACTION, ses.SQL_ADDRESS, o.object_name, o.owner, ses.sid
  from x$bh bh,
        v$session_wait sw11 ,
	  v$latchname ln,
--         where event = 'latch free'  and ln.LATCH#=sw11.P2             /*and p2 = 98*/) l,
       dba_objects o,
--       v$sql_plan p,
       v$sqlarea sa,
       v$session ses
 where bh.OBJ = o.object_id
   and bh.hladdr = sw11.P1RAW
   and bh.TCH > 50         
   and sw11.EVENT='latch free'
   and ln.LATCH#=sw11.P2
   and ses.SID=sw11.SID
   and sa.ADDRESS=ses.SQL_ADDRESS
--   and p.OBJECT_OWNER = o.owner
--  and p.OBJECT_NAME = o.object_name
--  and sa.ADDRESS = p.ADDRESS
--  and ses.SQL_ADDRESS = p.ADDRESS
       
  
