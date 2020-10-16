select i.*
  from t_invalid_objects i, (select object_owner, object_name, object_type
                               from t_invalid_objects
                              group by object_owner,
                                       object_name,
                                       object_type
                             having count(*) > 1) v
 where v.object_owner = i.object_owner and v.object_name = i.object_name and
       v.object_type = i.object_type
 order by i.timestamp desc