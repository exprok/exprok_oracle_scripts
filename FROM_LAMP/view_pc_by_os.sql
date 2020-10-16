select T.OS_VERSION, count(*)
from   W_ADMIN_EVERY_DAY.PC_STATUS_IN_AD T
group  by T.OS_VERSION
union all
select 'All', count(*) from W_ADMIN_EVERY_DAY.PC_STATUS_IN_AD T