-- ������ ��� �������!
-- 1) ��������� ����������� ������
-- 2) ��������� "������� ��������� ������� ����� ���������� � ������� ����� � ���" � �������������� ��� ���-�� ��� ����� ��������� � ������������� � ��� ��, ��� ����.
-- ������� ��������� ������� ����� ���������� � ������� ����� � ���
/* select ct.terra_id, CT.TERRA_NAME, count(*)
  from object_terra ot
  join c_terra ct
    on OT.TERRA_ID = CT.TERRA_ID
  join p_place pp
    on OT.OBJECT_ID = PP.OBJECT_ID
  join p_xpoint pxp
    on pxp.place_id=pp.place_id
where CT.TERRA_TYPE_ID = 1
   and PP.ARC_ID = 0
   and PXP.ARC_ID = 0
group by ct.terra_id, CT.TERRA_NAME
order by terra_id*/

/* -- � ��������� ���
select ct.terra_id, CT.TERRA_NAME, pvp.point_belong, count(*)
  from object_terra ot
  join c_terra ct
    on OT.TERRA_ID = CT.TERRA_ID
  join p_place pp
    on OT.OBJECT_ID = PP.OBJECT_ID
  join p_xpoint pxp
    on pxp.place_id=pp.place_id
  join p_npoint pnp
    on pxp.point_id = pnp.point_id
  join p_vpoint pvp
    on pnp.point_xid = pvp.point_xid
where CT.TERRA_TYPE_ID = 1
   and PP.ARC_ID = 0
   and PXP.ARC_ID = 0
   and pvp.point_belong = 2
group by ct.terra_id, CT.TERRA_NAME, pvp.point_belong
order by terra_id,point_belong
*/--1713595
/* -- ����������� �� ����� ���������� �� ������ ����������
select ct.terra_id, CT.TERRA_NAME, pvp.point_belong, count(*)
  from object_terra ot
  join c_terra ct
    on OT.TERRA_ID = CT.TERRA_ID
  join p_place pp
    on OT.OBJECT_ID = PP.OBJECT_ID
  join p_xpoint pxp
    on pxp.place_id=pp.place_id
  join p_npoint pnp
    on pxp.point_id = pnp.point_id
  join p_vpoint pvp
    on pnp.point_xid = pvp.point_xid
where CT.TERRA_TYPE_ID = 1
   and PP.ARC_ID = 0
   and PXP.ARC_ID = 0  
group by ct.terra_id, CT.TERRA_NAME, pvp.point_belong
order by terra_id,point_belong
*/

-- 3) ���� ��� ���������� - ������� ������!
-- ������ ������������ ���������� - ������ 2(� ����������� � Object_terra)

/* -- ����� �������� ����� 33 ����� �� ��� ��� ����� 731
select object_id, count (PLACE_ID) count_place_id, 0 group_num
                        from (select distinct pl.object_id, PL.PLACE_ID
                                from p_xpoint pxp, p_place pl, p_npoint pnp, p_vpoint pvp
                               where pxp.place_id=pl.place_id
                                 and PXP.POINT_ID = PNP.POINT_ID
                                 and PNP.POINT_XID = PVP.POINT_XID                                
                                 and pxp.arc_id=0
                                 and pl.arc_id=0
                                 and PVP.ARC_ID=0
                                 and PVP.POINT_BELONG=2 )
                       group by object_id;*/

/* ������������� �������� ������ �� ������� TEST_TERRA_BALANCE_PREP2
select group_num, sum(count_place_id) from TEST_TERRA_BALANCE_PREP2
group by group_num
*/

/* -- �������� ������� �����������, ��� ��� �� �������� ������ � ���� ������ ��� ������������ ������
CREATE TABLE TEST_TERRA_BALANCE_PREP2
(
  OBJECT_ID       NUMBER(15)                    NOT NULL,
  COUNT_PLACE_ID  NUMBER,
  GROUP_NUM       NUMBER
);
*/

delete from test_terra_balance_prep2;

-- ��������� ������ ������� � ���
-- ������� �������� ��� ����� ��� ������� ������������ ������ �� ���
-- ����� ���� ��������, �������� �� ������� � ������� �������� ���, �� ����� ����������� 
MERGE INTO TEST_TERRA_BALANCE_PREP2 A
USING (select object_id, count(PLACE_ID) count_place_id, 0 group_num
         from (select distinct pl.object_id, PL.PLACE_ID
                 from p_xpoint pxp, p_place pl , p_npoint pnp, p_vpoint pvp
                where pxp.place_id = pl.place_id
                  and PXP.POINT_ID = PNP.POINT_ID
                  and PNP.POINT_XID = PVP.POINT_XID
                  and pxp.arc_id = 0
                  and pl.arc_id = 0
                  and PVP.ARC_ID = 0
                  and PVP.POINT_BELONG = 2 )
        group by object_id) B
ON (A.OBJECT_ID = B.OBJECT_ID)
WHEN NOT MATCHED THEN
  INSERT
    (OBJECT_ID, COUNT_PLACE_ID, GROUP_NUM)
  VALUES
    (B.OBJECT_ID, B.COUNT_PLACE_ID, B.GROUP_NUM);

DECLARE
  V_ZONE_NUM number DEFAULT 20 ;
BEGIN

  -- ������ ���������� ��������� �������
  declare
    -- ������� ��������
    v_bucket_cnt number DEFAULT V_ZONE_NUM;
    --/ ������� ��������
 
    v_bucket_max_num number;
    v_bucket_cur_num number;
    v_bucket_cur_sum number;
 
    procedure fill_end_of_bucket is
    begin
   
      for cc in (select object_id, count_place_id
                   from test_terra_balance_prep2
                  where group_num = 0
                    and count_place_id <=
                        v_bucket_max_num - v_bucket_cur_sum
                  order by count_place_id desc) loop
     
        IF v_bucket_cur_sum + cc.count_place_id <= v_bucket_max_num THEN
          -- ����������� �������� ����     
          v_bucket_cur_sum := v_bucket_cur_sum + cc.count_place_id;
       
          update test_terra_balance_prep2
             set group_num = v_bucket_cur_num
           where object_id = cc.object_id;
       
        ELSIF v_bucket_cur_sum >= v_bucket_max_num THEN
          -- ����� �� ����������� ���������� ���-�� � bucket'� -> �������
          EXIT;
       
        ELSE
       
          fill_end_of_bucket;
       
        END IF ;
     
      end loop ;
   
    end fill_end_of_bucket;
 
  begin
 
    v_bucket_cur_sum := 0;
 
    -- ���� ������ �� ��� ������
    select floor (sum(count_place_id) / v_bucket_cnt) + 1
      into v_bucket_max_num
      from test_terra_balance_prep2;
 
    for i in 1 .. v_bucket_cnt loop
   
      v_bucket_cur_num := i;
      v_bucket_cur_sum := 0;
   
      fill_end_of_bucket;
   
    end loop ;
 
    -- ����������� ������� �����
    MERGE INTO TEST_TERRA_BALANCE_PREP2 A
    USING (select object_id, count(PLACE_ID) count_place_id, 0 group_num
             from (select distinct pl.object_id, PL.PLACE_ID
                     from p_xpoint pxp,
                          p_place  pl,
                          p_npoint pnp,
                          p_vpoint pvp
                    where pxp.place_id = pl.place_id
                      and PXP.POINT_ID = PNP.POINT_ID
                      and PNP.POINT_XID = PVP.POINT_XID
                      and pxp.arc_id = 0
                      and pl.arc_id = 0
                      and PVP.ARC_ID = 0
                      and PVP.POINT_BELONG = 1 )
            group by object_id) B
    ON (A.OBJECT_ID = B.OBJECT_ID)
    WHEN NOT MATCHED THEN
      INSERT
        (OBJECT_ID, COUNT_PLACE_ID, GROUP_NUM)
      VALUES
        (B.OBJECT_ID, B.COUNT_PLACE_ID, B.GROUP_NUM);
 
    -- �������������� ���������, ���������� ������������ ������ ������� �� ���� ��������
    select floor (sum(count_place_id) / v_bucket_cnt) + 1
      into v_bucket_max_num
      from test_terra_balance_prep2;
 
    for i in 1 .. v_bucket_cnt loop
   
      v_bucket_cur_num := i;
      --v_bucket_cur_sum := 0;
      -- ���������� ��������� �������� ��� �������������� �������� �� �������!
      select sum (count_place_id)
        into v_bucket_cur_sum
        from test_terra_balance_prep2
       where group_num = i;
   
      fill_end_of_bucket;
   
    end loop ;
    -------------------------------------------------------------------------------------
 
    -- ����������� ���������� �������
    MERGE INTO TEST_TERRA_BALANCE_PREP2 A
    USING (select object_id, count(PLACE_ID) count_place_id, 0 group_num
             from (select distinct pl.object_id, PL.PLACE_ID
                     from p_xpoint pxp, p_place pl
                    where pxp.place_id = pl.place_id
                      and pxp.arc_id = 0
                      and pl.arc_id = 0 )
            group by object_id) B
    ON (A.OBJECT_ID = B.OBJECT_ID)
    WHEN NOT MATCHED THEN
      INSERT
        (OBJECT_ID, COUNT_PLACE_ID, GROUP_NUM)
      VALUES
        (B.OBJECT_ID, B.COUNT_PLACE_ID, B.GROUP_NUM);
 
    -- �������������� ���������, ���������� ������������ ������ ������� �� ���� ��������
    select floor (sum(count_place_id) / v_bucket_cnt) + 1
      into v_bucket_max_num
      from test_terra_balance_prep2;
 
    for i in 1 .. v_bucket_cnt loop
   
      v_bucket_cur_num := i;
      --v_bucket_cur_sum := 0;
      -- ���������� ��������� �������� ��� �������������� �������� �� �������!
      select sum (count_place_id)
        into v_bucket_cur_sum
        from test_terra_balance_prep2
       where group_num = i;
   
      fill_end_of_bucket;
   
    end loop ;
 
  end;

  -- ���������� C_TERRA � OBJECT_TERRA
  DECLARE
    v_last_account_per_closed_id number;
  begin
 
    -- �������� ����������� ������������� �� ���� �����
    delete from object_terra
     where terra_id in (select terra_id
                          from c_terra c
                         where c.terra_type_id = 1
                           and arc_id = 0 );
 
    -- �������� ����� ����������
    insert into c_terra
      with terras as
       ( select NULL TERRA_ID_MAIN,
               1 TERRA_TYPE_ID,
               0 NEW_ID,
               0 ARC_ID,
               '�����-���������_' || (rownum) TERRA_NAME,
               '���' TERRA_SNAME,
               322 TERRA_ORG_UNIT_ID,
               null company_id
          from dual
         where rownum < V_ZONE_NUM
        connect by rownum = level)
      select SEQ_TERRA.nextval TERRA_ID,
             TERRA_ID_MAIN,
             TERRA_TYPE_ID,
             NEW_ID,
             ARC_ID,
             TERRA_NAME,
             TERRA_SNAME,
             TERRA_ORG_UNIT_ID,
             company_id
        from terras t
       where not exists
       ( select 1 from c_terra ct where CT.TERRA_NAME = t.terra_name);
 
    -- �������� ������ �������������
    insert into object_terra
      with terras as
       ( select terra_id, terra_name from c_terra where terra_type_id = 1),
      terra_balance as
       ( select object_id,
               decode(group_num,
                      V_ZONE_NUM,
                      '�����-���������' ,
                      '�����-���������_' || (group_num)) group_name
          from test_terra_balance_prep2)
      select seq_object_terra.nextval object_terra_id,
             ter.terra_id,
             ttbp.object_id,
             0,
             0
        from terra_balance ttbp
        join terras ter
          on ter.terra_name = ttbp.group_name;
 
  end;

end;
