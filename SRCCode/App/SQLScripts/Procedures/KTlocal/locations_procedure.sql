DELIMITER $$
DROP PROCEDURE IF EXISTS locations_procedure $$
CREATE PROCEDURE locations_procedure()
BEGIN

  DECLARE l_Area VARCHAR(100);
  DECLARE l_Lat DOUBLE;
  DECLARE l_Long DOUBLE;
 # DECLARE location_count INT(11);

  DECLARE loc_count INT(11);

  DECLARE no_more_records MEDIUMINT(5);

  DECLARE cu2 CURSOR FOR
    SELECT Area, Lat, Longitude
    FROM Spatial_PACs_csv;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_records = 1;

 # SELECT COUNT(id) INTO location_count FROM locations;

  SELECT 'Running locations_procedure';
  #IF location_count = 0 THEN

  OPEN cu2;
  spatial_loop:REPEAT
    IF no_more_records THEN
        LEAVE spatial_loop;
    END IF;

    FETCH cu2 INTO l_Area, l_Lat, l_Long; #we declared the cursor, we are taking the info from the cursor and putting it into these declared variables

    SELECT COUNT(*) INTO loc_count FROM locations WHERE l_Area = lbl;

    IF loc_count = 0 THEN
        INSERT INTO locations SET lbl = l_Area, lat = l_Lat, lng = l_Long;
    END IF;

    UNTIL no_more_records
  END REPEAT spatial_loop;
  CLOSE cu2;
  SET no_more_records = 0;

 # END IF;

  #IF location_count > 0 THEN
  #    select 'table not empty';
  #END IF;

END $$
DELIMITER ;
