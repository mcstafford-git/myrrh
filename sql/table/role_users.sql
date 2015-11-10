SET foreign_key_checks = 0;

DROP TABLE IF EXISTS role_users;

CREATE TABLE role_users (
  id int(6) unsigned NOT NULL AUTO_INCREMENT
, role_name varchar(32) NOT NULL
, user_name varchar(16) NOT NULL
, status enum('active','inactive') NOT NULL DEFAULT 'inactive'
, ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
, PRIMARY KEY (id)
, UNIQUE KEY idx_role_users_role (role_name,user_name)
, KEY idx_fk_role_users_users (user_name,status)
, INDEX idx_role_users_ts (ts)
-- , CONSTRAINT fk_meta_parent
, CONSTRAINT fk_role_users_roles FOREIGN KEY (role_name) REFERENCES roles (role_name)
    ON UPDATE CASCADE
, CONSTRAINT fk_role_users_users FOREIGN KEY (user_name) REFERENCES users (user_name)
    ON UPDATE CASCADE
) ENGINE=InnoDB;

SET foreign_key_checks = 1;

