BEGIN
    DBMS_NETWORK_ACL_ADMIN.CREATE_ACL (
                                      acl => 'all.xml',
                                      description => 'to all hosts',
                                      principal => 'PROK',
                                      is_grant => TRUE,
                                      privilege => 'connect'
                                      );
   DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL (
                  acl => 'all.xml',
                  host => '*',
                  lower_port => 1,
                  upper_port => 10000);
   commit;
END;


begin
    DBMS_NETWORK_ACL_ADMIN.add_privilege(acl => 'all.xml',
                                         principal => 'W_AD',
                                         is_grant => TRUE,
                                         privilege => 'connect')    ;
end;
