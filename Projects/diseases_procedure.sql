
DELIMITER $$
DROP PROCEDURE IF EXISTS diseases_procedure$$
CREATE PROCEDURE diseases_procedure()
BEGIN

 # DECLARE l_loc_id INT(11);
  DECLARE l_sample_id INT(11);#this variable is reading from the samples table

  DECLARE l_Client_id VARCHAR(100);
  DECLARE l_Location VARCHAR(100);#Reading location data, but not doing anything with it for now because its in the samples table
  DECLARE l_Kidney VARCHAR(100);
  DECLARE l_Liver VARCHAR(100);
  DECLARE l_Canine_parainfluenza_virus VARCHAR(100);
  DECLARE l_Canine_adenovirus_2 VARCHAR(100);
  DECLARE l_Canine_herpesvirus_1 VARCHAR(100);
  DECLARE l_Diotophyme_renale VARCHAR(100);
  DECLARE l_Canine_distemper_virus VARCHAR(100);
  DECLARE l_Leptospira VARCHAR(100);
  DECLARE l_Toxoplasma VARCHAR(100);

  DECLARE no_more_records MEDIUMINT(5);

 #read data from diseases_csv into diseases, with the sample id as the foreign key to the sample database

  DECLARE cu2 CURSOR FOR
    SELECT ClientID, Location, Kidney, Liver, Canine_parainfluenza_virus, Canine_adenovirus_2,
           Canine_herpesvirus_1, Diotophyme_renale, Canine_distemper_virus, Leptospira, Toxoplasma
    FROM Diseases_csv;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_records = 1;

#I then want to convert 'x' or '+' to 'TRUE' and '-' to FALSE, and convert the fields into booleans

  OPEN cu2;
  fact_loop:REPEAT
    FETCH cu2 INTO l_Client_id, l_Location, l_Kidney, l_Liver, l_Canine_parainfluenza_virus, l_Canine_adenovirus_2,
        l_Canine_herpesvirus_1, l_Diotophyme_renale, l_Canine_distemper_virus, l_Leptospira, l_Toxoplasma;

    SELECT id INTO l_sample_id #there's something wrong with this, I'm both selecting and changing the same variable, may need to create another variable
    FROM samples WHERE client_id = l_Client_id LIMIT 1;

    INSERT INTO diseases SET sample_id = l_sample_id, Kidney = l_Kidney, Liver = l_Liver, Canine_parainfluenza_virus = l_Canine_parainfluenza_virus,
                             Canine_adenovirus_2 = l_Canine_adenovirus_2, Canine_herpesvirus_1 = l_Canine_herpesvirus_1,
                             Diotophyme_renale = l_Diotophyme_renale, Canine_distemper_virus = l_Canine_distemper_virus,
                             Leptospira = l_Leptospira, Toxoplasma = l_Toxoplasma;

    IF no_more_records THEN
      LEAVE fact_loop;
    END IF;

    UNTIL no_more_records

  END REPEAT fact_loop;
  CLOSE cu2;
  SET no_more_records = 0;

END $$
DELIMITER ;
