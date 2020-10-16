PL/SQL Developer Test script 3.0
24
declare
  -- Boolean parameters are translated from/to integers: 
  -- 0/1/null <--> false/true/null 
  block_sample boolean := sys.diutil.int_to_bool(:block_sample);
  cascade boolean := sys.diutil.int_to_bool(:cascade);
  no_invalidate boolean := sys.diutil.int_to_bool(:no_invalidate);
begin
  -- Call the procedure
  sys.dbms_stats.gather_table_stats(ownname => /*'W_KTS',*/ :ownname,
                                    tabname => /*'CP',*/ :tabname,
                                    partname => /*NULL,*/ :partname,
                                    estimate_percent => :estimate_percent,
                                    block_sample => block_sample,
--                                    method_opt => :method_opt,
--                                    method_opt => 'FOR COLUMNS CEXSB SIZE 20, KDCE_CH size 40'
                                    method_opt => 'FOR ALL COLUMNS SIZE AUTO',
                                    degree => :degree,
                                    granularity => :granularity,
                                    cascade => cascade,
                                    stattab => :stattab,
                                    statid => :statid,
                                    statown => :statown,
                                    no_invalidate => no_invalidate);
end;
13
ownname
1
W_KTS
5
tabname
1
CP
5
partname
0
5
estimate_percent
0
4
block_sample
0
3
method_opt
1
FOR COLUMNS CEXSB SIZE 20, KDCE_CH size 40
-5
degree
0
4
granularity
1
ALL
5
cascade
0
3
stattab
0
5
statid
0
5
statown
0
5
no_invalidate
0
3
