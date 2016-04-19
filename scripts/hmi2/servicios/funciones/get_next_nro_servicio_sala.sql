/* Fecha de ultima actualizacion 16/11/2011 */

DROP FUNCTION IF EXISTS get_next_nro_servicio_sala;

/** 
*	Funcion para obtener un nuevo nro_servicio_sala para generar el id_nro_servicio_sala para un
*	un nuevo servicio de la sala
*
*	@param		id_efector						INTEGER			id del efector
*	@param		id_sala							INTEGER			id_sala donde se agrega el servicio
*	@return										INTEGER			id_nro_servicio_sala o
*																NULL = si el efector o la 
*																sala no existe
*/

/* A procedure or function is considered “deterministic” if it always produces the same result for the 
	same input parameters, and “not deterministic” otherwise. If neither DETERMINISTIC nor NOT DETERMINISTIC 
	is given in the routine definition, the default is NOT DETERMINISTIC. */
	
DELIMITER $$

CREATE
    DEFINER = CURRENT_USER 
    FUNCTION get_next_nro_servicio_sala (id_efector INTEGER, id_sala INTEGER)
    RETURNS CHAR(2)
    NOT DETERMINISTIC
	COMMENT 'Genera el proximo id_nro_servicio_sala para la sala'

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
	
	/* check si existe la sala en el efector */
	SET aux_id = 
		(SELECT 
			COUNT(*) 
		FROM 
			salas s 
		WHERE 
			s.id_sala = id_sala
		AND s.id_efector = id_efector);
	
	IF aux_id=0 THEN
		
		RETURN NULL;
		
	END IF;
	
	/* obtiene el proximo nro de servicio sala  */
	SET aux_id = 
		(SELECT 
			MAX(CONVERT(ss.id_nro_servicio_sala,UNSIGNED INTEGER))+1
		FROM
			servicios_salas ss
		WHERE
			ss.id_sala = id_sala
		AND ss.id_efector = id_efector);
			
	IF aux_id IS NULL THEN
	
		SET aux_id = '01';
		
	END IF; 
		
	
	
	/* si llego aqui genera el nro a devolver */
	RETURN LPAD(aux_id,2,'0');

END$$

DELIMITER ;