PL/SQL Developer Test script 3.0
12
declare
  -- Non-scalar parameters require additional processing 
  attrs dbms_ldap.STRING_COLLECTION;
begin
  attrs(1):='*';
  -- Call the procedure
  d140lamp.ldap_test(base => :base,
            filter => :filter,
            attrs => attrs,
            attronly => :attronly,
            res => :res);
end;
4
base
1
ou=vz,DC=ad,DC=vz
5
filter
1
sAMAccountName=zhidkov
5
attronly
1
0
3
res
1
78D56307F121006200000000A4BEB8067ABA2D0118BFB806C5CA2D01BC03CC01
5
0
