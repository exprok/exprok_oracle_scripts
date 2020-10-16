select p.owner "Отдел", p.soft "Название ПО", count(*) "Кол-во компьютеров с ПО", sum(p.nums) "Кол-во разных модулей ПО" from (
select t.owner, count(*) nums,
-- замена soft_name одним словом кроме soft_name начинающимся с слова Windows
decode( decode( instr(t.soft_name,'Windows',1),0,decode(instr(t.soft_name,'Microsoft',1),0,0,1),1),
0,decode ( instr(t.soft_name,' ',2,2),0, t.soft_name,
trim(substr(t.soft_name,0,instr(t.soft_name,' ',2,2))) ),
t.soft_name) soft
from w_soft_an.v_soft_used_current t 
where
-- Windows
t.soft_name not like 'Microsoft Windows ID%'
and upper(t.soft_name) not like 'WINDOWS INSTALLER%'
and upper(t.soft_name) not like '%UPDATE FOR WINDOWS%'
and upper(t.soft_name) not like 'WINDOWS XP HOTFIX%'
and upper(t.soft_name) not like 'HOTFIX FOR MICROSOFT%'
and upper(t.soft_name) not like 'UPDATE FOR MICROSOFT%'
and upper(t.soft_name) not like '%ОБНОВЛЕНИ%'
and upper(t.soft_name) not like 'ИСПРАВЛЕНИЕ%'
and upper(t.soft_name) not like 'HOTFIX FOR WINDOWS%'
and upper(t.soft_name) not like 'ПАКЕТ ИСПРАВЛЕНИЙ%'
and upper(t.soft_name) not like 'WINDOWS SERVER 2003%'
and upper(t.soft_name) not like 'WINDOWS 200%'
and upper(t.soft_name) not like 'NETMEETING%'
and upper(t.soft_name) not like 'WINDOWS IMAGING%'
and upper(t.soft_name) not like 'WINDOWS MEDIA%'
and upper(t.soft_name) not like 'MICROSOFT INTERNET%'
and upper(t.soft_name) not like 'WINDOWS INTERNET%'
-- драйвера
and upper(t.soft_name) not like 'HP%' 
and upper(t.soft_name) not like 'LASERJET%' 
and t.soft_name not like 'SiS%'
and t.soft_name not like 'Intel%'
and upper(t.soft_name) not like 'ACER%'
and upper(t.soft_name) not like 'ASUS%'
and upper(t.soft_name) not like 'ATI %'
and upper(t.soft_name) not like 'CATALYST%'
and upper(t.soft_name) not like 'NVIDIA%'
and upper(t.soft_name) not like 'S3%'
and upper(t.soft_name) not like 'REALTEK%'
and upper(t.soft_name) not like 'SOUND%'
and upper(t.soft_name) not like '% CODEC%'
and upper(t.soft_name) not like 'ПРИНТЕРЫ%'
and upper(t.soft_name) not like '% DRIVER%'
-- стандартный набор ПО
and t.soft_name not like 'WebFldrs%'
and upper(t.soft_name) not like 'VMWARE%'
and upper(t.soft_name) not like '%BACKUP EXEC%'
and upper(t.soft_name) not like '%MICROSOFT OFFICE%'
and t.soft_name not like 'Пакет обеспечения совместимости%'
and upper(t.soft_name) not like 'MICROSOFT .NET%'
and upper(t.soft_name) not like '%ПАРУС%'
and upper(t.soft_name) not like 'PARUS%'
and upper(t.soft_name) not like '%FLASH%'
and upper(t.soft_name) not like 'FAR%'
and upper(t.soft_name) not like 'WINZIP%'
and upper(t.soft_name) not like 'DOSPRN%'
and upper(t.soft_name) not like 'ORA92%'
and upper(t.soft_name) not like 'ORACLE%'
and upper(t.soft_name) not like 'NETOP%'
and upper(t.soft_name) not like 'OPERA%'
and t.soft_name not like 'Adobe Acrobat Reader%'
and t.soft_name not like 'Adobe Reader%'
and t.soft_name not like 'eToken%'
and t.soft_name not like 'ClearType %'
and t.soft_name not like 'Crystal Reports %'
and upper(t.soft_name) not like 'THE BAT%'
and upper(t.soft_name) not like 'WINRAR%'
and t.soft_name not like 'XnViewer%'
and upper(t.soft_name) not like 'MSXML%'
and upper(t.soft_name) not like 'TAME%'
and t.soft_name not like 'ABBY%'
and t.soft_name not like '7-Zip%'
and t.soft_name not like '%SQL%'
and t.soft_name not like 'Doctor%'
and t.soft_name not like 'XML%'
and upper(t.soft_name) not like 'ACDSEE%'
and upper(t.soft_name) not like 'JAVA%'
-- ограничение по дате
and t.record_date > (sysdate - 60)
-- прочие ограничения
and t.owner='140'
-- группировка
group by t.owner, t.computer_name,
decode( decode( instr(t.soft_name,'Windows',1),0,decode(instr(t.soft_name,'Microsoft',1),0,0,1),1),
0,decode ( instr(t.soft_name,' ',2,2),0, t.soft_name,
trim(substr(t.soft_name,0,instr(t.soft_name,' ',2,2))) ),
t.soft_name)
) p
group by p.owner, p.soft 
--order by "Кол-во компьютеров с ПО" desc, p.soft

