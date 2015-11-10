drop procedure if exists execute_dynamic;

delimiter //

create definer=myrrh@localhost
procedure execute_dynamic(
  p_grant_seq int(10) unsigned
, p_sql varchar(8000)
, P_user_name varchar(16)
, P_host_name varchar(60)
, P_db_name varchar(16)
)
not deterministic
reads sql data
sql security invoker
begin

  if p_sql is not null then
    insert into results(
      grant_seq
    , grant_syntax
    , user_name
    , host_name
    , db_name
    , creator
    )
    select
      p_grant_seq
    , p_sql
    , p_user_name
    , p_host_name
    , p_db_name
    , user()
    ;
    set @exec_dyn := p_sql;
    prepare exec_dyn from @exec_dyn;
    execute exec_dyn;
    drop prepare exec_dyn;
    set @exec_dyn := null;
  end if;

end;
//

delimiter ;

