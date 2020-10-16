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
   -- ���� optimal 100% PGA ����� ���������. ���� multipass ������ 0 PGA_AREA_TARGET - �����������
