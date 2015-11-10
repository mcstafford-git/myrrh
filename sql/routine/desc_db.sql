DROP PROCEDURE IF EXISTS desc_db;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE desc_db(
 p_db_name varchar(16)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

select * from dbs where db_name = p_db_name;
select * from role_dbs where db_name = p_db_name;

end;
//

DELIMITER ;

