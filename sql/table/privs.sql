SET foreign_key_checks = 0;

DROP TABLE IF EXISTS privs;

CREATE TABLE privs (
  id int(6) unsigned NOT NULL AUTO_INCREMENT
, priv_name varchar(32) NOT NULL
, priv_type set( 'column','user','host','meta','db','table' ) NOT NULL
, column_name varchar(41) NOT NULL
, ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
, PRIMARY KEY (id)
, UNIQUE KEY idx_privs_name (priv_name)
, UNIQUE KEY idx_privs_col_name (column_name)
, INDEX idx_privs_ts (ts)
) ENGINE=InnoDB;

SET foreign_key_checks = 0;

