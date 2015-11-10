DROP PROCEDURE IF EXISTS create_role;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE create_role(
  p_role_name varchar(32)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

insert into roles(role_name,status)
  values(p_role_name,'active');

select *
from roles
where role_name = p_role_name;

end;
//

DELIMITER ;

