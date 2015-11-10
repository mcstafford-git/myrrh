DROP PROCEDURE IF EXISTS drop_db;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE drop_db(
 p_db_name varchar(16)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

-- delete from dbs where db_name = p_db_name;

end;
//

DELIMITER ;

