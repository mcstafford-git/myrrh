DROP PROCEDURE IF EXISTS desc_role;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE desc_role(
  p_role_name varchar(32)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

select * from roles where role_name = p_role_name;
select * from role_roles where role_name = p_role_name;
select * from role_users where role_name = p_role_name;
select * from role_dbs where role_name = p_role_name;
select * from role_privs where role_name = p_role_name;

end;
//

DELIMITER ;

