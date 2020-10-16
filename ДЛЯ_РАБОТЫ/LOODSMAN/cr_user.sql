-- Create the user 
create user DBO_M
  identified by q
  default tablespace TS_LOODSMAN
  temporary tablespace TEMP
  profile DEFAULT
  quota unlimited on TS_LOODSMAN;
-- Grant/Revoke role privileges 
--grant loodsmanusers_e to DBO_E with admin option;
-- Grant/Revoke system privileges 
grant create procedure to DBO_M;
grant create session to DBO_M;
grant create type to DBO_M;
grant alter session to dbo_m;
grant unlimited tablespace to dbo_m;
create role LOODSMANUSERS_M;
grant CREATE MATERIALIZED VIEW to DBO_M;
grant CREATE TRIGGER to DBO_M;
grant CREATE SEQUENCE to DBO_M;
grant CREATE TYPE to DBO_M;
grant CREATE PROCEDURE to DBO_M;
grant CREATE CLUSTER to DBO_M;
grant CREATE OPERATOR to DBO_M;
grant CREATE VIEW to DBO_M;
grant CREATE INDEXTYPE to DBO_M;
grant CREATE TABLE to DBO_M;
