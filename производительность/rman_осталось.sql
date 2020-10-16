SELECT dense_rank() over (order by to_char(lo.start_time,
'dd.mm.yyyyy hh24:mi:ss')) NN,
to_char( lo.start_time, 'dd.mm.yyyyy hh24:mi:ss' ) "Start Time",
lo.sid,decode(lo.totalwork,0,0,round(100*lo.sofar/lo.totalwork,2))"%",
replace(to_char(floor(lo.time_remaining/60/60),'00')||':'||
to_char(floor(lo.time_remaining/60)-floor(lo.time_remaining
/60/60)*60,'00')||':'||
to_char( lo.time_remaining - floor( lo.time_remaining / 60 ) * 60, '00' ),'
') "remaining(hour)",
replace(to_char(floor(lo.elapsed_seconds/60/60),'00')||':'|| to_char(
floor(lo.elapsed_seconds/60)-floor(lo.elapsed_seconds
/60/60)*60,'00')||':'||
to_char(lo.elapsed_seconds- floor( lo.elapsed_seconds / 60 ) * 60, '00'
),' ') elapsed,round(
lo.sofar/decode(lo.elapsed_seconds,0,1,lo.elapsed_seconds),4) "V,b/s"
FROM gv$session_longops lo where lo.time_remaining!=0 and opname
like 'RMAN%' and opname not like '%aggregate%' ORDER BY lo.start_time
DESC;
