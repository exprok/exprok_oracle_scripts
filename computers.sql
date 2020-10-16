select t2.computer_name, t1.soft_name 
from w_soft_an.tb_soft t1, w_soft_an.tb_soft_used t2
where t1.rn_soft=t2.rn_soft and t2.computer_name='140CHERNETSEV'