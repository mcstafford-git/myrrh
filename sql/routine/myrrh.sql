drop procedure if exists myrrh;

delimiter //

create procedure myrrh(
  p_user_name varchar(32)
, p_grant_seq int(10) unsigned
)

-- is there a conflict between the name of the table and that of the procedure?

begin

  -- remove my previous runs
  delete from myrrh
  where connection_id = connection_id();

  -- remove orphaned runs
  delete r.*
  from myrrh r
  left join information_schema.processlist l
  on l.id = r.connection_id
  where l.id is null;

  -- add 1st-level roles
  insert into myrrh(role_name, connection_id, grant_seq, status)
  select r.role_name, connection_id(), p_grant_seq, r.status
  from role_users r
  where r.status = 'active'
  and r.user_name = p_user_name;

  -- recursively add child role(s)
  while row_count() > 0 do
    insert ignore into myrrh(role_name, connection_id, grant_seq, status)
    select rr.child_name role_name,connection_id(),p_grant_seq,rr.status
    from role_roles rr
    join myrrh t
    on t.role_name = rr.parent_name
    where rr.status = 'active';
  end while;

  insert into results_staging(
    grant_seq
  , user_name
  , grant_hash
  , role_names
  , db_name
  , host_name
  , creator
  , grant_syntax
  )
  select
    p_grant_seq
  , d2.user_name
  , sha1( concat( d2.privs , d2.db_name )) grant_hash
  , d2.role_names
  , d2.db_name
  , d2.host_name
  , user() creator
  , concat(
      'GRANT ',d2.privs ,' ON ' ,d2.dbdotstar
      ,' TO ''',d2.user_name,'''@''',d2.host_name,''''
      , case d2.db_name when '*' then concat( ' IDENTIFIED BY PASSWORD ','''',u.password,'''' ) else '' end
    ) grant_syntax
  from (
    select
      p_user_name user_name
    , group_concat( distinct d1.role_name order by 1 ) role_names
    , d1.db_name
    , '%' host_name
    , upper(replace(group_concat( p.priv_name order by p.id ),',',', ')) privs
    , concat( d1.wrapper , d1.db_name , d1.wrapper , '.*' ) dbdotstar
    from (
      select
        m.role_name
      , m.status
      , p.priv_name
      , case when p.priv_type in( 'meta','user') then '*' else rd.db_name end db_name
      , case when p.priv_type in( 'meta','user') then '' else '`' end wrapper
      from myrrh m
      join role_dbs rd using ( role_name , status )
      join role_privs rp using ( role_name , status )
      join privs p using ( priv_name )
      where m.connection_id = connection_id()
      and grant_seq = p_grant_seq
    ) d1
    join
      privs p using ( priv_name )
    left join
      role_users ru using ( role_name, status )
    group by
      d1.status, d1.db_name
  ) d2
  join
    users u using ( user_name );

end;
//

delimiter ;

