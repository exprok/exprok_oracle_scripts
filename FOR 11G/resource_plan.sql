begin
  dbms_resource_manager.clear_pending_area();
  dbms_resource_manager.create_pending_area();
  -- создадим группу потребления ресурсов
  dbms_resource_manager.create_consumer_group(consumer_group => 'SCHEDULER_GROUPS',comment => 'GROUPS FOR REGULAR JOBS AND JOB CHAINS');
  
  -- создадим план и дериктивы P_NIGHT
  dbms_resource_manager.create_plan(plan => 'P_NIGHT', comment => 'RESOURCE PLAN FOR NIGHT''S WORK');
  --dbms_resource_manager.delete_plan_directive(plan => 'P_NIGHT',group_or_subplan => 'SYS_GROUP'); 
  
  dbms_resource_manager.create_plan_directive(plan => 'P_NIGHT',
                                              group_or_subplan => 'DEFAULT_MAINTENANCE_PLAN',
                                              comment => 'DIRECTIVE FOR AT GROUPS',
                                              mgmt_p1 => 45
                                              );

  dbms_resource_manager.create_plan_directive(plan => 'P_NIGHT',
                                              group_or_subplan => 'SCHEDULER_GROUPS',
                                              comment => 'DIRECTIVE FOR SCHEDULER JOBS',
                                              mgmt_p1 => 45,
                                              mgmt_p2 => 75,
                                              mgmt_p3 => 100,
                                              active_sess_pool_p1 =>4,
                                              parallel_degree_limit_p1 => 4);
                                              
/*  dbms_resource_manager.create_plan_directive(plan => 'P_NIGHT',
                                              group_or_subplan => 'SYS_GROUP',
                                              comment => 'DIRECTIVE FOR sys GROUPS',
                                              mgmt_p1 => 45
                                              );
*/                                              

  dbms_resource_manager.create_plan_directive(plan => 'P_NIGHT',
                                              group_or_subplan => 'OTHER_GROUPS',
                                              comment => 'DIRECTIVE FOR OTHERS GROUPS',
                                              mgmt_p1 => 10,
                                              mgmt_p2 => 25
                                              );


  
  dbms_resource_manager.create_plan(plan => 'P_DAY', comment => 'RESOURCE PLAN FOR DAY''S WORK');
  dbms_resource_manager.create_plan_directive(plan => 'P_DAY',
                                              group_or_subplan => 'SCHEDULER_GROUPS',
                                              comment => 'DIRECTIVE FOR SCHEDULER JOBS',
                                              mgmt_p1 => 15,
                                              mgmt_p2 => 20,
                                              active_sess_pool_p1 =>2,
                                              parallel_degree_limit_p1 => 2);
                                              
  dbms_resource_manager.create_plan_directive(plan => 'P_DAY',
                                              group_or_subplan => 'SYS_GROUP',
                                              comment => 'DIRECTIVE FOR sys GROUPS',
                                              mgmt_p1 => 5,
                                              mgmt_p2 => 10
                                              );
                                              

  dbms_resource_manager.create_plan_directive(plan => 'P_DAY',
                                              group_or_subplan => 'OTHER_GROUPS',
                                              comment => 'DIRECTIVE FOR sys GROUPS',
                                              mgmt_p1 => 80,
                                              mgmt_p2 => 70,
                                              mgmt_p3 => 100
                                              );


  dbms_resource_manager.create_plan(plan => 'P_WEEKEND', comment => 'RESOURCE PLAN FOR WEEKEND''S WORK');
  dbms_resource_manager.create_plan_directive(plan => 'P_WEEKEND',
                                              group_or_subplan => 'SCHEDULER_GROUPS',
                                              comment => 'DIRECTIVE FOR SCHEDULER JOBS',
                                              mgmt_p1 => 50,
                                              mgmt_p2 => 80,
                                              mgmt_p3 => 100,
                                              active_sess_pool_p1 =>3,
                                              parallel_degree_limit_p1 => 3);
                                              
  dbms_resource_manager.create_plan_directive(plan => 'P_WEEKEND',
                                              group_or_subplan => 'SYS_GROUP',
                                              comment => 'DIRECTIVE FOR sys GROUPS',
                                              mgmt_p1 => 5,
                                              mgmt_p2 => 10
                                              );

  dbms_resource_manager.create_plan_directive(plan => 'P_WEEKEND',
                                              group_or_subplan => 'OTHER_GROUPS',
                                              comment => 'DIRECTIVE FOR sys GROUPS',
                                              mgmt_p1 => 45,
                                              mgmt_p2 => 10
                                              );

                                              
    --dbms_resource_manager.delete_plan_directive(plan => 'MY_PLAN2',group_or_subplan => 'OTHER_GROUPS');
    --dbms_resource_manager.delete_plan_directive(plan => 'MY_PLAN2',group_or_subplan => 'OTHER_GROUPS');
    --dbms_resource_manager.delete_plan(plan => 'MY_PLAN2');  
    --dbms_resource_manager.delete_consumer_group('MY_GROUP2');
    dbms_resource_manager.submit_pending_area();
begin
    dbms_resource_manager_privs.grant_switch_consumer_group ('PUBLIC', 'SCHEDULER_GROUPS', FALSE);
end;
--dbms_resource_manager_privs.grant_switch_consumer_group ('PUBLIC', 'MY_GROUP2', FALSE);
