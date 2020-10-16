select 'grant ' || role_ || ' to "' || upper(member_) || '";'
  from (select upper('AD\' || member) member_,
               upper(substr(substr(group_name, 10),
                            1,
                            length(substr(group_name, 10)) - 2)) role_
          from W_PUZ.T_GROUP_LIST_M t
         where upper(group_name) like 'ORA_PROG%'
           and member is not null
        MINUS
        select grantee, granted_role
          from dba_role_privs
         where granted_role in
               (select distinct upper((substr(substr(group_name, 10),
                                              1,
                                              length(substr(group_name, 10)) - 2))) role_
                  from w_puz.t_group_list_m m
                 where upper(group_name) like '%ORA_PROG%%'))
