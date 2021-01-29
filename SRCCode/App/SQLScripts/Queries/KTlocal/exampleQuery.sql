###############################################################################################
# Any regular queries can be made in this file:
SELECT * FROM rodenticides;
###############################################################################################
# Prepared statement queries as well:
SET @TABLENAME= 'MDLs';
SET @SELECT_DATA = CONCAT(
    'SELECT * FROM ',
    @TABLENAME
);
PREPARE SELECT_STMT FROM @SELECT_DATA;
EXECUTE SELECT_STMT;
DEALLOCATE PREPARE SELECT_STMT;
###############################################################################################
# Procedures can be called as well:
CALL master_queries_procedure(1234,'loc_query');
