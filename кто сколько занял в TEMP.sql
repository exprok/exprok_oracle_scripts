-- ��� ������� �������� � �����
 select sum(t.BLOCKS * 8192)/(1024*1024) ������_��������, username ���_�����
 from gv$tempseg_usage t -- where t.USERNAME like '%OPT%'
 group by "USERNAME"
 union
 select sum(BLOCKS * 8192)/(1024*1024), '�����'
 from gv$tempseg_usage   
