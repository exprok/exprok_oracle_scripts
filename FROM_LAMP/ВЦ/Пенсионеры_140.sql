SELECT v.tn, v.fio, v.MP, v.dr, v.pol, decode(v.pol, '�', 60, '�', 55) - v.��� "�� ������, ���",v.����
  FROM (SELECT c.tn, c.fio, c.mp, t.dr, t.pol, round((SYSDATE - to_date(t.dp)) / 365.25, 2) ����,
                round((SYSDATE - to_date(t.dr)) / 365.25, 2) ���
           FROM w_kadr.v_person_mp_current c, w_kadr.zpl_m301 t
          WHERE (c.tn = t.nt AND c.mp = 140)) v
 ORDER BY "�� ������, ���"