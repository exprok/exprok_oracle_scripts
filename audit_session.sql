select * from dba_audit_session t where trunc(t.timestamp) in ('12.12.2009', '13.12.2009') and os_username not in ('nagios', 'SYSTEM')
