DROP PROCEDURE IF EXISTS desc_user;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE desc_user(
 p_user_name varchar(16)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

select * from users where user_name = p_user_name;
select * from role_users where user_name = p_user_name;

end;
//

DELIMITER ;

