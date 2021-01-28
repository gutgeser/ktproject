DELIMITER $$
DROP PROCEDURE IF EXISTS complex_example_procedure$$
CREATE PROCEDURE complex_example_procedure(IN somechar VARCHAR(100), OUT resultdouble DOUBLE)
BEGIN

  DECLARE l_id INT (11);
  DECLARE l_mdl DOUBLE;
  DECLARE l_columnname VARCHAR(100);
  DECLARE l_iter INT(5);
  DECLARE l_colcount INT(5);
  DECLARE l_colstart INT(5);
  DECLARE l_query VARCHAR(255);
  DECLARE no_more_records MEDIUMINT(5);
  DECLARE l_tablename VARCHAR(255);

  DECLARE cu2 CURSOR FOR
    SELECT id
    FROM metals
    ORDER BY id ASC;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_records = 1;

  ## Not needed here, only in case:
  DROP TABLE IF EXISTS `complex_example_temp_table`;
  CREATE TABLE `complex_example_temp_table` (
        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `colone` VARCHAR(100) DEFAULT NULL,
        `coltwo` VARCHAR(100) DEFAULT NULL,
        `colthree` VARCHAR(100) DEFAULT NULL,
        PRIMARY KEY (`id`),
          constraint UNIQ_complex_example_temp
                    unique (id)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

  SET l_tablename = 'metals';
  SET l_colstart = 3;

  SELECT COUNT(column_name) INTO l_colcount FROM information_schema.columns WHERE table_name = l_tablename;

  OPEN cu2;
  metals_loop:REPEAT
    IF no_more_records THEN
      LEAVE metals_loop;
    END IF;

    FETCH cu2 INTO l_id;
      SET l_iter = l_colstart;
      WHILE l_iter < (l_colcount + 1) DO
        SELECT column_name
        INTO l_columnname
        FROM information_schema.columns
        WHERE table_name = l_tablename
        AND ordinal_position = l_iter;

        SET l_iter = l_iter  + 1;

        SET l_query = CONCAT('SELECT ',l_columnname,' INTO @l_temp_col_val FROM ',l_tablename,' WHERE id = ',l_id);
        PREPARE stmt FROM l_query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        IF @l_temp_col_val = 0 && l_columnname !='Ga' THEN
          SELECT MDL FROM MDLs WHERE Analyte=l_columnname INTO l_mdl;

          SET l_mdl = l_mdl/2;
          SET l_mdl = ROUND(l_mdl,3);

          # For info only during execution:
          SELECT l_columnname AS Metal, l_id AS id, @l_temp_metal_val AS zero, l_mdl AS mdls;

          SET l_query = CONCAT('UPDATE ',l_tablename,' SET ',l_columnname,'=',l_mdl,'WHERE id=',l_id);
          PREPARE stmt FROM l_query;
          EXECUTE stmt;
          DEALLOCATE PREPARE stmt;
        END IF;
     END WHILE;

    IF no_more_records THEN
      LEAVE metals_loop;
    END IF;
    UNTIL no_more_records
  END REPEAT metals_loop;
  CLOSE cu2;
  SET no_more_records = 0;

  DROP TABLE IF EXISTS `complex_example_temp_table`;

  SET resultdouble = l_colcount;
END $$
DELIMITER ;
