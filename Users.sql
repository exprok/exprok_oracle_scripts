select username from dba_users
minus
select distinct username from dba_audit_session s
where s.timestamp>'10.04.2006';
