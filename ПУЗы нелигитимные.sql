select puz.ceh, puz.fname, puz.lname, puz.tn, kadr.FAM, kadr.name, kadr.otch, puz.uac , puz.last_logon
  from (select *
          from w_puz.t_user_ad_dop t
         where upper(tn) <> 'ярсдем'
           and inn is null) puz,
       w_kadr.v_person_inn kadr

 where puz.tn = kadr.tn(+)

 order by uac, fam
