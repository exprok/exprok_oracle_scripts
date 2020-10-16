PL/SQL Developer Test script 3.0
18
declare
  -- Boolean parameters are translated from/to integers: 
  -- 0/1/null <--> false/true/null 
  no_invalidate boolean := sys.diutil.int_to_bool(:no_invalidate);
begin
  -- Call the procedure
  execute immediate 'alter session set events ''10046 trace name context forever, level 4'' ';
  sys.dbms_stats.gather_index_stats(ownname => :ownname,
                                    indname => :indname,
                                    partname => :partname,
                                    estimate_percent => :estimate_percent,
                                    stattab => :stattab,
                                    statid => :statid,
                                    statown => :statown,
                                    degree => :degree,
                                    granularity => :granularity,
                                    no_invalidate => no_invalidate);
end;
10
ownname
1
W_KTS
5
indname
1
I_CP_CH
5
partname
0
5
estimate_percent
0
4
stattab
0
5
statid
0
5
statown
0
5
degree
0
4
granularity
0
5
no_invalidate
0
3
