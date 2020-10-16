select sum(pins) Pins, Sum (reloads) Reloads,
100 - sum(reloads) / (sum (pins)+Sum (reloads))*100 "PERCENT"
from v$librarycache
