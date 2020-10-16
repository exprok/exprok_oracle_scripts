PL/SQL Developer Test script 3.0
12
-- Created on 27.06.2003 by ADMIN 
declare 
  -- Local variables here
  i number;
  n number;
begin
  execute immediate 'alter session set events ''10046 trace name context forever, level 4'' ';     
  i:=12;
  select count(*) into n 
  from all_objects a
  where a.object_id < i;
end;
2
i
1
1100
-3
n
1
1037
-3
