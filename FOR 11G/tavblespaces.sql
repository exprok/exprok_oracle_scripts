create bigfile tablespace MATERIAL DATAFILE 'd:\testmain\material.dat' SIZE 10G AUTOEXTEND ON NEXT 10G; 
create bigfile tablespace TS_INDEX DATAFILE 'd:\testmain\TS_INDEX.dat' SIZE 10G AUTOEXTEND ON NEXT 10G;
create bigfile tablespace TS_LOB DATAFILE 'd:\testmain\TS_LOB.dat' SIZE 10G AUTOEXTEND ON NEXT 10G;
create tablespace OEM_REPOSITORY DATAFILE 'd:\testmain\OEM_REPOSITORY.dat' SIZE 10M AUTOEXTEND ON NEXT 10M;
create bigfile tablespace TS_NOTLOG DATAFILE 'd:\testmain\TS_NOTLOG.dat' SIZE 10G AUTOEXTEND ON NEXT 10G NOLOGGING;
create  tablespace XDB DATAFILE 'd:\testmain\XDB.dat' SIZE 100M AUTOEXTEND ON NEXT 100M;
