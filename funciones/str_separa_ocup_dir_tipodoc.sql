/** 
*	Funcion para obtener la ocupacion, el domicilio, el tipo de documento del padron electoral
*
*	@param		ocup_dir_tipodoc	VARCHAR(255)	campo con la ocupacion, el domicilio y el tipo de documento separados por comas
*	@param		tipo				CHAR(1)			"O" = ocupacion; "D" = direccion; "T" = tipo de documento
*	@return							VARCHAR(255)	descripcion correspondiente
*/

/* A procedure or function is considered “deterministic” if it always produces the same result for the 
	same input parameters, and “not deterministic” otherwise. If neither DETERMINISTIC nor NOT DETERMINISTIC 
	is given in the routine definition, the default is NOT DETERMINISTIC. */

DELIMITER ;
	
DROP FUNCTION IF EXISTS str_separa_ocup_dir_tipodoc;

DELIMITER $$

CREATE
    DEFINER = CURRENT_USER 
    FUNCTION str_separa_ocup_dir_tipodoc (ocup_dir_tipodoc VARCHAR(255), tipo CHAR(1) )
    RETURNS VARCHAR(255)
    DETERMINISTIC
	COMMENT 'Se aplica a la migracion del padron electoral'

BEGIN
	DECLARE ocup VARCHAR(255);
	DECLARE direccion VARCHAR(255);
	DECLARE aux_direccion VARCHAR(255);
	DECLARE tipodoc VARCHAR(255);
	DECLARE aux_tipodoc VARCHAR(255);
	
	/* check NULL */
	IF ISNULL(ocup_dir_tipodoc) OR ISNULL(tipo) THEN 
		RETURN NULL; 
	END IF;
	
	/* ucase de tipo */
	SET tipo = UPPER(tipo);
	
	/* hace un trim */
	SET ocup_dir_tipodoc = TRIM(ocup_dir_tipodoc);
	
	/* obtiene la ocupacion */
	SET ocup = SUBSTRING_INDEX(ocup_dir_tipodoc,",",1);
	IF tipo="O" THEN
		RETURN TRIM(ocup);
	END IF;
	
	/* obtiene la direccion */
	SET aux_direccion = SUBSTRING(ocup_dir_tipodoc,LENGTH(ocup)+2);
	SET direccion = SUBSTRING_INDEX(aux_direccion,",",1);
	IF tipo="D" THEN
		RETURN TRIM(direccion);
	END IF;
	
	/* obtiene el tipo de documento */
	IF tipo="T" THEN
		
		/* devuelve nulo si no esta el tipo de documento */
		IF LENGTH(aux_direccion)=LENGTH(direccion) THEN
			RETURN NULL;
		END IF;
		
		/* carga en una variable auxiliar el resto del texto para sacar el tipo de documento */
		SET aux_tipodoc = SUBSTRING(aux_direccion,LENGTH(direccion)+2);
		SET aux_tipodoc = UPPER(TRIM(aux_tipodoc));
		
		/* DNI */
		IF LOCATE('DNI',aux_tipodoc)<>0 THEN
			RETURN 'DNI';
		END IF;
		
		/* LC */
		IF LOCATE('LC',aux_tipodoc)<>0 THEN
			RETURN 'LC';
		END IF;
		
		/* LE */
		IF LOCATE('LE',aux_tipodoc)<>0 THEN
			RETURN 'LE';
		END IF;
		
		/* DN */
		IF LOCATE('DN',aux_tipodoc)<>0 THEN
			RETURN 'DNI';
		END IF;
		
		/* si llego aqui es porque no se sabe que tipo de documento es */
		RETURN NULL;
	END IF;
	
	/* si llego aqui es porque el parametro 'tipo' no es ni 'O', ni 'D', ni 'T' */
	RETURN NULL;
	
END$$