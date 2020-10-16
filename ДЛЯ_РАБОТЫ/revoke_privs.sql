select 'revoke '||pp.privilege||' from '||grantee||';' from dba_sys_privs pp where pp.grantee like 'W`_%' escape '`' and
pp.privilege in
(select --distinct p.privilege
--'revoke '||p.privilege||' from '||grantee||';'
p.privilege
  from dba_sys_privs p
 where p.grantee like 'W`_%' escape '`'
   and p.privilege like 'CREATE%'
   and p.grantee like 'W_TEST_%'
 --  and ( p.privilege like '%OPERATOR%'
 --  or p.privilege like '%CLUSTER%'
 --  or p.privilege like '%PROCEDURE%')
 and p.privilege<>'CREATE SESSION'
 and p.privilege<>'CREATE SNAPSHOT'
 )
 order by 1
