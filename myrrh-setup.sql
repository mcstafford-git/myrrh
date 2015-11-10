-- avoid trouble with schema, charset and collation
select '# configuring db myrrh and current connection' info;
create schema if not exists myrrh;
alter schema myrrh
  character set = latin1
  collate = latin1_swedish_ci;
use myrrh;
set character_set_client = latin1, collation_connection = latin1_swedish_ci;

-- create myrrh-specific db user with three random timestamps as its password
select '# creating user myrrh@localhost' info;
set @ts := 'current_timestamp() -interval round(rand()*60*60*24*365*45,0) second';
set @c := ',', @q := '''';
set @s := concat( @q, ' ', @q );
set @ts := concat( @ts,@c,@s,@c,@ts,@c,@s,@c,@ts );
set @sql := concat( 'set @myrrh_passwd := concat( ', @ts, ')' );
prepare stmt from @sql;
execute stmt;
drop prepare stmt;
set @sql := concat(
  'grant all privileges on *.* to ', 'myrrh@localhost'
, ' identified by ',@q,@myrrh_passwd,@q,' with grant option'
);
-- uncomment this next line if you want a record of the password
-- select concat( '-- myrrh@localhost in myrrh identified by ''',@myrrh_passwd,'''' ) shh;
prepare stmt from @sql;
execute stmt;
drop prepare stmt;
set @sql := null;

select '# running table file(s) ' info;
source sql/table/dbs.sql;
source sql/table/myrrh.sql;
source sql/table/privs.sql;
source sql/table/results.sql;
source sql/table/results_staging.sql;
source sql/table/reverse.sql;
source sql/table/role_dbs.sql;
source sql/table/role_privs.sql;
source sql/table/role_roles.sql;
source sql/table/role_users.sql;
source sql/table/roles.sql;
source sql/table/sequences.sql;
source sql/table/users.sql;

select '# running routine file(s) ' info;
source sql/routine/apply_everything.sql;
source sql/routine/apply_role.sql;
source sql/routine/apply_user.sql;
source sql/routine/create_db.sql;
source sql/routine/create_priv.sql;
source sql/routine/create_role.sql;
source sql/routine/create_user.sql;
source sql/routine/crosstab.sql;
source sql/routine/desc_db.sql;
source sql/routine/desc_priv.sql;
source sql/routine/desc_results.sql;
source sql/routine/desc_role.sql;
source sql/routine/desc_user.sql;
source sql/routine/drop_db.sql;
source sql/routine/drop_priv.sql;
source sql/routine/drop_role.sql;
source sql/routine/drop_user.sql;
source sql/routine/execute_dynamic.sql;
source sql/routine/grant_db.sql;
source sql/routine/grant_priv.sql;
source sql/routine/grant_role.sql;
source sql/routine/grant_role_role.sql;
source sql/routine/grant_role_user.sql;
source sql/routine/header_outfile.sql;
source sql/routine/import_mysql_db.sql;
source sql/routine/import_mysql_user.sql;
source sql/routine/import_mysql_user_db.sql;
source sql/routine/list_dbs.sql;
source sql/routine/list_grants.sql;
source sql/routine/list_privs.sql;
source sql/routine/list_roles.sql;
source sql/routine/list_users.sql;
source sql/routine/myrrh.sql;
source sql/routine/populate_hierarchy.sql;
source sql/routine/preview_everything.sql;
source sql/routine/preview_role.sql;
source sql/routine/preview_user.sql;
source sql/routine/revoke_db.sql;
source sql/routine/revoke_priv.sql;
source sql/routine/revoke_role.sql;
source sql/routine/sequence.sql;

select '# running content file(s) ' info;
source sql/content.sql;

select '# running view file(s) ' info;
source sql/view/mysql_dbs.sql;
source sql/view/mysql_users.sql;


select '# status check' info;

select
  t.variable_name
, 'latin1' expectation
, t.variable_value result
from information_schema.session_variables t
where t.variable_name in( 'CHARACTER_SET_CONNECTION' ,'CHARACTER_SET_RESULTS' ,'CHARACTER_SET_DATABASE' ,'CHARACTER_SET_CLIENT' )
union
select
  t.variable_name
, 'latin1_swedish_ci' expectation
, t.variable_value result
from information_schema.session_variables t
where t.variable_name in( 'COLLATION_DATABASE' ,'COLLATION_CONNECTION' )
union
select 'MYRRH_DB'
, 'myrrh'
, schema();

show create database myrrh;

show grants for myrrh@localhost;

select t.table_name, t.table_type, t.table_collation, t.table_rows
from information_schema.tables t
where t.table_schema = 'myrrh';

select concat( @@version_comment,' ',@@version ) mysql_version;

