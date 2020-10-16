with dd as
 (select ptype_code, cnt
    from (select ptype_code, count(1) cnt from tmp_odn group by ptype_code) dd)
select decode(dd.ptype_code,
              'BF_ELECT',
              '������.',
              'BF_H_W',
              '����',
              '�����'),
       dd.cnt "�����_�����",
       d1.cnt "��������� �����",
       dd.cnt - decode(d1.cnt, null, 0, d1.cnt) "��������"
  from (select ptype_code, count(1) cnt
          from tmp_odn
         where stream <> 0
         group by ptype_code) d1
 right outer join dd
    on dd.ptype_code = d1.ptype_code
