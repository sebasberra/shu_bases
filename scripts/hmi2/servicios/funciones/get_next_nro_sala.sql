/* Fecha de ultima actualizacion 16/11/2011 */

DROP FUNCTION IF EXISTS get_next_nro_sala;

/** 
*	Funcion para obtener un nuevo nro_sala para una nueva sala
*
*	@param		id_efector						INTEGER			id del efector
*	@return										CAHR(2)			nuevo nro_sala o
*																NULL = si el efector no existe
*/

/* A procedure or function is considered “deterministic” if it always produces the same result for the 
	same input parameters, and “not deterministic” otherwise. If neither DETERMINISTIC nor NOT DETERMINISTIC 
	is given in the routine definition, the default is NOT DETERMINISTIC. */
	
DELIMITER $$

CREATE
    DEFINER = CURRENT_USER 
    FUNCTION get_next_nro_sala (id_efector INTEGER)
    RETURNS CHAR(2)
    NOT DETERMINISTIC
	COMMENT 'Genera el proximo id_nro_sala para el efector'

BEGIN

	DECLARE aux_id INTEGER;
	
	/* check si id_efector existe */
	SET aux_id = 
		(SELECT 
			COUNT(*) 
		FROM 
			efectores e 
		WHERE 
			e.id_efector = id_efector);
	
	IF aux_id=0 THEN
		
		RETURN NULL;
		
	END IF;
	
	
	/* obtiene el proximo numero de sala para el efector  */
	SET aux_id = 
		(SELECT 
			MAX(CONVERT(s.id_nro_sala,UNSIGNED INTEGER))+1
		FROM
			salas s
		WHERE
			s.id_efector = id_efector);
			
	IF aux_id IS NULL THEN
	
		SET aux_id = '01';
		
	END IF; 
		
	
	
	/* si llego aqui genera el nro id a devolver */
	RETURN LPAD(aux_id,2,'0');

END$$

DELIMITER ;