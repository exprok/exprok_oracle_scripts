select substr(name,1,20) "Latch",
sum(gets) "gets",
sum(misses) "misses",
sum (immediate_gets) "IMM GETS",
sum (immediate_misses) "IMM misses"
from v$latch
where name like 'redo%'
group by name