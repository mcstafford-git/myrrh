SET foreign_key_checks = 0;

truncate table privs;

INSERT IGNORE INTO privs (priv_name,priv_type,column_name) VALUES
    ( 'select'                   , 'db,host,user'  , 'select_priv'            )
  , ( 'insert'                   , 'db,host,user'  , 'insert_priv'            )
  , ( 'update'                   , 'db,host,user'  , 'update_priv'            )
  , ( 'delete'                   , 'db,host,user'  , 'delete_priv'            )
  , ( 'create'                   , 'db,host,user'  , 'create_priv'            )
  , ( 'drop'                     , 'db,host,user'  , 'drop_priv'              )
  , ( 'references'               , 'db,host,user'  , 'references_priv'        )
  , ( 'index'                    , 'db,host,user'  , 'index_priv'             )
  , ( 'alter'                    , 'db,host,user'  , 'alter_priv'             )
  , ( 'create temporary tables'  , 'db,host,user'  , 'create_tmp_table_priv'  )
  , ( 'lock tables'              , 'db,host,user'  , 'lock_tables_priv'       )
  , ( 'execute'                  , 'db,host,user'  , 'execute_priv'           )
  , ( 'create view'              , 'db,host,user'  , 'create_view_priv'       )
  , ( 'show view'                , 'db,host,user'  , 'show_view_priv'         )
  , ( 'create routine'           , 'db,host,user'  , 'create_routine_priv'    )
  , ( 'alter routine'            , 'db,host,user'  , 'alter_routine_priv'     )
  , ( 'event'                    , 'db,user'       , 'event_priv'             )
  , ( 'trigger'                  , 'db,host,user'  , 'trigger_priv'           )
  , ( 'reload'                   , 'user'          , 'reload_priv'            )
  , ( 'shutdown'                 , 'user'          , 'shutdown_priv'          )
  , ( 'process'                  , 'user'          , 'process_priv'           )
  , ( 'file'                     , 'user'          , 'file_priv'              )
  , ( 'show databases'           , 'user'          , 'show_db_priv'           )
  , ( 'super'                    , 'user'          , 'super_priv'             )
  , ( 'replication client'       , 'user'          , 'repl_client_priv'       )
  , ( 'replication slave'        , 'user'          , 'repl_slave_priv'        )
  , ( 'create user'              , 'user'          , 'create_user_priv'       )
  , ( 'usage'                    , 'meta'          , 'usage_priv'             )
  , ( 'all privileges'           , 'meta'          , 'all_priv'               )
  , ( 'with grant option'        , 'db,host,user'  , 'grant_priv'             )
  , ( 'column'                   , 'column,table'  , 'column_priv'            )
;

/*
  # omitted by design?

  All is syntactically convenient and usage was necessary prior to
  create user syntax, but neither align cleanly with the current
  state of this system.

  The grant privilege probably should be included here soon,
  but that is probably going to wait for now.

*/

insert into sequences( seq_name ) values ('grant');

SET foreign_key_checks = 1;

