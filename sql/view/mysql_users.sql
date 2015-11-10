select group_concat( p.column_name order by p.id )
into @columns
from privs p
where find_in_set( 'user', p.priv_type ) > 0;

drop view if exists mysql_users;

select concat(
  'create definer=myrrh@localhost view mysql_users as'
  ,' select u.user user_name, u.host host_name,'
  ,'concat(''',@@version_comment,' ',@@version,''')',' privs_version'
  ,', concat(u.',replace(@columns,',',',u.'),') user_privs'
  ,' from mysql.user u;'
) into @sql;

call execute_dynamic( 0, @sql, null, null, null );

set @sql := null;

