
-- ������ ᮦ࠭���� � �奬� ����
select sum(blocks)*8 from
(select a.segment_name, a.bytes, a.* from dba_segments a where a.owner='W_KTS' order by 2 desc)

-- ����� ᮦ࠭���� � �奬� ����, �� ��ꥪ⠬, ��㯭� ������ ᯨ᪠
select a.segment_name, a.bytes, a.* from dba_segments a where a.owner='W_KTS' order by 2 desc