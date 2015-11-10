DROP PROCEDURE IF EXISTS desc_priv;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE desc_priv(
 p_priv_name varchar(32)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

select * from privs where priv_name = p_priv_name;
select * from role_privs where priv_name = p_priv_name;

end;
//

DELIMITER ;

