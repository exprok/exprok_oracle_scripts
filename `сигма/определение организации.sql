select distinct case terra_name
             when '������ 187605' then '���'
             when '�����-���������_16' then '���'
             when '120 ������ �������' then '���'
       end Org

from c_terra
where terra_name in('������ 187605','�����-���������_16','120 ������ �������')
