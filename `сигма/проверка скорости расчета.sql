declare
 v_abons0 number := 0;
 v_abons1 number := 0;
  v_abons2 number := 0;
  v_secs  number := 20;
 v_secs_remain  number := null;
begin
 select sum(sofar) into v_abons0 from gV$SESSION_LONGOPS t where t.OPNAME like 'ABONENT GROUP%'; -- and t.START_TIME >= sysdate-6;
 select sum(t.TOTALWORK) into v_abons2 from gV$SESSION_LONGOPS t where t.OPNAME like 'ABONENT GROUP%'; -- and t.START_TIME >= sysdate-6;
 --dbms_output.put_line('t0: '||v_abons0);
 dbms_lock.sleep(v_secs);
 select sum(sofar) into v_abons1 from gV$SESSION_LONGOPS t where t.OPNAME like 'ABONENT GROUP%'; -- and t.START_TIME >= sysdate-6;
 dbms_output.put_line('посчитано абонентов: '||v_abons1);
 dbms_output.put_line('скорость аб/сек: '||(v_abons1 - v_abons0) / v_secs||' ab/sec');
 dbms_output.put_line('Осталось абонентов: '||to_char(v_abons2-v_abons1));
 if (v_abons1 - v_abons0) > 0 then
   select (sum(totalwork) - sum(sofar)) / ((v_abons1 - v_abons0) / v_secs) into v_secs_remain from gV$SESSION_LONGOPS t where t.OPNAME like 'ABONENT GROUP%';
   dbms_output.put_line('осталось, мин: '||round(v_secs_remain/60)||'. Это значение будет меняться  при постепенном завершении потоков. ');
 end if;
end; 
