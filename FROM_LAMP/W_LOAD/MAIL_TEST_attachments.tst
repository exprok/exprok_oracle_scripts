PL/SQL Developer Test script 3.0
22
declare
  -- Non-scalar parameters require additional processing 
  result sys.psp_mail.strings;
  v_body sys.psp_mail.strings;
  attachments sys.psp_mail.tbattachments;
begin
  v_body(1) := 'Test Message. Тестовое сообщение.';
  attachments(1).content := sys.utl_binfile.load_blob_from_file(filename => 'd:\temp\readme.txt');
  attachments(1).name := 'readme.txt';
  -- Call the function
  result := sys.psp_mail.sendmailex2(v_from => :v_from,
                                     v_to => :v_to,
                                     v_cc => :v_cc,
                                     v_bcc => :v_bcc,
                                     v_subject => :v_subject,
                                     v_body => v_body,
                                     attachments => attachments,
                                     other_headers => :other_headers,
                                     content_type => :content_type
                                     );
  DBMS_LOB.FREETEMPORARY (attachments(1).content);
end;
8
v_from
1
"macho" <macho@d140.vz>
5
v_to
1
"alex lamp" <alex@d140.vz>
5
v_cc
0
5
v_bcc
0
5
v_subject
1
Test Message. Тестовое сообщение.
5
other_headers
0
5
content_type
1
text/plain; charset=Windows-1251;
5
list_delimiter
0
-5
