DROP PROCEDURE IF EXISTS grant_priv;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE grant_priv(
 p_role_name varchar(32)
,p_priv_name varchar(32)
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
from role_privs
where priv_name = p_priv_name
and role_name = p_role_name;

if l_count = 0 then
  insert into role_privs( priv_name, role_name, status )
    values ( p_priv_name , p_role_name, 'active' );
else
  update role_privs
  set status = 'active'
  where priv_name = p_priv_name
  and role_name = p_role_name;
end if;

select *
from role_privs
where priv_name = p_priv_name
and role_name = p_role_name;

end;
//

DELIMITER ;

