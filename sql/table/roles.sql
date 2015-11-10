SET foreign_key_checks = 0;

DROP TABLE IF EXISTS roles;

CREATE TABLE roles (
  id int(6) unsigned NOT NULL AUTO_INCREMENT
, role_name varchar(32) NOT NULL
, status enum('active','inactive') NOT NULL DEFAULT 'inactive'
, ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
, PRIMARY KEY (id)
, UNIQUE KEY idx_roles_names (role_name)
, INDEX idx_roles_ts (ts)
) ENGINE=InnoDB;

SET foreign_key_checks = 1;

