select t.unitcode,count (*) from parus.docs_props_vals t
group by t.unitcode 