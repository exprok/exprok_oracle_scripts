PL/SQL Developer Test script 3.0
11
begin
  -- Call the procedure
  pkg_load.create_job(ln_task => :ln_task,
                      lemail_oper => :lemail_oper,
                      lnext_date => :lnext_date,
                      linterval => :linterval/*,
                      lpred_work_clipper => :lpred_work_clipper,
                      lpred_work_oracle => :lpred_work_oracle,
                      lpost_work_clipper => :lpost_work_clipper,
                      lpost_work_oracle => :lpost_work_oracle*/);
end;
8
ln_task
0
4
lemail_oper
1
w_load@d140.vz
5
lnext_date
1
29.01.2004
12
linterval
1
sysdate+1
5
lpred_work_clipper
1
null
-5
lpred_work_oracle
1
null
-5
lpost_work_clipper
1
null
-5
lpost_work_oracle
1
null
-5
