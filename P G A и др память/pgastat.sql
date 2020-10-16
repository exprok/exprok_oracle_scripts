select
name,
value
from
v$pgastat
;

/*Вывод этого запроса может быть примерно следующим:

NAME                                                   VALUE     
------------------------------------------------------ ----------
aggregate PGA auto target                             736,052,224
global memory bound                                        21,200
total expected memory                                     141,144
total PGA inuse                                        22,234,736
total PGA allocated                                    55,327,872
maximum PGA allocated                                  23,970,624
total PGA used for auto workareas                         262,144
maximum PGA used for auto workareas                     7,333,032
total PGA used for manual workareas                             0
maximum PGA used for manual workareas                           0
estimated PGA memory for optimal                          141,395
maximum PGA memory for optimal                        500,123,520
estimated PGA memory for one-pass                         534,144
maximum PGA memory for one-pass                        52,123,520

В этом выводе из v$pgastat мы видим следующие статистики:

* Aggregate PGA auto target - суммарный объем памяти, доступной для соединений с 
Oracle9 i . Это значение устанавливается в соответствии со 
значением параметра pga_aggregate_target в файле init.ora.
* Global memory bound - максимальный размер рабочей области. 
Если значение этой статистики не превышает одного мегабайта, 
корпорация Oracle рекомендует увеличивать значение 
параметра pga_aggregate_target .
* Total PGA allocated - маркер максимального заполнения (high-water mark) 
всей памяти PGA в базе данных. По мере увеличения использования PGA 
значение этой статистики приближается к значению pga_aggregate_target .
* Total PGA used for auto workareas - использование памяти всеми соединениями, 
работающими в режиме автоматического распределения памяти. Помните, 
не все внутренние процессы могут работать в этом режиме. Например, память, 
выделяемая для процедур Java и PL/SQL, не учитывается в этой статистике 
(для определения объема этой памяти и памяти, используемой соединениями, 
которые не работают в режиме автоматического распределения памяти, нужно 
значение этой статистики вычесть из значения статистики total PGA allocated ).
* Estimated PGA memory for optimal/one-pass - оценка объема памяти, требуемой 
для выполнения операций для всех соединений в оптимальном/однопроходном режимах обработки. 
Помните, при нехватке памяти Oracle9 i будет использовать многопроходной режим обработки. 
Эта статистика имеет большое значение для мониторинга использования памяти в Oracle9 i , 
и большинство АБД будет увеличивать значение параметра pga_aggregate_target до значения этой статистики.*/