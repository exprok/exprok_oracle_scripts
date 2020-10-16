with files as 
(select substr(file_name, 1, instr(file_name, '/') - 1) group_,
       bytes from dba_data_files
       union all 
       select substr(file_name, 1, instr(file_name, '/') - 1) group_,
       bytes from dba_temp_files)


select  group_,
       round(sum(bytes/(1024*1024*1024))) GB
  from files
 group by group_


