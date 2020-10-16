select  o.owner, o.object_name, --p.*
l.name, sa.SQL_TEXT, ses.SID, ses.USERNAME, ses.MODULE, ses.ACTION, ses.SQL_ADDRESS --o.object_name, o.owner
  from x$bh bh,
       (select sw11.p1raw, ln.NAME
          from v$session_wait sw11, v$latchname ln
         where event = 'latch free'  and ln.LATCH#=sw11.P2             /*and p2 = 98*/) l,
       dba_objects o,
       v$sql_plan p,
       v$sqlarea sa,
       v$session ses
 where bh.OBJ = o.object_id
   and bh.hladdr = l.p1raw
   and bh.TCH > 500
   and p.OBJECT_OWNER = o.owner
   and p.OBJECT_NAME = o.object_name
   and sa.ADDRESS = p.ADDRESS
   and ses.SQL_ADDRESS = p.ADDRESS
