PL/SQL Developer Test script 3.0
11
begin
  -- Call the procedure
  pkg_load.create_job(ln_job => :ln_job,
                      lemail_oper => :lemail_oper,
                      lnext_date => :lnext_date,
                      linterval => :linterval,
                      lpred_work_clipper => :lpred_work_clipper,
                      lpred_work_oracle => :lpred_work_oracle,
                      lpost_work_clipper => :lpost_work_clipper,
                      lpost_work_oracle => :lpost_work_oracle);
end;
8
ln_job
1
88
4
lemail_oper
1
alex@d140.vz
5
lnext_date
1
09.02.2004
12
linterval
1
trunc(sysdate+1)
5
lpred_work_clipper
2
net use f: \\s123_new\vol_123
copy f:\temp\1.dbf d:\temp
5
lpred_work_oracle
1
select 'Begin Time '||to_char(sysdate,'dd.mm.yyyy hi24:mi:ss' from dual;
5
lpost_work_clipper
1
net use f: /del
5
lpost_work_oracle
1
select 'End Time '||to_char(sysdate,'dd.mm.yyyy hi24:mi:ss' from dual
5
