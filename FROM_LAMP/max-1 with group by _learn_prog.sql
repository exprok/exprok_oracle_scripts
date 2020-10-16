  
  select ta.*, tb.rn1
  from aa ta,
  ( select tc.*, rownum rn1
    from 
    ( select A,B
      from aa
      group by A,B
    ) tc
  ) tb
  where ta.a=tb.a and ta.b=tb.b
  order by ta.a,ta.b,ta.c desc


/*select * 
from
( select t1.*, rownum RN
  from 
   ( select * from A
     order by 1 desc
   ) t1
) t2
where t2.rn=2*/

