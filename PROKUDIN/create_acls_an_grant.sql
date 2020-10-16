BEGIN
  DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(acl         => 'all.xml',
                                    description => 'Network connection permission for all',
                                    principal   => 'ADMIN', -- Must be in upper case
                                    is_grant    => TRUE,
                                    privilege   => 'connect');

  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(acl        => 'all.xml',
                                    host       => '*');
END;
