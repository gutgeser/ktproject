DELIMITER $$
DROP PROCEDURE IF EXISTS master_queries $$
CREATE PROCEDURE master_queries(
    IN locID VARCHAR(100),
    IN queryID VARCHAR(100)
    )
BEGIN
#Locations test query
#Read in location data based on the location read in from the webpage and returns lat and long
IF queryID = 'loc_query' THEN
SELECT lat, lng
    FROM locations
    WHERE lbl = locID;
END IF;

#Rodenticides query
#Read location data and output rodenticides data
#CREATE OR REPLACE VIEW rod_view AS
IF queryID = 'rod_query' THEN
    SELECT rd.Pop, rd.Exposed
    FROM rodenticides rd
    JOIN locations lc ON lc.id = rd.location_id
    WHERE lc.lbl = locID; #view doesn't like using the variable locID
END IF;

#PACs query
#Read location, return PAC data as an average of each category of PAC at that location
IF queryID = 'PAC_query' THEN
    SELECT ROUND(AVG(pac.sum_parent),2) AS Parent,
           ROUND(AVG(pac.sum_alk),2) AS Alkylated,
           ROUND(AVG(pac.sum_HPAC),2) AS Halogenated
    FROM PACs pac
    LEFT JOIN samples smp ON smp.id = pac.sample_id #LEFT JOIN automatically removes any data that doesn't have the location ID
    LEFT JOIN locations lc ON lc.id = smp.loc_id
    WHERE lc.lbl = locID;
END IF;

#Diseases query
IF queryID = 'dis_query' THEN
    SELECT
           COUNT(dis.Canine_parainfluenza_virus) AS Tested_1,
           SUM(IF(dis.Canine_parainfluenza_virus = '+',1,0)) AS Positives_1,
           COUNT(dis.Canine_adenovirus_2) AS Tested_2,
           SUM(IF(dis.Canine_adenovirus_2 = '+',1,0)) AS Positives_2,
           COUNT(dis.Canine_herpesvirus_1) AS Tested_3,
           SUM(IF(dis.Canine_herpesvirus_1 = '+',1,0)) AS Positives_3,
           COUNT(dis.Diotophyme_renale) AS Tested_4,
           SUM(IF(dis.Diotophyme_renale = '+',0,1)) AS Positives_4,
           COUNT(dis.Canine_distemper_virus) AS Tested_5,
           SUM(IF(dis.Canine_distemper_virus = '+',0,1)) AS Positives_5,
           COUNT(dis.Leptospira) AS Tested_6,
           SUM(IF(dis.Leptospira = '+',0,1)) AS Positives_6,
           COUNT(dis.Toxoplasma) AS Tested_7,
           SUM(IF(dis.Toxoplasma = '+',0,1)) AS Positives_7
    FROM diseases dis
    LEFT JOIN samples smp ON smp.id = dis.sample_id
    LEFT JOIN locations lc ON lc.id = smp.loc_id
    WHERE lc.lbl = locID;
END IF;


#Metals query
#Read location, return Metals data an average of each metal PPA or Z-score
    #Replace zeros with MDLs
    #Make arrays with PPAs and z-scores in place of measured values for all locations
    #Read location and return average PPA and z-score for each metal of that location
    #Return average PPA and z-score for each metal at that location for each species
    #GROUP BY smp.species
    #Return average PPA and z-score for each metal for each sex within each species
    #GROUP BY smp.sex
#Return reference value for each metal
END $$
DELIMITER ;
