DROP PROCEDURE IF EXISTS grant_role_user;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE grant_role_user(
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
from role_users
where role_name = p_parent_name
and user_name = p_child_name;

if l_count = 0 then
  insert into role_users( role_name, user_name, status )
    values ( p_parent_name, p_child_name, 'active' );
else
  update role_users
  set status = 'active'
  where role_name = p_parent_name
  and user_name = p_child_name;
end if;


select *
from role_users
where role_name = p_parent_name
and user_name = p_child_name;

end;
//

DELIMITER ;

