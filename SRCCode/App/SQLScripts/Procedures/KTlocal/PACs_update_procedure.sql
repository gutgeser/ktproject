DELIMITER $$
DROP PROCEDURE IF EXISTS PACs_update_procedure $$
CREATE PROCEDURE PACs_update_procedure()
BEGIN

  DECLARE l_SampleID VARCHAR(100);
  DECLARE l_sampleid_int int(11);
  DECLARE l_sum_parent VARCHAR(100);
  DECLARE l_sum_alk VARCHAR(100);
  DECLARE l_lookup_sample_id INT(11);

  DECLARE no_more_records MEDIUMINT(5);

  DECLARE cu2 CURSOR FOR
    SELECT Sample, Parent, ALK
    FROM pacs_update_csv;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_records = 1;

  OPEN cu2;
  PAC_loop:REPEAT
      IF no_more_records THEN
      LEAVE PAC_loop;
    END IF;
    FETCH cu2 INTO l_SampleID, l_sum_parent, l_sum_alk; #we declared the cursor, we are taking the info from the cursor and putting it into these declared variables

    #SET l_sampleid_int = NULL;

    SELECT id INTO l_sampleid_int
    FROM samples WHERE client_id = l_SampleID LIMIT 1;

    #SELECT l_sampleid_int;
    #SET l_lookup_sample_id = NULL; # not sure if = NULL is correct, may be IS NULL

    #SELECT sample_id INTO l_lookup_sample_id FROM PACs WHERE sample_id = l_sampleid_int LIMIT 1; #what happens if there is NULL

    #IF (l_lookup_sample_id IS NULL) AND (l_sampleid_int IS NOT NULL) THEN

        INSERT INTO PACs SET sample_id = l_sampleid_int, sum_parent = l_sum_parent, sum_alk = l_sum_alk;
    #ELSE
        #SELECT l_lookup_sample_id; # check if/else structure
    #END IF;

    UNTIL no_more_records

  END REPEAT PAC_loop;
  CLOSE cu2;
  SET no_more_records = 0;

END $$
DELIMITER ;
