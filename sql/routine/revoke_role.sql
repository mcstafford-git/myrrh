DROP PROCEDURE IF EXISTS revoke_role;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE revoke_role(
  p_parent_name varchar(32)
, p_child_name varchar(16)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

   update role_users
   set status = 'inactive'
   where role_name = p_parent_name
   and user_name = p_child_name;

   select *
   from role_users
   where role_name = p_parent_name
   and user_name = p_child_name;

   update role_roles
   set status = 'inactive'
   where parent_name = p_parent_name
   and child_name = p_child_name;

   select *
   from role_roles
   where parent_name = p_parent_name
   and child_name = p_child_name;

end;
//

DELIMITER ;

