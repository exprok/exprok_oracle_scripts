select a.username, a.terminal, count(*)/2, sum((to_number(a.logoff_time-a.timestamp)/2*24)) "Проработано времени" from dba_audit_session a
where a.returncode=0 and a.logoff_time is not null
group by a.username, a.terminal
