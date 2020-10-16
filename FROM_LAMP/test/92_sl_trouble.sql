SELECT /*+ ORDERED NO_MERGE USE_NL(S) */
 /* This query obtains session_event data for a particular session using the
          index in x$ksles.indx.  This index is a combination of the event number +sid */
 SUBSTR(sl.quest_soo_pkg.event_category(n.event), 1, 200) event_category,
 n.event                                             event,
 S.KSLESWTS                                          total_waits,
 S.KSLESTMO                                          total_timeouts,
 S.KSLESTIM * 10                                       time_waited
  FROM (SELECT /*+ NO_MERGE Here we generate indx values for a particular sid*/
         indx, kslednam event, (16 - 1) * (max_indx + 1) + indx ksles_indx
          FROM x$ksled d, (SELECT /*+ NO_MERGE Here we determine the maximum event#*/
                           MAX(indx) max_indx
                            FROM x$ksled) m) n, x$ksles s
 WHERE s.indx = n.ksles_indx AND s.ksleswts <> 0 AND
       UPPER(sl.quest_soo_pkg.event_category(n.event)) <>
       DECODE(3, 0, 'IDLE', 'x')