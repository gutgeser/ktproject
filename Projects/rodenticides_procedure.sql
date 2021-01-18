DELIMITER $$
DROP PROCEDURE IF EXISTS rodenticides_procedure $$
CREATE PROCEDURE rodenticides_procedure()
BEGIN

  DECLARE l_factid CHAR(36);
  DECLARE l_fact VARCHAR(128);

  DECLARE l_loc_id INT(11);
  DECLARE l_id VARCHAR(100);
  DECLARE l_Pop INT(11);
  DECLARE l_Exposed INT(11);

  DECLARE no_more_records MEDIUMINT(5);

  DECLARE cu2 CURSOR FOR
    SELECT loc_id, Pop, Exposed
    FROM rodenticides_csv;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_records = 1;

  OPEN cu2;
  fact_loop:REPEAT
    FETCH cu2 INTO l_loc_id, l_Pop, l_Exposed;

    SELECT id INTO l_id
    FROM locations WHERE lbl = l_loc_id LIMIT 1;

    INSERT INTO rodenticides SET location_id = l_id, Location_label = l_loc_id, Pop = l_Pop, Exposed = l_Exposed;

    IF no_more_records THEN
      LEAVE fact_loop;
    END IF;

    UNTIL no_more_records

  END REPEAT fact_loop;
  CLOSE cu2;
  SET no_more_records = 0;

END $$
DELIMITER ;
