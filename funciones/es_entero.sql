/* Fecha de ultima actualizacion 25/07/2012 */

DROP FUNCTION IF EXISTS es_entero;

/** 
*	Funcion para hacer una validacion basica de si es numero puro valido, o sea, sin puntos ni apostrofes , etc
*
*	@param		expresion		CHAR(15)		STRING
*
*	@return					BOOLEAN			si TRUE el un documento valido, si no es FALSE
*/

/* A procedure or function is considered “deterministic” if it always produces the same result for the 
	same input parameters, and “not deterministic” otherwise. If neither DETERMINISTIC nor NOT DETERMINISTIC 
	is given in the routine definition, the default is NOT DETERMINISTIC. */
	
DELIMITER $$

CREATE
    DEFINER = CURRENT_USER 
    FUNCTION es_entero (expresion CHAR(15))
    RETURNS BOOLEAN
    DETERMINISTIC
	COMMENT 'Valida si es numero entero puro valido'

BEGIN

	IF expresion NOT REGEXP ('^[0-9]+$') THEN
	
		RETURN FALSE;
		
	END IF;

	RETURN TRUE;
	
END$$

DELIMITER ;
