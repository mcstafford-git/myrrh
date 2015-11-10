DROP PROCEDURE IF EXISTS create_db;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE create_db(
 p_db_name varchar(16)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

insert into dbs(db_name)
  values(p_db_name);

select * from dbs where db_name = p_db_name;

end;
//

DELIMITER ;

