DROP PROCEDURE IF EXISTS desc_results;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE desc_results()
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
proc: begin

declare l_not_found tinyint(1) unsigned default 0;
declare l_user_name varchar(16);
declare l_db_name0 varchar(41);
declare l_db_name1 varchar(41);
declare l_should_be varchar(512);
declare l_column_names varchar(512);
declare l_granted_y varchar(512);
declare l_granted_n varchar(512);

-- todo: check that no users exist except per results
-- todo: check that no role_users exist except per results

declare u cursor for
  select distinct user_name from results order by 1;

declare g cursor for
  select
    '*' db_name /* checks `*` against mysql.user  */
  , case when r.priv_name is null then 'N' else 'Y' end should_be
  , group_concat( p.column_name order by p.id ) column_names
  from
    privs p
  left outer join
    results r
    on r.user_name = l_user_name
    and r.db_name = '*'
    and r.priv_name = p.priv_name
  where
    find_in_set('user,db',p.priv_type) > 0
  group by
    1, 2;

declare s cursor for
  select
    r.db_name /* checks r.db_name against mysql.db  */
  , case when r.priv_name is null then 'N' else 'Y' end should_be
  , group_concat( p.column_name order by p.id ) privs
  from
    privs p
  left outer join
    results r
    on r.user_name = l_user_name
    and r.db_name != '*'
    and r.priv_name = p.priv_name
  where
    p.priv_type = 'db' -- TODO: find_in_set
  group by
    1 desc, 2;

declare continue handler for not found
  set l_not_found = 1;

open u;
loop_u : loop

  fetch u into
    l_user_name;

  if l_not_found = 1 then
    leave loop_u;
  end if;

  -- audit setup   ============================================================
  -- <mysql.user>  ------------------------------------------------------------
  set l_granted_y := null, l_granted_n := null;

  open g;
  loop_g : loop

    fetch g into l_db_name0, l_should_be, l_column_names;

    if l_not_found = 1 then leave loop_g; end if;

    if l_should_be = 'Y' then set l_granted_y := l_column_names; end if;

    if l_should_be = 'N' then set l_granted_n := l_column_names; end if;

    set l_not_found = 0;

  end loop loop_g;
  close g;

  call audit_result( l_db_name0, l_user_name, l_granted_y, l_granted_n );
  -- </mysql.user> ------------------------------------------------------------

  -- <mysql.db>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  set l_granted_y := null, l_granted_n := null;

  open s;
  loop_s : loop

    fetch s into l_db_name0, l_should_be, l_column_names;

    if l_not_found = 1 then leave loop_s; end if;

    select 'loop_s', l_db_name0, l_should_be, l_column_names;

    if l_db_name0 is null then set l_db_name0 := l_db_name1; end if;

    select l_db_name0, l_should_be, l_column_names;

    if l_should_be = 'Y' then set l_granted_y := l_column_names; end if;
    leave proc;

    if l_should_be = 'N' then set l_granted_n := l_column_names; end if;

    select 'loop_s', l_db_name0, l_user_name, l_granted_y, l_granted_n;

    set l_not_found = 0, l_db_name1 := l_db_name0;

  end loop loop_s;
  close s;

  select 'you keep using that word...' inconceivable;
  call audit_result( l_db_name0, l_user_name, l_granted_y, l_granted_n );
  -- </mysql.db>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  set l_not_found = 0;

end loop loop_u;
close u;

set @sql := null, l_granted_y := null, l_granted_n := null;

end;
//

DELIMITER ;

