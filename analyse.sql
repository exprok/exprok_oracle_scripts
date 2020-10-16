SELECT '  FULL' AS "�����/��������",
       trunc(SUM(t.BLOCKS * 8192 / (1024 * 1024))) ��_�_����,
       9 AS special,
       COUNT(*) AS �����_����,
       SUM(t.NUM_ROWS) AS �����_���
  FROM DBA_TABLES t
 WHERE owner LIKE 'W`_%' ESCAPE '`'
UNION
SELECT decode(rownum, 1, ' NO ANALYZED', ' ANALYZED'), w, e, r, tt
  FROM (SELECT --t.OWNER,
        --t.TABLE_NAME,
         'AA' AS q,
         TRUNC(SUM(t.BLOCKS) * 8192 / (1024 * 1024)) AS w,
         DECODE(TRUNC(t.LAST_ANALYZED), TRUNC(SYSDATE), 1, 0) AS e,
         COUNT(*) AS r,
         SUM(t.NUM_ROWS) AS tt
          FROM DBA_TABLES t
         WHERE owner LIKE 'W`_%' ESCAPE '`'
         GROUP BY DECODE(TRUNC(t.LAST_ANALYZED), TRUNC(SYSDATE), 1, 0))
UNION
SELECT t.OWNER,
       --t.TABLE_NAME,
       TRUNC(SUM(t.BLOCKS) * 8192 / (1024 * 1024)),
       DECODE(TRUNC(t.LAST_ANALYZED), TRUNC(SYSDATE), 1, 0),
       COUNT(*),
       SUM(t.NUM_ROWS)
  FROM DBA_TABLES t
 WHERE owner LIKE 'W`_%' ESCAPE
 '`'
  AND DECODE(TRUNC(t.LAST_ANALYZED), TRUNC(SYSDATE), 1, 0) = 0
 AND t.TEMPORARY='N'
 GROUP BY owner, DECODE(TRUNC(t.LAST_ANALYZED), TRUNC(SYSDATE), 1, 0)

 ORDER BY 1, 3
