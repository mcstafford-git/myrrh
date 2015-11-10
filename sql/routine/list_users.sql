DROP PROCEDURE IF EXISTS list_users;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE list_users(
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

select * from users;

end;
//

DELIMITER ;

