select p.owner, sum(nums), p.soft from (select t.owner, count(*) nums, 
decode(instr(t.soft_name,' ',2),0, t.soft_name,trim(substr(t.soft_name,0,instr(t.soft_name,' ',2)))) soft,
t.soft_name
from w_soft_an.v_soft_used_current t 
where 
-- Windows
upper(soft_name) not like '%MICROSOFT%' 
and upper(soft_name) not like 'WINDOWS INSTALLER%'
and upper(soft_name) not like '%UPDATE FOR WINDOWS%'
and upper(soft_name) not like 'WINDOWS XP HOTFIX%'
and upper(soft_name) not like '%Œ¡ÕŒ¬À≈Õ»≈ %'
and upper(soft_name) not like 'œ¿ ≈“ »—œ–¿¬À≈Õ»…%'
and upper(soft_name) not like 'WINDOWS SERVER 2003%'
and upper(soft_name) not like 'NETMEETING%'
-- ‰‡È‚Â‡
and upper(soft_name) not like 'HP%' 
and upper(soft_name) not like 'LASERJET%' 
and soft_name not like 'SiS%'
and soft_name not like 'Intel%'
and upper(soft_name) not like 'ACER%'
and upper(soft_name) not like 'ASUS%'
and upper(soft_name) not like 'ATI %'
and upper(soft_name) not like 'CATALIST%'
and upper(soft_name) not like 'NVIDIA%'
and upper(soft_name) not like 'S3%'
and upper(soft_name) not like 'REALTEK%'
and upper(soft_name) not like 'SOUND%'
and upper(soft_name) not like '% CODEC%'
-- ÒÚ‡Ì‰‡ÚÌ˚È Ì‡·Ó œŒ
and upper(soft_name) not like 'FAR%'
and upper(soft_name) not like 'WINZIP%'
and upper(soft_name) not like 'DOSPRN%'
and upper(soft_name) not like 'ORA92%'
and upper(soft_name) not like 'NETOP%'
and soft_name not like 'Adobe Reader%'
and soft_name not like 'eToken%'
and soft_name not like 'ClearType %'
and soft_name not like 'Crystal Reports %'
and upper(soft_name) not like 'THE BAT%'
and upper(soft_name) not like 'WINRAR%'
and soft_name not like 'XnViewer%'
and upper(soft_name) not like 'MSXML%'
and upper(soft_name) not like 'TAME%'
and soft_name not like 'ABBY%'
and t.owner='118'
group by t.owner, t.soft_name) p
group by p.owner, p.soft order by p.soft
