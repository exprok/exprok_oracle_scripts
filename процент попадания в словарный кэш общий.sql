select  
(1- (sum(getmisses) / (sum(gets)+sum(getmisses))))*100
"Hit rate"
from v$rowcache
