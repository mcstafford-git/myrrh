drop procedure if exists import_mysql_db;

delimiter //

create DEFINER = myrrh@localhost
procedure import_mysql_db(
  p_db_name varchar(16)
)
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
import_mysql_db: begin

declare l_not_found tinyint(1) default 0;

declare l_user_name varchar(16);

-- NOTE: access to the mysql db should be tightly controlled.
-- If you understand the implications then please grant access
-- outside the import/reverse workflow... or re-define this
-- procedure after removing the restriction below.

declare c cursor for
  select d.user
  from mysql.db d
  where d.db = p_db_name
  and d.db != 'mysql'
  order by 1;

declare continue handler for not found
  set l_not_found = 1;

open c;
loop_c : loop

  fetch c into l_user_name;

  if l_not_found then
    leave loop_c;
  end if;

  call import_mysql_user_db( l_user_name  , p_db_name, null );

  set l_not_found = 0;
end loop loop_c;
close c;

end;
//

delimiter ;

