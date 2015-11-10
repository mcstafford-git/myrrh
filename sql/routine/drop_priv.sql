DROP PROCEDURE IF EXISTS drop_priv;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE drop_priv(
 p_priv_name varchar(32)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

-- delete from privs where priv_name = p_priv_name;

end;
//

DELIMITER ;

