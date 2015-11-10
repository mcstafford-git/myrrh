SET foreign_key_checks = 0;

DROP TABLE IF EXISTS role_dbs;

CREATE TABLE role_dbs (
  id int(6) unsigned NOT NULL AUTO_INCREMENT
, role_name varchar(32) NOT NULL
, db_name varchar(16) NOT NULL
, status enum('active','inactive') NOT NULL DEFAULT 'inactive'
, ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
, PRIMARY KEY (id)
, UNIQUE KEY idx_role_dbs_names (role_name,db_name)
, KEY idx_rd_dbs (db_name)
, INDEX idx_role_dbs_ts (ts)
, CONSTRAINT fk_rd_dbs FOREIGN KEY (db_name) REFERENCES dbs (db_name)
    ON UPDATE CASCADE
, CONSTRAINT fk_rd_roles FOREIGN KEY (role_name) REFERENCES roles (role_name)
    ON UPDATE CASCADE
) ENGINE=InnoDB;

SET foreign_key_checks = 1;

