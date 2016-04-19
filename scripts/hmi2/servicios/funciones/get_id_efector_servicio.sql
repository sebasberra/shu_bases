/* Fecha de ultima actualizacion 14/11/2011 */

DROP FUNCTION IF EXISTS get_id_efector_servicio;

/** 
*	Funcion para obtener el id_efector_servicio. La operacion de calculo es la 
*	siguiente: CONCAT(@id_efector,LPAD(@id_servicio_estadistica,3,'0'))
*
*	@param		id_efector					INTEGER			id del efector
*	@param		id_servicio_estadistica		INTEGER			id del servicio de estadistica
*	@return									INTEGER			id_efector_servicio o 
*															-1 = si id_efector no existe 
*															-2 = si id_servicio_estadistica no existe
*/

/* A procedure or function is considered “deterministic” if it always produces the same result for the 
	same input parameters, and “not deterministic” otherwise. If neither DETERMINISTIC nor NOT DETERMINISTIC 
	is given in the routine definition, the default is NOT DETERMINISTIC. */
	
DELIMITER $$

CREATE
    DEFINER = CURRENT_USER 
    FUNCTION get_id_efector_servicio (id_efector INTEGER, id_servicio_estadistica INTEGER)
    RETURNS INTEGER
    DETERMINISTIC
	COMMENT 'Calcula el id_efector_servicio'

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
		
		RETURN -1;
		
	END IF;
	
	
	/* check id_servicio_estadistica existe */
	SET aux_id = 
	
		(SELECT 
			COUNT(*) 
		FROM 
			servicios_estadistica se 
		WHERE 
			se.id_servicio_estadistica = id_servicio_estadistica);
	
	IF aux_id=0 THEN
		
		RETURN -2;
		
	END IF;
	
	/* si llego aqui genera el id a devolver */
	RETURN CONCAT(id_efector,LPAD(id_servicio_estadistica,3,'0'));

END$$

DELIMITER ;