DELIMITER $$

CREATE PROCEDURE auditoria

	BEFORE UPDATE 
	
	ON  INNODB_TRX
	
FOR EACH ROW BEGIN

END$$

DELIMITER ;