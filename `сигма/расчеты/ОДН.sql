with dd as
 (select ptype_code, cnt
    from (select ptype_code, count(1) cnt from tmp_odn group by ptype_code) dd)
select decode(dd.ptype_code,
              'BF_ELECT',
              'Электр.',
              'BF_H_W',
              'Вода',
              'Отопл'),
       dd.cnt "всего_домов",
       d1.cnt "посчитано домов",
       dd.cnt - decode(d1.cnt, null, 0, d1.cnt) "осталось"
  from (select ptype_code, count(1) cnt
          from tmp_odn
         where stream <> 0
         group by ptype_code) d1
 right outer join dd
    on dd.ptype_code = d1.ptype_code
