select --grantee, owner, table_name, tt.role, tt.ad
  distinct role
  from dba_tab_privs p,
       (select upper(rtrim(ltrim(local, 'ora_main_'), '_d')) role, ad from t_groups_member t) tt
   where owner not in (select u.username
                       from dba_users u
                      where default_tablespace in ('SYSTEM', 'SYSAUX')
                     union all
                     select 'OEM' from dual)
          and tt.role(+)=p.grantee
 order by 1
