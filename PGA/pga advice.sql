SELECT
   ROUND(pga_target_for_estimate /(1024*1024)) "Target (M)",
   estd_pga_cache_hit_percentage "Est. Cache Hit %",
   estd_overalloc_count "Est. Over-Alloc"
  FROM V$PGA_TARGET_ADVICE;