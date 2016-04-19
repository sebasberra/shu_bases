/* Fecha de ultima actualizacion 15/03/2011 */

DROP FUNCTION IF EXISTS es_documento;

/** 
*	Funcion para hacer una validacion basica de un documento
*
*	@param		tipo		CHAR(3)			Tipos de documentos 
*																	"1" o "DNI"
*																	"2" o "LC"
*																	"3" o "LE"
*																	"4" o "CI"
*																	"5" o "OTR"
*
*	@param		nro			INTEGER			Numero de documento
*	@param		fecha_nac	DATE
*	@return					BOOLEAN			si TRUE el un documento valido, si no es FALSE
*/

/* A procedure or function is considered “deterministic” if it always produces the same result for the 
	same input parameters, and “not deterministic” otherwise. If neither DETERMINISTIC nor NOT DETERMINISTIC 
	is given in the routine definition, the default is NOT DETERMINISTIC. */
	
DELIMITER $$

CREATE
    DEFINER = CURRENT_USER 
    FUNCTION es_documento (tipo CHAR(3), nro INTEGER, fecha_nac DATE)
    RETURNS BOOLEAN
    DETERMINISTIC
	COMMENT 'Valida si un documento es valido'

BEGIN

	DECLARE tipo_doc CHAR(1);
	
	/* TRIM y UCASE para tipo de documento */
	SET tipo=TRIM(UCASE(tipo));
	
	/* guarda tipo y nro de doc en variable */
	SET tipo_doc=LEFT(tipo,1);
	
	/* check
	
	/* transforma el tipo de doc */
	CASE tipo
		
		WHEN 'DNI'	THEN SET tipo_doc='1';
		WHEN 'LC'	THEN SET tipo_doc='2';
		WHEN 'LE'	THEN SET tipo_doc='3';
		WHEN 'CI'	THEN SET tipo_doc='4';
		WHEN 'OTR'	THEN SET tipo_doc='5';
		ELSE
	        BEGIN
	
	            /* valida el tipo de doc */
				IF 	tipo_doc!=1
					AND tipo_doc!=2
					AND tipo_doc!=3
					AND tipo_doc!=4
					AND tipo_doc!=5	THEN RETURN FALSE;
				END IF;
				
    	    END;
    END CASE;
	
    /* check tipo entre 1 y 5 */
	IF CONVERT(tipo_doc,UNSIGNED INTEGER)>5 THEN 
		RETURN FALSE;
	END IF;
	
	/* check nro de documento mayor igual a 10000 */
	IF nro<10000 THEN
		RETURN FALSE;
	END IF;
	
    /* fecha de nacimiento */
    IF fecha_nac IS NOT NULL AND fecha_nac!='0000-00-00' THEN
    
    	/* LC Y LE : año 1968 */
    	
    	/*IF YEAR(fecha_nac)<1968 THEN
    	
    		/* No se puede saber como check si libreta civica o enrolamiento */
    		/*IF tipo_doc!='2' AND tipo_doc!='3' THEN
    		
    			RETURN FALSE;
    		END IF;
    		
    	END IF;*/
    	
    		
    	/* DNI */
    	IF tipo_doc=1 THEN
    	
    		/* DNI extranjeros */
    		IF nro>=90000000 AND nro<98000000 THEN
    			
    			RETURN TRUE;
    		END IF;
    		
    		/* DNI extranjeros provisorios */
    		IF nro>=60000000 AND nro<65000000 THEN
    			
    			RETURN TRUE;
    		END IF;
    		
    		/* LE y LC pasados a DNI */
    		IF YEAR(fecha_nac)<=1968 AND nro>10000000 THEN
    			
    			/* devuelve TRUE porque hay ciudadanos que le dieron nro de DNI */
    			RETURN TRUE;
    		END IF;
    		
    		/* 1970 */
    		IF YEAR(fecha_nac)<=1970 AND nro>22000000 THEN
    		
    			RETURN FALSE;
    		END IF;
    		
    		/* 1970-1975 */
    		IF YEAR(fecha_nac)>1970 AND
    			YEAR(fecha_nac)<1975 AND 
    			(nro<20000000 OR nro>26000000) THEN
    		
    			RETURN FALSE;
    		END IF;
    		
    		/* 1975-1980 */
    		IF YEAR(fecha_nac)>=1975 AND
    			YEAR(fecha_nac)<1980 AND 
    			(nro<23000000 OR nro>32000000) THEN
    		
    			RETURN FALSE;
    		END IF;
    		
    		/* 1980-1985 */
    		IF YEAR(fecha_nac)>=1980 AND
    			YEAR(fecha_nac)<1985 AND 
    			(nro<27000000 OR nro>35000000) THEN
    		
    			RETURN FALSE;
    		END IF;
    		
    		/* 1985-1990 */
    		IF YEAR(fecha_nac)>=1985 AND
    			YEAR(fecha_nac)<1990 AND 
    			(nro<29000000 OR nro>37000000) THEN
    		
    			RETURN FALSE;
    		END IF;
    		
    		/* 1990 - 1995 */
    		IF YEAR(fecha_nac)>=1990 AND
    			YEAR(fecha_nac)<=1995 AND 
    			(nro<32000000 OR nro>43000000) THEN
    		
    			RETURN FALSE;
    		END IF;
    		
    		/* 1995-2000 */
    		IF YEAR(fecha_nac)>=1995 AND 
    			YEAR(fecha_nac)<2000 AND 
    			(nro<35000000 OR nro>46000000) THEN
    		
    			RETURN FALSE;
    		END IF;
    		
    		/* 2000-2005 */
    		IF YEAR(fecha_nac)>=2000 AND 
    			YEAR(fecha_nac)<2005 AND 
    			(nro<39000000 OR nro>50000000) THEN
    		
    			RETURN FALSE;
    		END IF;
    		
    		/* 2005-2010 */
    		IF YEAR(fecha_nac)>=2005 AND
    			YEAR(fecha_nac)<2010 AND 
    			(nro<42000000 OR nro>53000000) THEN
    		
    			RETURN FALSE;
    		END IF;
    		
    		/* 2010- en adelante */
    		IF YEAR(fecha_nac)>=2010 AND
    			nro<47000000 THEN
    		
    			RETURN FALSE;
    		END IF;
    	END IF;
    	
    END IF;
    
	
	
	
	RETURN TRUE;
	
END$$

DELIMITER ;

/* FIN DE FUNCION PARA VALIDAR EL NUMERO DE DOCUMENTO */