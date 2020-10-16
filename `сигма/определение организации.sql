select distinct case terra_name
             when 'Тихвин 187605' then 'ПСК'
             when 'Санкт-Петербург_16' then 'ПЭС'
             when '120 Омская область' then 'ОЭК'
       end Org

from c_terra
where terra_name in('Тихвин 187605','Санкт-Петербург_16','120 Омская область')
