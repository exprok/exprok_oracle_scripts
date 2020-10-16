SELECT
   pt.child_number,
   lpad(' ', 2 * level) || pt.operation || ' ' || pt.options || ' ' || pt.object_name "Plan Access Path",
   pt.cost,
   pt.cardinality,
   pt.bytes,
   pt.cpu_cost,
   pt.io_cost,
   pt.temp_space,
   pt.access_predicates,
   pt.filter_predicates,
   pt.qblock_name as "Query Block name"
FROM (select *
      from v$sql_plan
      where
      --HASH_VALUE = :hash and ADDRESS = ':addr' and  CHILD_NUMBER = :child_number
      sql_id = '82b56x2b0arc8' and child_number =6) pt
CONNECT BY PRIOR pt.id = pt.parent_id
START WITH pt.id = 0;
