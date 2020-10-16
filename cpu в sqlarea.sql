select 
decode(t.HASH_VALUE, 2019109822,1,0 ), sum(t.CPU_TIME), 

sum(t.CPU_TIME)/(select sum(CPU_TIME) from v$sqlarea) ty
from v$sqlarea t  
group by decode(t.HASH_VALUE, 2019109822,1,0 )