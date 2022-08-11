#copy update_data to cahce table
CREATE TABLE update_data_cache LIKE update_data; 
INSERT update_data_cache SELECT * FROM update_data;

#delete field in table
mysql> delete from update_data_cache;
Query OK, 2 rows affected (0.05 sec)


#create procedure insert data in table [update_data] to table [update_data_cache]
DELIMITER //
CREATE PROCEDURE spCacheUpdateData()
BEGIN
    INSERT update_data_cache SELECT * FROM update_data;
END //
    
DELIMITER ;


#The following commands export the whole orders table into a CSV file with timestamp as a part of the file name.

SELECT 
    *
FROM
    update_data

INTO OUTFILE 'D:/hakim/Paramount/bak/update_data.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';



#The following commands export the whole orders table into a CSV file with timestamp as a part of the file name.
SET @TS = DATE_FORMAT(NOW(),'_%Y_%m_%d_%H_%i_%s');

SET @FOLDER = 'D:/hakim/Paramount/bak/';
SET @PREFIX = 'orders';
SET @EXT    = '.csv';

SET @CMD = CONCAT("SELECT * FROM update_data INTO OUTFILE '",@FOLDER,@PREFIX,@TS,@EXT,
				   "' FIELDS ENCLOSED BY '\"' TERMINATED BY ',' ESCAPED BY '\"'",
				   "  LINES TERMINATED BY '\r\n';");

PREPARE statement FROM @CMD;

EXECUTE statement;


DELIMITER //
CREATE PROCEDURE spToCsv()
BEGIN
    SET @TS = DATE_FORMAT(NOW(),'_%Y_%m_%d_%H_%i_%s');

	SET @FOLDER = 'D:/hakim/Paramount/bak/';
	SET @PREFIX = 'orders';
	SET @EXT    = '.csv';

	SET @CMD = CONCAT("SELECT * FROM update_data INTO OUTFILE '",@FOLDER,@PREFIX,@TS,@EXT,
					   "' FIELDS ENCLOSED BY '\' TERMINATED BY ',' ESCAPED BY '\"'",
					   "  LINES TERMINATED BY '\r\n';");

	PREPARE statement FROM @CMD;

	EXECUTE statement;
END //
    
DELIMITER ;