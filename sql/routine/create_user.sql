DROP PROCEDURE IF EXISTS create_user;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE create_user(
 p_user_name varchar(16)
,p_password char(41)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

insert into users(user_name,password,status)
  values(p_user_name,p_password,'active');

select * from users where user_name = p_user_name;

end;
//

DELIMITER ;

