DELIMITER $$
DROP PROCEDURE IF EXISTS hormones_procedure $$
CREATE PROCEDURE hormones_procedure()
BEGIN

  DECLARE l_SampleID VARCHAR(100);
  DECLARE l_sample_id int(11);
  DECLARE l_Cortisol double;
  DECLARE l_Testosterone double;
  DECLARE l_Estradiol double;
  DECLARE l_Progesterone double;
  DECLARE l_T3 double;

  DECLARE no_more_records MEDIUMINT(5);

  DECLARE cu2 CURSOR FOR
    SELECT sample, Cort, Test, Estradiol, Prog, T3
    FROM hormones_csv;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_records = 1;

  OPEN cu2;
  hormones_loop:REPEAT
    FETCH cu2 INTO l_SampleID, l_Cortisol, l_Testosterone, l_Estradiol, l_Progesterone, l_T3; #we declared the cursor, we are taking the info from the cursor and putting it into these declared variables

    SELECT id INTO l_sample_id
    FROM samples WHERE client_id = l_SampleID LIMIT 1;

    INSERT INTO fecal_hormones SET sample_id = l_sample_id, Cortisol = l_Cortisol, Testosterone = l_Testosterone,
                             Estradiol = l_Estradiol, Progesterone = l_Progesterone, T3 = l_T3;

    IF no_more_records THEN
      LEAVE hormones_loop;
    END IF;

    UNTIL no_more_records

  END REPEAT hormones_loop;
  CLOSE cu2;
  SET no_more_records = 0;

END $$
DELIMITER ;
