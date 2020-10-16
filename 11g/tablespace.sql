--create bigfile tablespace MATERIAL DATAFILE '/u01/dbe/lintest/material.dat' SIZE 10G AUTOEXTEND ON NEXT 10G; 
--create bigfile tablespace TS_INDEX DATAFILE '/u01/dbe/lintest/TS_LOB.dat' SIZE 10G AUTOEXTEND ON NEXT 10G;
--create bigfile tablespace TS_LOB DATAFILE '/u01/dbe/lintest/TS_LOB.dat' SIZE 10G AUTOEXTEND ON NEXT 10G;
--create tablespace OEM_REPOSITORY DATAFILE '/u01/dbe/lintest/OEM_REPOSITORY.dat' SIZE 10M AUTOEXTEND ON NEXT 10M;
--create bigfile tablespace TS_NOTLOG DATAFILE '/u01/dbe/lintest/TS_NOTLOG.dat' SIZE 10G AUTOEXTEND ON NEXT 10G NOLOGGING;
create  tablespace XDB DATAFILE '/u01/dbe/lintest/XDB.dat' SIZE 100M AUTOEXTEND ON NEXT 100M NOLOGGING;
