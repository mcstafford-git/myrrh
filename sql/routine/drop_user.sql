DROP PROCEDURE IF EXISTS drop_user;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE drop_user(
 p_user_name varchar(16)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

-- TODO: revoke any roles granted prior to attempting drop
-- delete from users where user_name = p_user_name;

end;
//

DELIMITER ;

