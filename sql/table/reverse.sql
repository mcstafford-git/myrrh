SET foreign_key_checks = 0;

DROP TABLE IF EXISTS reverse;

CREATE TABLE reverse(
  id int(6) unsigned NOT NULL AUTO_INCREMENT
, role_name varchar(32) NOT NULL
, db_name varchar(16) NOT NULL
, priv_name varchar(32) NOT NULL
, ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
, PRIMARY KEY (id)
, UNIQUE KEY idx_reverse (role_name,db_name,priv_name)
, KEY idx_rev_dbs (db_name)
, KEY idx_rev_prs (priv_name)
, INDEX idx_rev_ts (ts)
) ENGINE=InnoDB;

SET foreign_key_checks = 1;

