PL/SQL Developer Test script 3.0
26
declare
  -- Boolean parameters are translated from/to integers: 
  -- 0/1/null <--> false/true/null 
  block_sample boolean := sys.diutil.int_to_bool(:block_sample);
  cascade boolean := sys.diutil.int_to_bool(:cascade);
  no_invalidate boolean := sys.diutil.int_to_bool(:no_invalidate);
  gather_temp boolean := sys.diutil.int_to_bool(:gather_temp);
  gather_fixed boolean := sys.diutil.int_to_bool(:gather_fixed);
begin
  -- Call the procedure
  execute immediate 'alter session set events ''10046 trace name context forever, level 4'' ';
  sys.dbms_stats.gather_schema_stats(ownname => :ownname,
                                     estimate_percent => :estimate_percent,
                                     block_sample => block_sample,
                                     method_opt => :method_opt,
                                     degree => :degree,
                                     granularity => :granularity,
                                     cascade => cascade,
                                     stattab => :stattab,
                                     statid => :statid,
                                     options => :options,
                                     statown => :statown,
                                     no_invalidate => no_invalidate,
                                     gather_temp => gather_temp,
                                     gather_fixed => gather_fixed);
end;
14
ownname
1
W_KTS
5
estimate_percent
0
4
block_sample
0
3
method_opt
1
FOR ALL INDEXED COLUMNS SIZE AUTO
5
degree
0
4
granularity
1
ALL
5
cascade
1
1
3
stattab
0
5
statid
0
5
options
1
GATHER
5
statown
0
5
no_invalidate
0
3
gather_temp
0
3
gather_fixed
0
3
