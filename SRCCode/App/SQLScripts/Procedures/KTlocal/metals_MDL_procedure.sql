DELIMITER $$
DROP PROCEDURE IF EXISTS metals_MDL_procedure $$
CREATE PROCEDURE metals_MDL_procedure()
BEGIN

  DECLARE l_id INT(11);
  DECLARE l_Hg DOUBLE;
  DECLARE l_Li DOUBLE;
  DECLARE l_V DOUBLE;
  DECLARE l_Mn DOUBLE;
  DECLARE l_Fe DOUBLE;
  DECLARE l_Co DOUBLE;
  DECLARE l_Ni DOUBLE;
  DECLARE l_Cu DOUBLE;
  DECLARE l_Zn DOUBLE;
  DECLARE l_Ga DOUBLE;
  DECLARE l_Arsenic DOUBLE;
  DECLARE l_Se DOUBLE;
  DECLARE l_Rb DOUBLE;
  DECLARE l_Sr DOUBLE;
  DECLARE l_Mo DOUBLE;
  DECLARE l_Ag DOUBLE;
  DECLARE l_Cd DOUBLE;
  DECLARE l_Sn DOUBLE;
  DECLARE l_Sb DOUBLE;
  DECLARE l_Ba DOUBLE;
  DECLARE l_Tl DOUBLE;
  DECLARE l_Pb DOUBLE;
  DECLARE l_Bi DOUBLE;
  DECLARE tempvar DOUBLE;

  DECLARE no_more_records INT(11);

  # Step 1: iterate over the metals table, and get all the columns except sample ID
  # Step 2: In each iteration we will have the values for each metal
  # Step 3: Compare to zero
  # Step 4: if it is zero, we look up the column name in the MDLs table under 'Analyte', and then retrieve the value of the MDL
  # Step 5: Now take that value and update the metals table at that column


  DECLARE cu2 CURSOR FOR
    SELECT id, Hg, Li, V, Mn, Fe, Co, Ni, Cu, Zn, Ga, Arsenic, Se, Rb, Sr, Mo, Ag, Cd, Sn, Sb, Ba, Tl, Pb, Bi
    FROM metals;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_records = 1;

    #Create a temporary table (needs to be after the last DECLARE statement), with the first row as a single column that we can iterate down
#   DROP TABLE IF EXISTS `temp_table`;
#
#     CREATE TABLE `temp_table` (
#       `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
#       `metalval` double DEFAULT NULL,
#       `metalname` VARCHAR(50),
#       PRIMARY KEY (`id`),
#             constraint UNIQ_6_temp
#                       unique (id)
#     ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

  OPEN cu2;
  MDL_update_loop:REPEAT
      IF no_more_records THEN #This needs to be right after the REPEAT, otherwise it does one extra iteration
      LEAVE MDL_update_loop;
    END IF;
    FETCH cu2 INTO l_id, l_Hg, l_Li, l_V, l_Mn, l_Fe, l_Co, l_Ni, l_Cu, l_Zn, l_Ga,
        l_Arsenic, l_Se, l_Rb, l_Sr, l_Mo, l_Ag, l_Cd, l_Sn, l_Sb, l_Ba, l_Tl, l_Pb, l_Bi; #we declared the cursor, we are taking the info from the cursor and putting it into these declared variables

        IF l_Hg = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Hg';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Hg = tempvar WHERE id=l_id;
        END IF;
        IF l_Li = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Li';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Li = tempvar WHERE id=l_id;
        END IF;
        IF l_V = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'V';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET V = tempvar WHERE id=l_id;
        END IF;
        IF l_Mn = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Mn';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Mn = tempvar WHERE id=l_id;
        END IF;
        IF l_Fe = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Fe';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Fe = tempvar WHERE id=l_id;
        END IF;
        IF l_Co = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Co';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Co = tempvar WHERE id=l_id;
        END IF;
        IF l_Ni = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Ni';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Ni = tempvar WHERE id=l_id;
        END IF;
        IF l_Cu = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Cu';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Cu = tempvar WHERE id=l_id;
        END IF;
        IF l_Zn = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Zn';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Zn = tempvar WHERE id=l_id;
        END IF;
        IF l_Ga = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Ga';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Ga = tempvar WHERE id=l_id;
        END IF;
        IF l_Arsenic = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Arsenic';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Arsenic = tempvar WHERE id=l_id;
        END IF;
        IF l_Se = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Se';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Se = tempvar WHERE id=l_id;
        END IF;
        IF l_Rb = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Rb';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Rb = tempvar WHERE id=l_id;
        END IF;
        IF l_Sr = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Sr';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Sr = tempvar WHERE id=l_id;
        END IF;
        IF l_Mo = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Mo';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Mo = tempvar WHERE id=l_id;
        END IF;
        IF l_Ag = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Ag';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Ag = tempvar WHERE id=l_id;
        END IF;
        IF l_Cd = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Cd';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Cd = tempvar WHERE id=l_id;
        END IF;
        IF l_Sn = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Sn';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Sn = tempvar WHERE id=l_id;
        END IF;
        IF l_Sb = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Sb';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Sb = tempvar WHERE id=l_id;
        END IF;
        IF l_Ba = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Ba';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Ba = tempvar WHERE id=l_id;
        END IF;
        IF l_Tl = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Tl';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Tl = tempvar WHERE id=l_id;
        END IF;
        IF l_Pb = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Pb';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Pb = tempvar WHERE id=l_id;
        END IF;
        IF l_Bi = 0 THEN
            SELECT MDL INTO tempvar FROM MDLs
            WHERE Analyte = 'Bi';
            SET tempvar = ROUND(tempvar,3);
            UPDATE metals SET Bi = tempvar WHERE id=l_id;
        END IF;

    UNTIL no_more_records

  END REPEAT MDL_update_loop;
  CLOSE cu2;
  SET no_more_records = 0;

END $$
DELIMITER ;
