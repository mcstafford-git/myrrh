DROP PROCEDURE IF EXISTS create_priv;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE create_priv(
 p_priv_name varchar(32)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

insert into privs(priv_name)
  values(p_priv_name);

select * from privs where priv_name = p_priv_name;

end;
//

DELIMITER ;

