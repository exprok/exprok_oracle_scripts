declare
  sql_id_  varchar2(20) := '76341thpcvqbc'; -- ������� �������� sql_id ���
  nums_iterations integer :=1;    -- ����� ���������� ����� �����, ���� 1 �� ��� ��������
  pause_  integer :=2;         --- ����� ����� ����� ������������
  
  command_ varchar2(512);
  
begin
  

   select 'begin sys.dbms_shared_pool.purge(''' || address || ',' ||
         hash_value || ''',' || '''C'',1); end;' into command_  from gv$sqlarea sa
   where sql_id = sql_id_ and sa.INST_ID=(select i.INSTANCE_NUMBER from v$instance i);
 
   dbms_output.put_line(command_);
   
   
   for i in 1..nums_iterations loop
      execute immediate command_;
      if nums_iterations=1 then 
         exit;
      end if;
      dbms_lock.sleep(pause_);
   end loop;
   
end;
      

