DROP PROCEDURE IF EXISTS grant_db;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE grant_db(
 p_role_name varchar(32)
,p_db_name varchar(16)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

declare l_count tinyint(1) unsigned;

select count(1)
into l_count
from role_dbs
where role_name = p_role_name
and db_name = p_db_name;

if l_count = 0 then
  insert into role_dbs( db_name, role_name, status )
    values ( p_db_name , p_role_name, 'active' );
else
  update role_dbs
  set status = 'active'
  where role_name = p_role_name
  and db_name = p_db_name;
end if;

select l_count, t.*
from role_dbs t
where t.role_name = p_role_name
and t.db_name = p_db_name;

end;
//

DELIMITER ;

