select * from view_all_ddl a
where a.object_owner='W_KTS' and a.object_name='I_N3NOM_UZAK' -- and a.timestamp>sysdate-1/24
order by a.timestamp desc