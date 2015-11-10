DROP PROCEDURE IF EXISTS apply_everything;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE apply_everything(
  p_actually_apply boolean
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

declare l_role_name varchar(32);
declare l_not_found tinyint(1) unsigned;
declare l_sql_warnings varchar(16);
declare l_group_concat_max_len int unsigned;

declare c cursor for
  select role_name
  from role_users
  where status = 'active'
  group by 1;

declare continue handler for not found
  set l_not_found = 1;

set
  l_sql_warnings         := @@sql_warnings
, l_group_concat_max_len := @@group_concat_max_len
, group_concat_max_len   := 9999;

select @@sql_warnings into l_sql_warnings;
set sql_warnings = 0;

SELECT
  concat(
    'Found '
  , count( distinct role_name )
  ,' role(s): '
  , group_concat( distinct role_name order by 1 )
  ) every_info
FROM
  role_users
WHERE
  status = 'active';

open c;
loop_c : loop
  fetch c into l_role_name;

  if l_not_found = 1 then
    leave loop_c;
  end if;

  call apply_role( l_role_name , p_actually_apply );

  SET l_not_found = 0;

end loop loop_c;
close c;

set sql_warnings = l_sql_warnings
, group_concat_max_len := l_group_concat_max_len;

end;
//

DELIMITER ;

