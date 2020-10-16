select unique parameter "Cache entry",
gets "Gets", getmisses "Misses" ,
getmisses/(gets+getmisses)*100 "Percent miss"
from v$rowcache
where gets+getmisses <> 0