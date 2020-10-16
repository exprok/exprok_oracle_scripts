select
   program, 
   pga_used_mem, 
   pga_alloc_mem, 
   pga_max_mem 
from
   v$process;