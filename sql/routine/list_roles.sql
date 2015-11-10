DROP PROCEDURE IF EXISTS list_roles;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE list_roles(
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

select * from roles;

end;
//

DELIMITER ;

