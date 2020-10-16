select * from dba_objects o
where o.object_name like 'DBMS_XSL%' and (o.object_type like 'PA%' or o.object_type like '%SYNO%')