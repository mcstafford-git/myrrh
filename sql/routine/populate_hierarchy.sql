DROP PROCEDURE IF EXISTS populate_hierarchy;

DELIMITER //

CREATE definer=myrrh@localhost
PROCEDURE populate_hierarchy(
  p_depth INT
, p_width INT
)
COMMENT ''
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
BEGIN

  DECLARE l_depth INT default 1;
  DECLARE l_width INT default 1;

  INSERT INTO hierarchy VALUES ( 1, 1, 1 );

  SET l_depth = l_depth +1;

  START TRANSACTION;
  WHILE l_width < p_width DO
    INSERT INTO hierarchy ( parent, depth ) VALUES ( 1, l_depth );
    SET l_width = l_width +1;
  END WHILE;
  COMMIT;


  WHILE l_depth < p_depth DO

    SET l_width = 1;

    WHILE l_width < p_width DO
      INSERT INTO hierarchy ( parent, depth )
      SELECT
        id
      , l_depth +1
      FROM
        hierarchy
      WHERE
        depth = l_depth;

      SET l_width = l_width +1;

    END WHILE;
    SET l_depth = l_depth +1;
  END WHILE;

END;
//

DELIMITER ;

