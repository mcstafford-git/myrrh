SET foreign_key_checks = 0;

DROP TABLE IF EXISTS role_privs;

CREATE TABLE role_privs (
  id int(6) unsigned NOT NULL AUTO_INCREMENT
, role_name varchar(32) NOT NULL
, priv_name varchar(32) NOT NULL
, status enum('active','inactive') NOT NULL DEFAULT 'inactive'
, ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
, PRIMARY KEY (id)
, UNIQUE KEY idx_role_privs_names (role_name,priv_name)
, KEY idx_rp_priv (priv_name,status)
, INDEX idx_role_privs_ts (ts)
, CONSTRAINT fk_rp_privs FOREIGN KEY (priv_name) REFERENCES privs (priv_name)
    ON UPDATE CASCADE
, CONSTRAINT fk_rp_roles FOREIGN KEY (role_name) REFERENCES roles (role_name)
    ON UPDATE CASCADE
) ENGINE=InnoDB;

SET foreign_key_checks = 1;

