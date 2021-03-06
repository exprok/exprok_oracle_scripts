/*select v.dsclient,count(*), test1,test2, min(machinename), max(machinename) 
from
(select DECODE(BITAND(T.FLAGS, 3), 0, '-', 1, 'D1', 2, 'V', 3, 'D2') dsclient,
       DECODE(BITAND(T.FLAGS, 64), 64, 'T', 0, 'x') test,
       DECODE(BITAND(T.FLAGS, 32), 32, '1', 0, 'x') test1,
       DECODE(BITAND(T.FLAGS, 16), 16, '2', 0, 'x') test2,
       t.machinename,
       t.OS_version
from   W_ADMIN_EVERY_DAY.PC_STATUS_IN_AD T) v
where v.OS_version like 'Win 9%'
group by v.dsclient,test1,test2
*/
select count(*), test1,test2, min(machinename), max(machinename) 
from
(select 
       DECODE(BITAND(T.FLAGS, 32), 32, '1', 0, 'x') test1,
       DECODE(BITAND(T.FLAGS, 16), 16, '2', 0, 'x') test2,
       t.machinename,
       t.OS_version
from   W_ADMIN_EVERY_DAY.PC_STATUS_IN_AD T) v
where v.OS_version like 'Win 9%'
group by test1,test2
