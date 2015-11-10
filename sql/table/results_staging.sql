SET foreign_key_checks = 0;

DROP TABLE IF EXISTS results_staging;

CREATE TABLE results_staging (
  id INT(6) UNSIGNED NOT NULL AUTO_INCREMENT
, grant_seq int(10) unsigned NOT NULL
, db_name       varchar (16)
, user_name     varchar (16)
, creator       varchar (128) NOT NULL
, grant_hash    varchar (40)
, role_names    varchar (512)
, grant_syntax  varchar (2048)
, host_name     varchar (60)
, db_privs      varchar (19)
, user_privs    varchar (28)
, privs_version varchar (64)
, ts TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
, PRIMARY KEY (id)
, INDEX idx_results_stg_creator (creator)
, INDEX idx_results_stg_fk_dbs (db_name)
, INDEX idx_results_stg_fk_users (user_name,host_name)
, INDEX idx_results_stg_grant_seq (grant_seq,db_name)
, INDEX idx_results_stg_grant_hash (grant_hash)
, INDEX idx_results_stg_ts (ts)
, CONSTRAINT fk_results_stg_users FOREIGN KEY (user_name) REFERENCES users (user_name) ON UPDATE CASCADE
, CONSTRAINT fk_results_stg_dbs FOREIGN KEY (db_name) REFERENCES dbs (db_name) ON UPDATE CASCADE
) ENGINE = InnoDB;

SET foreign_key_checks = 1;

