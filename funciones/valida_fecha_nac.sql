/* Fecha de ultima actualizacion 14/03/2011 */

DROP FUNCTION IF EXISTS valida_fecha_nac;

/** 
*	Valida si la fecha tiene una fecha como año, por ejemplo, '0088' lo pase a 1988 y
*	que no sea una fecha mayor a la fecha actual.
*	Mysql interpreta un nro entre 00 - 69 como 2000 a 2069 y un nro entre 70 - 99 
*	como 1970 a 1999
*
*	@param		fecha		DATE
*	@return					DATE			Fecha con formato 'yyyy-mm-dd'
*/

/* A procedure or function is considered “deterministic” if it always produces the same result for the 
	same input parameters, and “not deterministic” otherwise. If neither DETERMINISTIC nor NOT DETERMINISTIC 
	is given in the routine definition, the default is NOT DETERMINISTIC. */
	
DELIMITER $$

CREATE
    DEFINER = CURRENT_USER 
    FUNCTION valida_fecha_nac (fecha DATE)
    RETURNS DATE
    DETERMINISTIC
	COMMENT 'Valida el año y controla contra fecha actual'

BEGIN

	DECLARE anio CHAR(4);
	DECLARE rango_desde TINYINT;
	DECLARE rango_hasta TINYINT;
	DECLARE aux_fecha DATE;
	DECLARE aux_now DATE;
	
	/* inicializa los rangos desde y hasta con los valores que utiliza el MySql */
	/* en las transformaciones de años. Mysql interpreta un nro entre 00 - 69 	*/
	/* como 2000 a 2069 y un nro entre 70 - 99 como 1970 a 1999					*/
	SET rango_desde = 70;
	SET rango_hasta = 99;
	
	/* sale si fecha es 0000-00-00 o NULL */
	IF fecha='0000-00-00' OR
		fecha IS NULL THEN
			RETURN fecha;
	END IF;
	
	
	/* tranforma el año a 4 digitos */
	IF YEAR(fecha)<10 THEN
	
		SET anio = CONCAT('200',YEAR(fecha));
		
	ELSE
		
		IF YEAR(fecha)<=rango_hasta 
			AND YEAR(fecha)>=rango_desde THEN
			
			SET anio = CONCAT('19',YEAR(fecha));
			
		ELSE
			
			SET anio = YEAR(fecha);
			
		END IF;
		
	END IF;

	/* check si la fecha es mayor a la fecha actual, en tal caso transforma el año a 19xx */
	SET aux_fecha = DATE_FORMAT ( CONCAT(anio,'-',MONTH(fecha),'-',DAY(fecha)), '%Y-%m-%d');
	SET aux_now=DATE(NOW());
	
	IF aux_fecha>DATE(NOW()) THEN
	
		SET anio = CONCAT('19',RIGHT(anio,2));
		
	END IF;
	
	/* rearma la fecha y retorna */
	RETURN DATE_FORMAT ( CONCAT(anio,'-',MONTH(fecha),'-',DAY(fecha)), '%Y-%m-%d');
	
END$$

DELIMITER ;

/* FIN DE FUNCION PARA TRANSFORMAR FECHAS CON AÑOS DE 2 DIGITOS A 4 DIGITOS EN UN RANGO */