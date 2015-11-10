select group_concat( p.column_name order by p.id )
into @columns
from privs p
where find_in_set( 'db', p.priv_type ) > 0;

drop view if exists mysql_dbs;

select concat(
  'create definer=myrrh@localhost view mysql_dbs as '
  ,'select d.user user_name, d.host host_name, d.db db_name,'
  ,'concat(''',@@version_comment,' ',@@version,''')',' privs_version'
  ,', concat(d.',replace(@columns,',',',d.'),') db_privs'
  ,' from mysql.db d;'
) into @sql;

call execute_dynamic( 0, @sql, null, null, null );

set @sql := null;

