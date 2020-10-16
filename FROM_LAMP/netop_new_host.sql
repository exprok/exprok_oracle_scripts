SELECT * FROM (
select t.host as "Список ПЭВМ с Netop Host", 
       count(*) as "Количество запусков", 
       max(t.created) as "Последнее включение",
       min(t.created) as "Первое включение"
from w_netop.dwevnt t
where t.eventtype in ('HCON     +')
group by t.host
order by 3 desc
) V
WHERE v."Последнее включение">to_char(sysdate-7,'YYYY-MM-DD HH24:MI')