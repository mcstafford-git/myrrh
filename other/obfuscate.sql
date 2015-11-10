drop table if exists obfuscate;

create temporary table obfuscate(
  old_name varchar(16)
, new_name varchar(16)
) engine = innodb;

insert into obfuscate values 
 ( 'admin' ,'malcam1643'    ) ,( 'dev' ,'bufesk3657'      )
,( 'edit' ,'abaatt3991'     ) ,( 'load' ,'stiatt6014'     )
,( 'myrrh' ,'henbra2476'    ) ,( 'replicat' ,'sevjea2311' )
,( 'root' ,'chebra1002'     ) ,( 'see' ,'samash6442'      )
,( 'support' ,'boycoc1134'  ) ,( 'u0a' ,'boaamn8627'      )
,( 'u0b' ,'coocon5091'      ) ,( 'u0c' ,'iriaug4400'      )
,( 'u0d' ,'aniair3957'      ) ,( 'u0e' ,'kroham822'       )
,( 'u1a' ,'lenana1214'      ) ,( 'u1b' ,'chrcag334'       )
,( 'u1c' ,'beepal4495'      ) ,( 'u1d' ,'rammal607'       )
,( 'u1e' ,'ariact156'       ) ,( 'u2a' ,'cocbra1227'      )
,( 'u2b' ,'bacacq3766'      ) ,( 'u2c' ,'arsshe6278'      )
,( 'u2d' ,'copaki207'       ) ,( 'u2e' ,'corcho9700'      )
,( 'u3a' ,'saneur4672'      ) ,( 'u3b' ,'casmoh5786'      )
,( 'u3c' ,'aricor1737'      ) ,( 'u3d' ,'comeli6791'      )
,( 'u3e' ,'huggar2450'      ) ,( 'u4a' ,'oriche245'       )
,( 'u4b' ,'altrit6804'      ) ,( 'u4c' ,'wedcot4468'      )
,( 'u4d' ,'rosbut8443'      ) ,( 'u4e' ,'molana3668'      )
,( 'u5a' ,'jewguj2401'      ) ,( 'u5b' ,'ewiasp7389'      )
,( 'u5c' ,'antadj5098'      ) ,( 'u5d' ,'ancchi4749'      )
,( 'u5e' ,'cartho78'        ) ,( 'u6a' ,'lancar8752'      )
,( 'u6b' ,'nijcha4501'      ) ,( 'u6c' ,'kharae6375'      )
,( 'u6d' ,'dacpur5227'      ) ,( 'u6e' ,'batzen7458'      ) ;

update
  users u
join
  obfuscate o
on
  u.user_name like concat( o.old_name , '%' )
set
  u.user_name = o.new_name;

update
  roles r
join
  obfuscate o
on
  r.role_name like concat( o.old_name , '%' )
set
  r.role_name = replace( r.role_name , upper( o.old_name ), o.new_name )
;

drop table if exists obfuscate;

