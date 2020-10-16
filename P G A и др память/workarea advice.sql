select
   name profile, 
   cnt, 
   decode(total, 0, 0, round(cnt*100/total)) percentage
from 
   (
      select 
         name, 
         value cnt, 
         (sum(value) over ()) total
      from
         v$sysstat 
      where
         name like 'workarea exec%'
   );
   -- если optimal 100% PGA можно уменьшать. если multipass больше 0 PGA_AREA_TARGET - увеличивать
