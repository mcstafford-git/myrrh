DROP PROCEDURE IF EXISTS list_privs;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE list_privs(
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

select * from privs;

end;
//

DELIMITER ;

