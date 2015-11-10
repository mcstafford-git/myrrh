drop table if exists sequences;

create table if not exists sequences (
  id int(10) unsigned not null auto_increment
, seq_name varchar(32) not null
, seq_value int(10) unsigned not null default 0
, primary key( id )
, unique key idx_sequences_seq_name(seq_name)
) engine = innodb;

