DROP PROCEDURE IF EXISTS apply_role;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE apply_role(
  p_role_name varchar(32)
, p_actually_apply boolean
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

declare l_user_name varchar(16);
declare l_not_found tinyint(1) unsigned;
declare l_sql_warnings tinyint(1) unsigned;

declare c cursor for
  select user_name
  from role_users
  where role_name = p_role_name
  and status = 'active';

declare continue handler for not found
  set l_not_found = 1;

set
  l_sql_warnings := @@sql_warnings
, sql_warnings   := 0;

set p_actually_apply := coalesce(p_actually_apply, false);

SELECT
  concat(r
    'Found '
  , count( distinct user_name )
  , ' grant(s) of '
  , role_name, ': '
  , group_concat( distinct user_name order by 1 )
  ) role_info
FROM
  role_users
WHERE
  role_name = p_role_name
AND status = 'active'
GROUP BY
  role_name;

open c;

loop_c : loop
  fetch c into l_user_name;

  if l_not_found = 1 then
    leave loop_c;
  end if;

  call apply_user( l_user_name, p_actually_apply );

end loop loop_c;
close c;

set sql_warnings = l_sql_warnings;

end;
//

DELIMITER ;

