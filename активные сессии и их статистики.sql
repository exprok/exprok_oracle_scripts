SELECT ses.USERNAME, sqla.SQL_TEXT, sqla.EXECUTIONS, ss.SID, SN.NAME, SS.VALUE
	FROM V$SESSTAT SS, V$STATNAME SN, v$session ses, v$sqlarea sqla, dba_users us
 WHERE ses.status = 'ACTIVE' AND
 ses.USERNAME is not null and
    sqla.PARSING_USER_ID=us.user_id AND
		ses.SQL_ADDRESS=sqla.ADDRESS AND
	  SS.STATISTIC# = SN.STATISTIC# AND
	  SN.NAME LIKE '%cpu%' AND 
		ss.SID = ses.SID
		
		ORDER BY VALUE DESC
