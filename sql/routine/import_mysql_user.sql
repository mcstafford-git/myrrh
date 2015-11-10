drop procedure if exists import_mysql_user;

delimiter //

create DEFINER = myrrh@localhost
procedure import_mysql_user(
  p_user_name varchar(16)
)
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
import_mysql_user: begin

declare l_not_found tinyint(1) default 0;

declare l_db_name varchar(16);

-- NOTE: access to the mysql db should be tightly controlled.
-- If you understand the implications then please grant access
-- outside the import/reverse workflow... or re-define this
-- procedure after removing the restriction below.

declare c1 cursor for
  select d.db
  from mysql.db d
  where d.user = p_user_name
  and d.db != 'mysql'
  order by 1;

declare continue handler for not found
  set l_not_found = 1;

call import_mysql_user_db( p_user_name , '*' , null );

open c1;
loop_c1 : loop

  fetch c1 into l_db_name;

  if l_not_found then
    leave loop_c1;
  end if;

  call import_mysql_user_db( p_user_name , l_db_name , null);

  set l_not_found = 0;
end loop loop_c1;
close c1;

end;
//

delimiter ;

