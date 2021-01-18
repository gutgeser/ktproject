DELIMITER $$
DROP PROCEDURE IF EXISTS PACs_procedure $$
CREATE PROCEDURE PACs_procedure()
BEGIN

  DECLARE l_SampleID VARCHAR(100);
  DECLARE l_sum_parent VARCHAR(100);
  DECLARE l_sum_alk VARCHAR(100);

  DECLARE no_more_records MEDIUMINT(5);

  DECLARE cu2 CURSOR FOR
    SELECT SampleID, Sum_Parent, Sum_ALK
    FROM PAC_data_for_KT_Project_csv;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_records = 1;

  OPEN cu2;
  PAC_loop:REPEAT
    FETCH cu2 INTO l_SampleID, l_sum_parent, l_sum_alk; #we declared the cursor, we are taking the info from the cursor and putting it into these declared variables

    SELECT id INTO l_sampleid
    FROM samples WHERE sample_id = l_SampleID LIMIT 1;

    INSERT INTO PACs SET sample_id = l_SampleID, sum_parent = l_sum_parent, sum_alk = l_sum_alk;

    IF no_more_records THEN
      LEAVE PAC_loop;
    END IF;

    UNTIL no_more_records

  END REPEAT PAC_loop;
  CLOSE cu2;
  SET no_more_records = 0;

END $$
DELIMITER ;
