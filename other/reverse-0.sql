source demo-0.sql;

-- this extends the data set beyond the users pictured in demo.txt.
-- it will cause some expected errors about rejected values in unique indexes.
set @suffix = 'a'; source reverse-1.sql;
set @suffix = 'b'; source reverse-1.sql;
set @suffix = 'c'; source reverse-1.sql;
set @suffix = 'd'; source reverse-1.sql;
set @suffix = 'e'; source reverse-1.sql;

set group_concat_max_len = 99999;

call import_mysql_user( 'administrator' ) ;
call import_mysql_user( 'developer' ) ;
call import_mysql_user( 'editor' ) ;
call import_mysql_user( 'loader' ) ;
call import_mysql_user( 'myrrh' ) ;
call import_mysql_user( 'replicator' ) ;
call import_mysql_user( 'root' ) ;
call import_mysql_user( 'seer' ) ;
call import_mysql_user( 'supporter' ) ;

-- add more data to make the reversal more interesting
set @i := 0; source reverse-2.sql;
set @i := 1; source reverse-2.sql;
set @i := 2; source reverse-2.sql;
set @i := 3; source reverse-2.sql;
set @i := 4; source reverse-2.sql;
set @i := 5; source reverse-2.sql;
set @i := 6; source reverse-2.sql;

-- it's rarely as cleanly done as the current results, so let's throw in a few oddities
call grant_priv( 'U2A_D2', 'trigger' );
call grant_db( 'U2A_D2', 'd3' );

call grant_priv( 'U0A_*', 'update' );
call grant_priv( 'U0A_*', 'drop' );

call grant_priv( 'U5A_D5', 'with grant option' );

-- This query's output is much more intuitive than the transposed content
-- of the related mysql dbs. The oddities from above show up in these
-- results with records = 1.

select
  d.privs
, group_concat ( d.role_name ) roles
, count ( 1 ) records
from (
  select
    rp.role_name
  , group_concat ( rp.priv_name order by 1 ) privs
  from
    role_privs rp
  group by
    rp.role_name
) d
group by
  d.privs
-- having records > 1
;
-- \G

-- the demo makes the data unusually clear
-- try running the update from obfuscate.sql
-- and then look at the output again

