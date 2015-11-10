DROP PROCEDURE IF EXISTS drop_role;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE drop_role(
 p_role_name varchar(32)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

-- delete from roles where role_name = p_role_name;

end;
//

DELIMITER ;

