select  tablespace_name, round(sum((bytes)/(1024*1024*1024)))from dba_data_files d where d.FILE_NAME like '+DG01%' group by tablespace_name order by 2 desc
