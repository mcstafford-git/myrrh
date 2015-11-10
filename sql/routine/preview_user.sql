DROP PROCEDURE IF EXISTS preview_user;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE preview_user(
  p_user_name varchar(16)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

  call apply_user( p_user_name , false );

end;
//

DELIMITER ;

