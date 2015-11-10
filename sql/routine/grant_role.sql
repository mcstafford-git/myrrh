DROP PROCEDURE IF EXISTS grant_role;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE grant_role(
  p_parent_name varchar(32)
, p_child_name  varchar(16)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

-- confirm p_child_name exists in only one role, user or role
declare l_role_count int unsigned;
declare l_user_count int unsigned;

select sum( d.role_count ) role_count, sum( d.user_count ) user_count
into l_role_count, l_user_count
from (
  select count(1) role_count, 0 user_count from roles r where r.role_name IN( p_parent_name,p_child_name )
  union all
  select 0 role_count, count(1) user_count from users u where u.user_name IN( p_parent_name,p_child_name )
) d;

if l_role_count + l_user_count = 2 then
  if l_role_count = 1 then
    call grant_role_user( p_parent_name , p_child_name );
  else
    call grant_role_role( p_parent_name , p_child_name );
  end if;
else
  -- both of these "calls" are intentionally non-existent
  if l_role_count + l_user_count > 1 then
    call error_name_conflict();
  else
    call error_invalid_parent();
  end if;
end if;

end;
//

DELIMITER ;

