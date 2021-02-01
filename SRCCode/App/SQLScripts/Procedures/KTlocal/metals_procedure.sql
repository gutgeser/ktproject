DELIMITER $$
DROP PROCEDURE IF EXISTS metals_procedure $$
CREATE PROCEDURE metals_procedure()
BEGIN

  DECLARE l_SampleID VARCHAR(100);
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


  DECLARE no_more_records MEDIUMINT(5);

  DECLARE cu2 CURSOR FOR
    SELECT SampleID, Hg, Li, V, Mn, Fe, Co, Ni, Cu, Zn, Ga, Arsenic, Se, Rb, Sr, Mo, Ag, Cd, Sn, Sb, Ba, Tl, Pb, Bi
    FROM animals_csv;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_records = 1;
  SELECT 'Running metals_procedure';

  OPEN cu2;
  animal_loop:REPEAT
    IF no_more_records THEN
        LEAVE animal_loop;
    END IF;

    FETCH cu2 INTO l_SampleID, l_Hg, l_Li, l_V, l_Mn, l_Fe, l_Co, l_Ni, l_Cu, l_Zn, l_Ga,
        l_Arsenic, l_Se, l_Rb, l_Sr, l_Mo, l_Ag, l_Cd, l_Sn, l_Sb, l_Ba, l_Tl, l_Pb, l_Bi; #we declared the cursor, we are taking the info from the cursor and putting it into these declared variables

    SELECT id INTO l_sampleid
    FROM samples WHERE sample_id = l_SampleID LIMIT 1;

    INSERT INTO metals SET sample_id = l_SampleID, Hg = l_Hg, Li = l_Li, V = l_V, Mn = l_Mn,
                            Fe = l_Fe, Co = l_Co, Ni = l_Ni, Cu = l_Cu, Zn = l_Zn, Ga = l_Ga,
                            Arsenic = l_Arsenic, Se = l_Se, Rb = l_Rb, Sr = l_Sr, Mo = l_Mo, Ag = l_Ag,
                            Cd = l_Cd, Sn = l_Sn, Sb = l_Sb, Ba = l_Ba, Tl = l_Tl, Pb = l_Pb,
                            Bi = l_Bi;

    UNTIL no_more_records
  END REPEAT animal_loop;
  CLOSE cu2;
  SET no_more_records = 0;

END $$
DELIMITER ;
