select t.DISK_READS,
       to_number(ltrim(to_char(t.DISK_READS / (decode(t.EXECUTIONS, 0, 1, t.EXECUTIONS)),
               '999999')))as per_ex,
               t.EXECUTIONS ,
       t.*
  from v$sqlarea t
 order by 2 desc, t.SQL_TEXT
-- дисковые чтения по убыванию, значащая колонка - per_ex 
-- показывает кол-во дисковых чтений 
-- на одно выполнение
