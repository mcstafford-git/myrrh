DROP PROCEDURE IF EXISTS list_role_users;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE list_role_users(
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

select * from role_users;

end;
//

DELIMITER ;

