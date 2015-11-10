DROP PROCEDURE IF EXISTS revoke_priv;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE revoke_priv(
  p_role_name varchar(32)
, p_priv_name varchar(32)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

   update role_privs
   set status = 'inactive'
   where priv_name = p_priv_name
   and role_name = p_role_name;

   select *
   from role_privs
   where priv_name = p_priv_name
   and role_name = p_role_name;

end;
//

DELIMITER ;

