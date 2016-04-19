/* Fecha de ultima actualizacion 21/11/2011 */

DROP FUNCTION IF EXISTS get_digito_control;

/** 
*	Funcion para obtener digito control para compatibilidad con SIPES
*
*	@param		fecha						DATE			fecha
*	@param		id_efector					INTEGER			id_efector donde se quiere agregar el servicio
*	@param		id_servicio_estadistica		INTEGER			id del servicio de estadistica que corresponde al area del
*															efector donde se creara el servicio
*	@param		id_servicio					INTEGER			servicio que se quiere agregar al area
*/

/* A procedure or function is considered “deterministic” if it always produces the same result for the 
	same input parameters, and “not deterministic” otherwise. If neither DETERMINISTIC nor NOT DETERMINISTIC 
	is given in the routine definition, the default is NOT DETERMINISTIC. */
	
DELIMITER $$

CREATE
    DEFINER = CURRENT_USER 
    FUNCTION get_digito_control (fecha DATE, id_efector INTEGER, id_servicio_estadistica INTEGER, id_servicio INTEGER)
    RETURNS CHAR(4)
    DETERMINISTIC
	COMMENT 'Genera el digito control compatibilidad SIPES'

BEGIN

	DECLARE digito1 INTEGER;
	DECLARE digito2 CHAR(1);
	DECLARE digito3 CHAR(1);
	DECLARE digito4 CHAR(1);
	
	DECLARE aux INTEGER;
	DECLARE sum_aux INTEGER;
	DECLARE len INTEGER;
	DECLARE i INTEGER;
	
	DECLARE claveestd CHAR(8);
	DECLARE cod_servicio_estadistica CHAR(5);
	DECLARE cod_servicio CHAR(3);
	
	
	/* digito 1 */
	
	SET aux = (SELECT DAY(fecha)*100 + MONTH(fecha)*1000 + YEAR(fecha));
	
	WHILE aux>9 DO
	
		SET len = LENGTH(aux);
		SET sum_aux = 0;
		SET i=1;
		
		WHILE i<=len DO
		
			SET sum_aux = sum_aux + ( SELECT SUBSTRING(aux,i,1) );
		
			SET i=i+1;
			
		END WHILE;
		
		SET aux = sum_aux;
		
	END WHILE;
	
	SET digito1 = aux;
	
	
	/* digito 2 */
		
	/* check si id_efector existe */
	SET claveestd = 
		(SELECT 
			e.claveestd 
		FROM 
			efectores e 
		WHERE 
			e.id_efector = id_efector);
	
	IF claveestd IS NULL THEN
		
		RETURN NULL;
		
	END IF;	
	
	SET aux=claveestd;
	
	WHILE aux>9 DO
	
		SET len = LENGTH(aux);
		SET sum_aux = 0;
		SET i=1;
		
		WHILE i<=len DO
		
			SET sum_aux = sum_aux + ( SELECT SUBSTRING(aux,i,1) );
		
			SET i=i+1;
			
		END WHILE;
		
		SET aux = sum_aux;
		
	END WHILE;
	
	SET digito2 = CHAR(64+aux);
		
	
	
	/* digito 3 */
		
	/* check si servicio_estadistica existe */
	SET cod_servicio_estadistica = 
		(SELECT 
			CONCAT(se.cod_servicio,se.sector,se.subsector) 
		FROM 
			servicios_estadistica se 
		WHERE 
			se.id_servicio_estadistica = id_servicio_estadistica);
	
	IF cod_servicio_estadistica IS NULL THEN
		
		RETURN NULL;
		
	END IF;
	
	SET aux=cod_servicio_estadistica;
	
	WHILE aux>9 DO
	
		SET len = LENGTH(aux);
		SET sum_aux = 0;
		SET i=1;
		
		WHILE i<=len DO
		
			SET sum_aux = sum_aux + ( SELECT SUBSTRING(aux,i,1) );
		
			SET i=i+1;
			
		END WHILE;
		
		SET aux = sum_aux;
		
	END WHILE;
	
	SET digito3 = CHAR(64+aux);
	
	
	
	/* digito 4 */
	
	/* check si el servicio existe */
	SET cod_servicio = 
		(SELECT 
			s.cod_servicio
		FROM 
			servicios s 
		WHERE 
			s.id_servicio = id_servicio);
	
	IF cod_servicio IS NULL THEN
		
		RETURN NULL;
		
	END IF;
	
	SET aux=cod_servicio;
	
	WHILE aux>9 DO
	
		SET len = LENGTH(aux);
		SET sum_aux = 0;
		SET i=1;
		
		WHILE i<=len DO
		
			SET sum_aux = sum_aux + ( SELECT SUBSTRING(aux,i,1) );
		
			SET i=i+1;
			
		END WHILE;
		
		SET aux = sum_aux;
		
	END WHILE;
	
	SET digito4 = CHAR(64+aux);
		
	RETURN CONCAT(digito1,digito2,digito3,digito4);
	
	
END$$

DELIMITER ;	