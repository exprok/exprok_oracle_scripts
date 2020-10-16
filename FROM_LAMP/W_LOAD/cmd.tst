PL/SQL Developer Test script 3.0
7
begin
  -- Call the procedure
  dbms_java.set_output(10000);
/*  admin.tools_cu.run_os_cmd('d:\winnt\system32\cmd.exe /c dir d:\');
  admin.tools_cu.run_os_cmd('d:\winnt\system32\cmd.exe /c dir d:\prog');
*/  admin.tools_cu.run_os_cmd('d:\winnt\system32\cmd.exe /c d:\temp\w_load\1\a.cmd');
end;
0
