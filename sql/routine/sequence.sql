drop function if exists sequence;

delimiter //

create DEFINER = 'dba'@'localhost'
function sequence(
  p_sequence_name varchar(128)
)
returns int(10) unsigned
deterministic reads sql data sql security invoker
begin

UPDATE sequences s
SET s.seq_value = last_insert_id( s.seq_value +1 )
WHERE s.seq_name = p_sequence_name;

RETURN last_insert_id();

end;

//

delimiter ;

