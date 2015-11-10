SET foreign_key_checks = 0;

DROP TABLE IF EXISTS dbs;

CREATE TABLE dbs (
  id int(6) unsigned NOT NULL AUTO_INCREMENT
, db_name varchar(16) NOT NULL
, ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
, PRIMARY KEY (id)
, UNIQUE KEY idx_db_name (db_name)
, INDEX idx_dbs_ts (ts)
) ENGINE=InnoDB;

SET foreign_key_checks = 0;

