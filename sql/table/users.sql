SET foreign_key_checks = 0;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id int(6) unsigned NOT NULL AUTO_INCREMENT
, user_name varchar(16) NOT NULL
, password char(41) DEFAULT NULL
, status enum('active','inactive') NOT NULL DEFAULT 'inactive'
, ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
, PRIMARY KEY (id)
, UNIQUE KEY idx_users_name (user_name)
, INDEX idx_users_ts (ts)
) ENGINE=InnoDB AUTO_INCREMENT=5;

SET foreign_key_checks = 1;

