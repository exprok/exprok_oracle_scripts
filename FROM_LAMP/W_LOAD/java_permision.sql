select t.grantee,t.type_name, t.name, t.action, t.seq from dba_java_policy t
where t.grantee in ('ADMIN')
order by t.seq
