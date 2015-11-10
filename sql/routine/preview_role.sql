DROP PROCEDURE IF EXISTS preview_role;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE preview_role(
  p_role_name varchar(32)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

  call apply_role(  p_role_name , false );

end;
//

DELIMITER ;

