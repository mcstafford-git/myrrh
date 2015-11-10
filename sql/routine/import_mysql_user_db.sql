DROP PROCEDURE IF EXISTS import_mysql_user_db;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE import_mysql_user_db(
  p_user_name varchar(16)
, p_db_name varchar(16)
, p_role_name varchar(32)
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

  declare l_role_name varchar(32) default p_role_name;

  if( l_role_name is null ) then
    -- NOTE: this is a hack baseed upon a two-character prefix naming system
    set l_role_name := upper( concat( p_user_name, '_' , p_db_name ));
  end if;

  truncate table reverse;

  -- transpose privileges from columns to records
  insert ignore into reverse( role_name, db_name, priv_name )
        select l_role_name, '*'  db_name, 'usage'                   priv_name from mysql.user t where t.user = p_user_name and p_db_name               = '*'
  union select l_role_name, '*'  db_name, 'select'                  priv_name from mysql.user t where t.user = p_user_name and t.select_priv           = 'Y'
  union select l_role_name, '*'  db_name, 'insert'                  priv_name from mysql.user t where t.user = p_user_name and t.insert_priv           = 'Y'
  union select l_role_name, '*'  db_name, 'update'                  priv_name from mysql.user t where t.user = p_user_name and t.update_priv           = 'Y'
  union select l_role_name, '*'  db_name, 'delete'                  priv_name from mysql.user t where t.user = p_user_name and t.delete_priv           = 'Y'
  union select l_role_name, '*'  db_name, 'create'                  priv_name from mysql.user t where t.user = p_user_name and t.create_priv           = 'Y'
  union select l_role_name, '*'  db_name, 'drop'                    priv_name from mysql.user t where t.user = p_user_name and t.drop_priv             = 'Y'
  union select l_role_name, '*'  db_name, 'references'              priv_name from mysql.user t where t.user = p_user_name and t.references_priv       = 'Y'
  union select l_role_name, '*'  db_name, 'index'                   priv_name from mysql.user t where t.user = p_user_name and t.index_priv            = 'Y'
  union select l_role_name, '*'  db_name, 'alter'                   priv_name from mysql.user t where t.user = p_user_name and t.alter_priv            = 'Y'
  union select l_role_name, '*'  db_name, 'create temporary tables' priv_name from mysql.user t where t.user = p_user_name and t.create_tmp_table_priv = 'Y'
  union select l_role_name, '*'  db_name, 'lock tables'             priv_name from mysql.user t where t.user = p_user_name and t.lock_tables_priv      = 'Y'
  union select l_role_name, '*'  db_name, 'execute'                 priv_name from mysql.user t where t.user = p_user_name and t.execute_priv          = 'Y'
  union select l_role_name, '*'  db_name, 'create view'             priv_name from mysql.user t where t.user = p_user_name and t.create_view_priv      = 'Y'
  union select l_role_name, '*'  db_name, 'show view'               priv_name from mysql.user t where t.user = p_user_name and t.show_view_priv        = 'Y'
  union select l_role_name, '*'  db_name, 'create routine'          priv_name from mysql.user t where t.user = p_user_name and t.create_routine_priv   = 'Y'
  union select l_role_name, '*'  db_name, 'alter routine'           priv_name from mysql.user t where t.user = p_user_name and t.alter_routine_priv    = 'Y'
  union select l_role_name, '*'  db_name, 'event'                   priv_name from mysql.user t where t.user = p_user_name and t.event_priv            = 'Y'
  union select l_role_name, '*'  db_name, 'trigger'                 priv_name from mysql.user t where t.user = p_user_name and t.trigger_priv          = 'Y'
  union select l_role_name, '*'  db_name, 'reload'                  priv_name from mysql.user t where t.user = p_user_name and t.reload_priv           = 'Y'
  union select l_role_name, '*'  db_name, 'shutdown'                priv_name from mysql.user t where t.user = p_user_name and t.shutdown_priv         = 'Y'
  union select l_role_name, '*'  db_name, 'process'                 priv_name from mysql.user t where t.user = p_user_name and t.process_priv          = 'Y'
  union select l_role_name, '*'  db_name, 'file'                    priv_name from mysql.user t where t.user = p_user_name and t.file_priv             = 'Y'
  union select l_role_name, '*'  db_name, 'show databases'          priv_name from mysql.user t where t.user = p_user_name and t.show_db_priv          = 'Y'
  union select l_role_name, '*'  db_name, 'super'                   priv_name from mysql.user t where t.user = p_user_name and t.super_priv            = 'Y'
  union select l_role_name, '*'  db_name, 'replication slave'       priv_name from mysql.user t where t.user = p_user_name and t.repl_slave_priv       = 'Y'
  union select l_role_name, '*'  db_name, 'replication client'      priv_name from mysql.user t where t.user = p_user_name and t.repl_client_priv      = 'Y'
  union select l_role_name, '*'  db_name, 'create user'             priv_name from mysql.user t where t.user = p_user_name and t.create_user_priv      = 'Y'
  union select l_role_name, t.db db_name, 'select'                  priv_name from mysql.db t   where t.user = p_user_name and t.select_priv           = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'insert'                  priv_name from mysql.db t   where t.user = p_user_name and t.insert_priv           = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'update'                  priv_name from mysql.db t   where t.user = p_user_name and t.update_priv           = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'delete'                  priv_name from mysql.db t   where t.user = p_user_name and t.delete_priv           = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'create'                  priv_name from mysql.db t   where t.user = p_user_name and t.create_priv           = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'drop'                    priv_name from mysql.db t   where t.user = p_user_name and t.drop_priv             = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'references'              priv_name from mysql.db t   where t.user = p_user_name and t.references_priv       = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'index'                   priv_name from mysql.db t   where t.user = p_user_name and t.index_priv            = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'alter'                   priv_name from mysql.db t   where t.user = p_user_name and t.alter_priv            = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'create temporary tables' priv_name from mysql.db t   where t.user = p_user_name and t.create_tmp_table_priv = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'lock tables'             priv_name from mysql.db t   where t.user = p_user_name and t.lock_tables_priv      = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'execute'                 priv_name from mysql.db t   where t.user = p_user_name and t.execute_priv          = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'create view'             priv_name from mysql.db t   where t.user = p_user_name and t.create_view_priv      = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'show view'               priv_name from mysql.db t   where t.user = p_user_name and t.show_view_priv        = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'create routine'          priv_name from mysql.db t   where t.user = p_user_name and t.create_routine_priv   = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'alter routine'           priv_name from mysql.db t   where t.user = p_user_name and t.alter_routine_priv    = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'event'                   priv_name from mysql.db t   where t.user = p_user_name and t.event_priv            = 'Y' and t.db = p_db_name
  union select l_role_name, t.db db_name, 'trigger'                 priv_name from mysql.db t   where t.user = p_user_name and t.trigger_priv          = 'Y' and t.db = p_db_name
  ;

  insert ignore into roles( role_name,status )
  select role_name,'active' status
  from reverse
  group by 1;

  insert ignore into dbs( db_name )
  select db_name
  from reverse
  group by 1;

  -- if you're using this to manage your users the password values should come from mysql.user
  insert ignore into users( user_name,password,status )
  select p_user_name, password( concat('myrrh-',rand()) ) password,'active' status;

  insert ignore into role_dbs( role_name,db_name,status )
  select role_name,db_name,'active' status
  from reverse
  group by 1,2,3;

  insert ignore into role_privs( role_name,priv_name,status )
  select role_name,priv_name,'active' status
  from reverse
  group by 1,2,3;

  insert ignore into role_users( role_name,user_name,status )
  select role_name,p_user_name,'active' status
  from reverse
  group by 1,2,3;

end;

//

delimiter ;

