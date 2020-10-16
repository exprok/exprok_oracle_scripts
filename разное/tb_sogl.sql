--select d.fname, d.lname, tn, ceh, login, guid, inn from w_puz.t_user_ad_dop d where d.login='112konst'
select * from w_kart_razr.tb_sogl ts nwhere ts.id_sogl = (select guid from w_puz.t_user_ad_dop d where d.login='018tulbaev')
--union
--select d.fname, d.lname, tn, ceh, login, guid, inn from w_puz.t_user_ad_dop d where d.login='133konst'

--update w_kart_group.tb_sogl s set s.Id_Sogl = (select guid from w_puz.t_user_ad_dop d where d.login='133konst') where s.id_sogl =(select guid from w_puz.t_user_ad_dop d where d.login='112konst')
