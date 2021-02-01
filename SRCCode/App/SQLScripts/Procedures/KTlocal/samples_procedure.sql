DELIMITER $$
DROP PROCEDURE IF EXISTS samples_procedure $$
CREATE PROCEDURE samples_procedure()
BEGIN

  DECLARE l_SampleID VARCHAR(100);
  DECLARE l_ClientID VARCHAR(100);
  DECLARE l_Species VARCHAR(100);
  DECLARE l_loc_lbl VARCHAR(100);
  DECLARE l_Sex VARCHAR(100);
  DECLARE l_col_year INT(11);
  DECLARE l_col_month INT(11);
  DECLARE l_locationid INT(11);
  DECLARE sample_count INT(11);

  DECLARE no_more_records MEDIUMINT(5);

  DECLARE cu2 CURSOR FOR
    SELECT SampleID, ClientID, Species, loc_lbl, Sex, col_year, col_month
    FROM animals_csv;

  DECLARE cu3 CURSOR FOR
      SELECT SampleID, Species, Site, Sex
      FROM PAC_data_for_KT_Project_csv;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_records = 1;

  SELECT 'Running samples_procedure';

  OPEN cu2;
  animal_loop:REPEAT
  IF no_more_records THEN
    LEAVE animal_loop;
  END IF;

    #we declared the cursor, we are taking the info from the cursor and putting it into these declared variables
    FETCH cu2 INTO l_SampleID, l_ClientID, l_Species, l_loc_lbl, l_Sex, l_col_year, l_col_month;

    SELECT id INTO l_locationid FROM locations WHERE lbl = l_loc_lbl LIMIT 1;

    INSERT INTO samples SET sample_id = l_SampleID, client_id = l_ClientID,
                            species = l_Species, sex = l_Sex, loc_id = l_locationid, col_year = l_col_year,
                            col_month = l_col_month;


  UNTIL no_more_records
  END REPEAT animal_loop;
  CLOSE cu2;
  SET no_more_records = 0;

  #Read additional samples from Spatial PACs
  OPEN cu3;
  spatial_loop:REPEAT
  IF no_more_records THEN
    LEAVE spatial_loop;
  END IF;

      #we declared the cursor, we are taking the info from the cursor and putting it into these declared variables
      FETCH cu3 INTO l_SampleID, l_Species, l_loc_lbl, l_Sex;

      SELECT id INTO l_locationid FROM locations WHERE lbl = l_loc_lbl LIMIT 1;

      SELECT COUNT(*) INTO sample_count FROM samples WHERE l_SampleID = sample_id;

      IF sample_count = 0 THEN
          INSERT INTO samples SET sample_id = l_SampleID, species = l_Species, sex = l_Sex, loc_id = l_locationid;
      END IF;

  UNTIL no_more_records
  END REPEAT spatial_loop;
  CLOSE cu3;
  SET no_more_records = 0;

  #Read additional samples from Diseases

END $$
DELIMITER ;
