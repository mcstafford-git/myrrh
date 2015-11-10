DROP PROCEDURE IF EXISTS revoke_db;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE revoke_db(
  p_role_name varchar(32)
, p_db_name varchar(32)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

   update role_dbs
   set status = 'inactive'
   where db_name = p_db_name
   and role_name = p_role_name;

   select *
   from role_dbs
   where db_name = p_db_name
   and role_name = p_role_name;

end;
//

DELIMITER ;

