DROP PROCEDURE IF EXISTS apply_user;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE apply_user(
  p_user_name varchar(16)
, p_actually_apply boolean
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
begin

-- TODO: extend parsing to allow for 'with grant option'

declare l_not_found tinyint(1) unsigned;

declare l_sql_warnings tinyint(1) unsigned;
declare l_sql_notes tinyint(1) unsigned;
declare l_group_concat_max_len bigint(20) unsigned;

declare l_id int(10) unsigned;
declare l_grant_seq int(10) unsigned;
declare l_grant_syntax varchar(2048);
declare l_user_name varchar(16);
declare l_host_name varchar(60);
declare l_db_name varchar(16);

declare c cursor for 
  select
    s.id
  , s.user_name
  , s.host_name
  , s.db_name
  , s.grant_syntax
  from results_staging s
  where s.grant_seq = l_grant_seq;

declare continue handler for not found
  set l_not_found = 1;

select
  @@sql_warnings, @@sql_notes, @@group_concat_max_len
into
  l_sql_warnings, l_sql_notes, l_group_concat_max_len
;

set
  group_concat_max_len := 9999
, sql_warnings := 0
, sql_notes := 0
;

set
  l_grant_seq := sequence( 'grant' )
;

call myrrh( p_user_name , l_grant_seq );

SELECT s.grant_syntax
FROM results_staging s
WHERE s.grant_seq = l_grant_seq;

if p_actually_apply then

  if ( p_actually_apply ) and (
    select count(1)
    from mysql.user
    where user = p_user_name
    and host = '%'
  ) > 0
  then
    call execute_dynamic(
      l_grant_seq
    , concat('DROP USER ',p_user_name)
    , l_user_name
    , '%'
    , null
    );
  end if;

  open c;
  loop_c : loop

    set l_not_found := 0, @sql := null;

    fetch c into
      l_id
    , l_user_name
    , l_host_name
    , l_db_name
    , l_grant_syntax;

    if l_not_found then
      leave loop_c;
    end if;

    call execute_dynamic(
      l_grant_seq
    , l_grant_syntax
    , l_user_name
    , l_host_name
    , l_db_name
    );

    set l_not_found = 0;

  end loop loop_c;
  close c;

  -- arguably not necessary...
  call execute_dynamic(
    l_grant_seq
  , 'FLUSH PRIVILEGES'
  , l_user_name
  , null
  , null
  ) ;

  update results r
  join mysql_users u
  using ( user_name, host_name )
  set
    r.user_privs = u.user_privs
  , r.privs_version = u.privs_version
  where r.db_name = '*'
  and r.grant_seq = l_grant_seq;

  update results r
  join mysql_dbs d
  using ( user_name, host_name, db_name )
  set
    r.db_privs = d.db_privs
  , r.privs_version = d.privs_version
  where r.grant_seq = l_grant_seq;

end if; -- p_actually_apply

delete from results_staging where grant_seq = l_grant_seq;

set
  sql_warnings         := l_sql_warnings
, sql_notes            := l_sql_notes
, group_concat_max_len := l_group_concat_max_len
;

end;
//

DELIMITER ;

