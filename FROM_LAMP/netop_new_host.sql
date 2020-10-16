SELECT * FROM (
select t.host as "������ ���� � Netop Host", 
       count(*) as "���������� ��������", 
       max(t.created) as "��������� ���������",
       min(t.created) as "������ ���������"
from w_netop.dwevnt t
where t.eventtype in ('HCON     +')
group by t.host
order by 3 desc
) V
WHERE v."��������� ���������">to_char(sysdate-7,'YYYY-MM-DD HH24:MI')