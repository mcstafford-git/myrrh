SET foreign_key_checks = 0;

DROP TABLE IF EXISTS role_roles;

CREATE TABLE role_roles (
  id int(6) unsigned NOT NULL AUTO_INCREMENT
, parent_name varchar(32) NOT NULL
, child_name varchar(32) NOT NULL
, status enum('active','inactive') NOT NULL DEFAULT 'inactive'
, ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
, PRIMARY KEY (id)
, UNIQUE KEY idx_role_roles_parent_child (parent_name,child_name)
, KEY idx_child_status (child_name,status)
, INDEX idx_role_roles_ts (ts)
, CONSTRAINT fk_parent_roles FOREIGN KEY (parent_name) REFERENCES roles (role_name)
    ON UPDATE CASCADE
, CONSTRAINT fk_child_roles FOREIGN KEY (child_name) REFERENCES roles (role_name)
    ON UPDATE CASCADE
) ENGINE=InnoDB;

SET foreign_key_checks = 1;

