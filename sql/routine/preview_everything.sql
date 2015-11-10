DROP PROCEDURE IF EXISTS preview_everything;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE preview_everything(
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

  call apply_everything( false );

end;
//

DELIMITER ;

