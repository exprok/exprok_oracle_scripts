SELECT 'analyze table '||owner||'.'||table_name||' compute statistics;'
  FROM (SELECT m.TABLE_OWNER owner, m.TABLE_NAME table_name
          FROM ALL_TAB_MODIFICATIONS m, dba_tables t
         WHERE t.OWNER = m.TABLE_OWNER
           AND t.TABLE_NAME = m.TABLE_NAME
           AND ((m.INSERTS + m.UPDATES + m.DELETES) /
               decode(t.NUM_ROWS, 0, 700000000000, t.NUM_ROWS) >= 0.10 OR
               (m.TRUNCATED = 'YES' AND
               decode(t.NUM_ROWS, 0, 700000000000, t.NUM_ROWS) < 0.10) OR
               t.NUM_ROWS IS NULL OR
               (T.NUM_ROWS = 0 AND M.INSERTS + M.UPDATES + m.DELETES > 5000))
        UNION
        SELECT DISTINCT i.TABLE_OWNER, i.TABLE_NAME
          FROM ALL_INDEXES i
         WHERE i.LAST_ANALYZED IS NULL)
 WHERE owner NOT IN ('SYS', 'SYSTEM', 'PERFSTAT', 'XDB')
