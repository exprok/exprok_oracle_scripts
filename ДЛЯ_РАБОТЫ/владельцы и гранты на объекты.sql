select (select us.user_parent /* up.FIO*/
          from users us,
               (select 'D' || upper(u.uname) as user_ora,
                       u.uname as uname,
                       ua.login as ulogin,
                       ua.fname || ' ' || ua.lname as FIO
                  from (select lower(ltrim(user_name, 'D')) uname
                          from users
                         where user_name not like '120%') u,
                       w_puz.v_user_ad ua --, users uw
                 where ua.login(+) = u.uname
                   and u.uname not like 'ad\%'
                   and u.uname not like 'r`_%' escape
                 '`'
                   and u.uname not like 'w`_%' escape '`') up
        
         where us.user_name like 'W`_%' escape '`'
           and up.user_ora = us.user_parent
           and us.user_name = tp.grantee) "логин в оракле",
       (select /*us.user_name,us.user_parent,*/
         up.FIO
          from users us,
               (select 'D' || upper(u.uname) as user_ora,
                       u.uname as uname,
                       ua.login as ulogin,
                       ua.fname || ' ' || ua.lname as FIO
                  from (select lower(ltrim(user_name, 'D')) uname
                          from users
                         where user_name not like '120%') u,
                       w_puz.v_user_ad ua --, users uw
                 where ua.login(+) = u.uname
                   and u.uname not like 'ad\%'
                   and u.uname not like 'r`_%' escape
                 '`'
                   and u.uname not like 'w`_%' escape '`') up
        
         where us.user_name like 'W`_%' escape '`'
           and up.user_ora = us.user_parent
           and us.user_name = tp.grantee) ФИО,
       tp.*
  from dba_tab_privs tp
 where owner like 'W`_%' escape '`'
 and grantee not like 'R`_%' escape '`'
order by 1, 3
