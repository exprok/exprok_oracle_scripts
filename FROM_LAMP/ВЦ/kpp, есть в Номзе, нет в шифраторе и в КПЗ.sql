SELECT v.zak, COUNT(*)
  FROM (SELECT DISTINCT v.kdce, v.zak
           FROM w_kts.n3pri v
          WHERE v.zak IN
                (SELECT DISTINCT pri.zak
                   FROM w_kts.n3pri pri
                 MINUS
                 (SELECT shi.kpp
                   FROM w_kts.h1shifr shi
                 union 
                 SELECT t.kpp FROM w_uchet.h1kpz06 t))) v
 GROUP BY v.zak
 ORDER BY 1