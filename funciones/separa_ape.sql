/* Fecha de ultima actualizacion 03/03/2011 */

DROP FUNCTION IF EXISTS str_separa_ape;


/** 
*	Funcion para separar el apellido y el nombre de un string.
*
*	@param		ape_nom		VARCHAR(255)	apellido y nombre todo junto. Si ape_nom es NULL la funcion devuelve NULL
*	@param		tipo		BOOLEAN			TRUE = apellido; FALSE = nombre
*	@return					VARCHAR(255)	si tipo es TRUE devuelve el string del apellido
*											si tipo es FALSE devuelve el string de nombre
*/

/* A procedure or function is considered “deterministic” if it always produces the same result for the 
	same input parameters, and “not deterministic” otherwise. If neither DETERMINISTIC nor NOT DETERMINISTIC 
	is given in the routine definition, the default is NOT DETERMINISTIC. */
	
DELIMITER $$

CREATE
    DEFINER = CURRENT_USER 
    FUNCTION str_separa_ape (ape_nom VARCHAR(255), tipo BOOLEAN)
    RETURNS VARCHAR(255)
    DETERMINISTIC
	COMMENT 'Devuelve el apellido de un STRING tipo apellido y nombre'

BEGIN
	DECLARE ape VARCHAR(255) DEFAULT '';
	DECLARE nom VARCHAR(255) DEFAULT '';
	DECLARE aux_ape_nom VARCHAR(255);
	DECLARE aux_char CHAR(1);
	DECLARE aux_i SMALLINT DEFAULT 1;
	DECLARE indice SMALLINT DEFAULT 1;
	
	/* check NULL */
	IF ISNULL(ape_nom) THEN 
		RETURN NULL; 
	END IF;
	
	/* hace un trim y limpia las comas */
	SET ape_nom = TRIM(REPLACE(ape_nom,","," "));
	
	/* limpia los puntos */
	SET ape_nom = TRIM(REPLACE(ape_nom,"."," "));
	
	/* limpia los asteriscos */
	SET ape_nom = TRIM(REPLACE(ape_nom,"*"," "));
	
	/* hace un upper case */
	SET aux_ape_nom = UPPER(ape_nom);
	
	/* saca los espacios de mas que hallan quedado */
	SET aux_i = 1;
	
	WHILE aux_i < LENGTH(aux_ape_nom) DO
	
		SET aux_char = SUBSTRING(aux_ape_nom,aux_i,1);
		
		IF aux_char=" " THEN
		
			IF SUBSTRING(aux_ape_nom,aux_i+1,1) = " " THEN
			
				SET aux_ape_nom = CONCAT(SUBSTRING(aux_ape_nom,
												1,
												aux_i),
									SUBSTRING(aux_ape_nom,
												aux_i+2,
												LENGTH(aux_ape_nom))
									);
				
			ELSE
				SET aux_i = aux_i + 1;
				
			END IF;
			
		ELSE
			SET aux_i = aux_i + 1;
		END IF;
	
	END WHILE;
	
	/* Setea la variable ape_nom que se usa al final de la funcion */
	SET ape_nom = aux_ape_nom;
	
	/* separa con el primer espacio */
	SET ape = SUBSTRING_INDEX(aux_ape_nom," ",1);
	
	/* si queda un apellido de menos de 3 digitos no puede ser */
	IF LENGTH(ape)<3 THEN
		SET indice=2;
	END IF;
	
	/* un solo espacio en blanco */
	IF	ape = "VON" 	OR
		ape = "SANTA"	OR
		ape = "DAL" 	OR
		ape = "DEL" 	OR
		ape = "VAN" 	OR
		ape = "SAN" 	OR
		ape = "MAC" 	OR
		ape = "DOS" 	OR
		ape = "DAS" 
		THEN
		SET indice=2;
	END IF;
	
	/* separa nuevamente con el 2do espacio */
	SET ape = SUBSTRING_INDEX(aux_ape_nom," ",2);
		
	/* dos espacios en blaco */
	IF	ape = "DE LA" 		OR 
		ape = "VON DER" 	OR
		ape = "DE LOS" 		OR
		ape = "PONCE DE"
		THEN
		SET indice=3;
	END IF;
	
	/* separa nuevamente con el valor que quedo en la variable indice*/
	SET ape = SUBSTRING_INDEX(ape_nom," ",indice);
	SET indice = LENGTH(ape)+2;
	SET nom = SUBSTRING(ape_nom,indice);
	
	/* devuelve el apellido o el nombre segun corresponda */
	IF tipo THEN
		RETURN TRIM(ape);
	ELSE
		RETURN TRIM(nom);
	END IF;
	
END$$

DELIMITER ;

/* FIN DE FUNCION PARA SEPARAR APELLIDO DEL NOMBRE */