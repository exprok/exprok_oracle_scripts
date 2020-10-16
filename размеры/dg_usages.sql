select name, round(total_mb/1024) total, round(free_mb/1024) free, round(free_mb/(total_mb/100)) free_pct  from v$asm_diskgroup
