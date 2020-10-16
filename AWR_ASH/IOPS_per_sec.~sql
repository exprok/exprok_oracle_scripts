select METRIC_NAME, round(avg(AVERAGE),2) value, count(1)
  from dba_hist_sysmetric_summary
 where begin_time > sysdate-1/24
   and METRIC_NAME in
       ('Physical Read Total IO Requests Per Sec',
        'Physical Write Total IO Requests Per Sec','I/O Megabytes per Second','Average Synchronous Single-Block Read Latency')
 group by METRIC_NAME;
