/* fecha de actualizacion 14/03/2011 */

DROP FUNCTION IF EXISTS es_fecha;

/** 
*	Funcion is_date
*
*	@param		fecha		VARCHAR(1024)			
*	@return									si tipo es TRUE fecha valida
*											si tipo es FALSE fecha no valida
*/

/* A procedure or function is considered “deterministic” if it always produces the same result for the 
	same input parameters, and “not deterministic” otherwise. If neither DETERMINISTIC nor NOT DETERMINISTIC 
	is given in the routine definition, the default is NOT DETERMINISTIC. */
	
DELIMITER $$

CREATE
    DEFINER = CURRENT_USER 
    FUNCTION es_fecha (fecha VARCHAR(255)) 
    RETURNS BOOLEAN
    DETERMINISTIC
	COMMENT 'Devuelve si es o no valida la fecha'

BEGIN
	
	IF (SELECT LENGTH(DATE(fecha)) IS NULL )THEN
		RETURN FALSE;
	END IF;
	
	RETURN TRUE;

END$$

DELIMITER ; 