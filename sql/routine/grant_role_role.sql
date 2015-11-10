DROP PROCEDURE IF EXISTS grant_role_role;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE grant_role_role(
  p_parent_name varchar(32)
, p_child_name varchar(16)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

declare l_count tinyint(1) unsigned;

select count(1)
into l_count
from role_roles
where parent_name = p_parent_name
and child_name = p_child_name;

if l_count = 0 then
  insert into role_roles( parent_name, child_name, status )
    values ( p_parent_name, p_child_name, 'active' );
else
  update role_roles
  set status = 'active'
  where parent_name = p_parent_name
  and child_name = p_child_name;
end if;


select *
from role_roles
where parent_name = p_parent_name
and child_name = p_child_name;

end;
//

DELIMITER ;

