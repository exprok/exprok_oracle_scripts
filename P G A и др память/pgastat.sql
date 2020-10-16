select
name,
value
from
v$pgastat
;

/*����� ����� ������� ����� ���� �������� ���������:

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

� ���� ������ �� v$pgastat �� ����� ��������� ����������:

* Aggregate PGA auto target - ��������� ����� ������, ��������� ��� ���������� � 
Oracle9 i . ��� �������� ��������������� � ������������ �� 
��������� ��������� pga_aggregate_target � ����� init.ora.
* Global memory bound - ������������ ������ ������� �������. 
���� �������� ���� ���������� �� ��������� ������ ���������, 
���������� Oracle ����������� ����������� �������� 
��������� pga_aggregate_target .
* Total PGA allocated - ������ ������������� ���������� (high-water mark) 
���� ������ PGA � ���� ������. �� ���� ���������� ������������� PGA 
�������� ���� ���������� ������������ � �������� pga_aggregate_target .
* Total PGA used for auto workareas - ������������� ������ ����� ������������, 
����������� � ������ ��������������� ������������� ������. �������, 
�� ��� ���������� �������� ����� �������� � ���� ������. ��������, ������, 
���������� ��� �������� Java � PL/SQL, �� ����������� � ���� ���������� 
(��� ����������� ������ ���� ������ � ������, ������������ ������������, 
������� �� �������� � ������ ��������������� ������������� ������, ����� 
�������� ���� ���������� ������� �� �������� ���������� total PGA allocated ).
* Estimated PGA memory for optimal/one-pass - ������ ������ ������, ��������� 
��� ���������� �������� ��� ���� ���������� � �����������/������������� ������� ���������. 
�������, ��� �������� ������ Oracle9 i ����� ������������ �������������� ����� ���������. 
��� ���������� ����� ������� �������� ��� ����������� ������������� ������ � Oracle9 i , 
� ����������� ��� ����� ����������� �������� ��������� pga_aggregate_target �� �������� ���� ����������.*/