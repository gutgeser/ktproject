DELIMITER $$
DROP PROCEDURE IF EXISTS pregnancies_procedure $$
CREATE PROCEDURE pregnancies_procedure()
BEGIN

  DECLARE l_id VARCHAR(100);
  DECLARE l_sample_id int(11);
  DECLARE l_pregnant enum('y','n','N/A') DEFAULT 'N/A';
  DECLARE l_blastocyst VARCHAR(11) DEFAULT NULL;
  DECLARE l_scar VARCHAR(11) DEFAULT NULL;
  DECLARE l_fetus VARCHAR(11) DEFAULT NULL;
  DECLARE l_implant VARCHAR(11) DEFAULT NULL;


  DECLARE no_more_records MEDIUMINT(5);

  DECLARE cu2 CURSOR FOR
    SELECT id, pregnant, blastocyst, scar, fetus, implant
    FROM pregnancies_csv;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_records = 1;
OPEN cu2;
  pregnancies_loop:REPEAT
    FETCH cu2 INTO l_id, l_pregnant, l_blastocyst, l_scar, l_fetus, l_implant; #we declared the cursor, we are taking the info from the cursor and putting it into these declared variables

    IF l_blastocyst = '' THEN SET l_blastocyst = 0; end if;
    IF l_scar = '' THEN SET l_scar = 0; end if;
    IF l_fetus = '' THEN SET l_fetus = 0; end if;
    IF l_implant = '' THEN SET l_implant = 0; end if;

    SET l_blastocyst = CAST(l_blastocyst AS INTEGER);
    SET l_scar = CAST(l_scar AS INTEGER);
    SET l_fetus = CAST(l_fetus AS INTEGER);
    SET l_implant = CAST(l_implant AS INTEGER);

    SELECT id INTO l_sample_id
    FROM samples WHERE client_id = l_id LIMIT 1;

    INSERT INTO pregnancies SET sample_id = l_sample_id, pregnant = l_pregnant,
                                blastocyst = l_blastocyst,
                                scar = l_scar,
                                fetus = l_fetus,
                                implant = l_implant;

    IF no_more_records THEN
      LEAVE pregnancies_loop;
    END IF;

    UNTIL no_more_records

  END REPEAT pregnancies_loop;
  CLOSE cu2;
  SET no_more_records = 0;

END $$
DELIMITER ;
