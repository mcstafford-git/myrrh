SET foreign_key_checks = 0;

drop table if exists myrrh;

create table if not exists myrrh (
  id int unsigned not null auto_increment primary key
, role_name varchar(32) not null
, connection_id int(10) unsigned not null
, grant_seq int(10) unsigned not null
, status enum('active','inactive') NOT NULL DEFAULT 'inactive'
, key idx_conn_role1 (role_name)
, unique key idx_conn_role2 (role_name,connection_id)
, constraint foreign key fk_myrrh_role_name (role_name) references roles (role_name) on update cascade
) engine = innodb;

SET foreign_key_checks = 0;

