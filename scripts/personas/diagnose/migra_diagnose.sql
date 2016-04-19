/* carga con informacion de la tabla "paciente" del "diagnose", la tabla auxiliar "diagnose_paciente_personas" */
/* que se usa para cargar la base personas */

/* En caso de que la base del "diagnose" tenga otro nombre, editar abajo dicho nombre */
USE diagnose;

DELIMITER ;


SET character_set_database = latin1;
SET character_set_server = latin1;
SET collation_database = latin1_swedish_ci;
SET collation_server = latin1_swedish_ci;


CREATE DATABASE IF NOT EXISTS migra_diagnose_personas;



/* Fecha de ultima actualizacion 03/03/2011 */
	
DROP FUNCTION IF EXISTS migra_diagnose_personas.str_separa_ape;



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
    FUNCTION migra_diagnose_personas.str_separa_ape (ape_nom VARCHAR(255), tipo BOOLEAN)
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





/* hace drop de la tabla auxiliar de migracion */
DROP TABLE IF EXISTS migra_diagnose_personas.diagnose_paciente_personas;

/* crea la tabla auxiliar que se usa para migrar los datos del diagnose */
CREATE TABLE migra_diagnose_personas.diagnose_paciente_personas (
	id_localidad 		INTEGER(10) 	UNSIGNED 	NULL,
	tipo_doc 			VARCHAR(15) 				NOT NULL,
	nro_doc 			INTEGER 		UNSIGNED	NOT NULL,
	apellido 			VARCHAR(255) 				NOT NULL,
	nombre 				VARCHAR(255) 				NOT NULL,
	sexo 				CHAR(1) 					NOT NULL,
	dom_calle 			VARCHAR(255) 				NULL,
	dom_nro 			VARCHAR(20) 				NULL,
	dom_dpto 			CHAR(3) 					NULL,
	dom_piso 			VARCHAR(5) 					NULL,
	dom_mza_monobloc 	VARCHAR(40) 				NULL,
	telefono_dom 		VARCHAR(30) 				NULL,
	telefono_cel 		VARCHAR(30) 				NULL,
	barrio 				VARCHAR(255) 				NULL,
	localidad 			VARCHAR(255) 				NULL,
	departamento 		VARCHAR(255) 				NULL,
	provincia 			VARCHAR(255) 				NULL,
	pais 				VARCHAR(255) 				NULL,
	fecha_nac 			DATE 						NULL,
	ocupacion 			VARCHAR(255) 				NULL,
	tipo_doc_madre 		VARCHAR(15) 				NULL,
	nro_doc_madre 		VARCHAR(255) 				NULL,
	nivel_academico 	VARCHAR(255) 				NULL,
	estado_civil 		VARCHAR(25) 				NULL,
	situacion_laboral 	VARCHAR(255) 				NULL,
	asociado 			VARCHAR(50) 				NULL,
	fallecido 			BOOLEAN 					NOT NULL,
	fecha_ultima_cond 	DATE 						NULL,
	nr0_hc				INTEGER						NOT NULL,
	marca_borrado		BOOLEAN						NOT NULL,
	marca_diferente		BOOLEAN						NOT NULL,
	FOREIGN KEY fk_id_localidad (id_localidad)
	REFERENCES localidades(id_localidad)
		ON DELETE RESTRICT
		ON UPDATE RESTRICT
	) ENGINE=MyISAM;

	
/* crea un indice unico para tipo y nro de doc */
CREATE UNIQUE INDEX idx_unique_tipo_nro_doc ON migra_diagnose_personas.diagnose_paciente_personas (tipo_doc,nro_doc);

/* crea indice unico para el numero de historia clinica "nr0_hc" */
CREATE UNIQUE INDEX idx_unique_nr0_hc ON migra_diagnose_personas.diagnose_paciente_personas (nr0_hc);

/* indice para nro de documento "nro_doc" */
CREATE INDEX idx_nro_doc ON migra_diagnose_personas.diagnose_paciente_personas (nro_doc);

CREATE INDEX idx_fallecido ON migra_diagnose_personas.diagnose_paciente_personas (fallecido);


/* Deshabilita los indices de la tabla auxiliar */
ALTER TABLE migra_diagnose_personas.diagnose_paciente_personas DISABLE KEYS;

/* inserta los pacientes del diagnose en la tabla auxiliar de personas */
INSERT INTO migra_diagnose_personas.diagnose_paciente_personas
	SELECT 
		dp.in_idlocalidad,
		dp.tipo_doc,
		dp.nro_doc,
		TRIM(IF(dp.st_nombre IS NULL,migra_diagnose_personas.str_separa_ape(dp.ape_y_nom,TRUE),dp.ape_y_nom)),
		TRIM(IF(dp.st_nombre IS NULL,migra_diagnose_personas.str_separa_ape(dp.ape_y_nom,FALSE),st_nombre)),
		dp.sexo,
		UCASE(dp.domicilio),
		UCASE(dp.nro_dom),
		UCASE(dp.dom_dep),
		UCASE(dp.dom_piso),
		NULL,
		UCASE(telefono),
		NULL,
		(SELECT detalle 
			FROM common c 
			WHERE c.id=dp.idbarrio),
		UCASE(localidad),
		(SELECT d.nom_dpto 
			FROM departamentos d, localidades l
			WHERE	l.id_localidad	= dp.in_idlocalidad
			AND		d.id_dpto 		= l.id_dpto),
		(SELECT p.nom_prov
			FROM provincias p, departamentos d, localidades l
			WHERE	l.id_localidad	= dp.in_idlocalidad
			AND		d.id_dpto		= l.id_dpto
			AND		p.id_prov		= d.id_prov),
		(SELECT p.nom_prov
			FROM paises pa, provincias p, departamentos d, localidades l
			WHERE	l.id_localidad	= dp.in_idlocalidad
			AND		d.id_dpto		= l.id_dpto
			AND		p.id_prov		= d.id_prov
			AND		pa.id_pais		= p.id_pais),
		dp.fecha_nac,
		UCASE(dp.ocupacion),
		(CASE dp.madre_tipodoc
			WHEN 'DNI' THEN 'DNI'
			WHEN 'LC'  THEN 'LC'
			WHEN 'CI'  THEN 'CI'
			WHEN 'OTR' THEN 'OTR'
			ELSE NULL
		END),
		dp.madre_documento,
		(SELECT c.detalle 
			FROM common c
			WHERE c.id=dp.nivel_academico
		),
		IF(dp.in_idestadocivil<>NULL,
			(SELECT c.detalle
				FROM common c
				WHERE c.id = dp.in_idestadocivil
			),
			IF(dp.estado_civil='',NULL,dp.estado_civil)
		),
		IF(dp.chk_busca=0,
			'no busca trabajo',
			'busca trabajo'
		),
		(CASE dp.cobertura
			WHEN 'Mas de una Cobertura' 		THEN 'MAS DE UNO'
			WHEN 'Sin Cobertura'				THEN 'NINGUNO'
			WHEN 'Obra Social'					THEN 'OBRA SOCIAL'
			WHEN 'Plan o seguro Publico'		THEN 'PLAN O SEGURO PUBLICO'
			WHEN 'Plan Salud Privado/Mutual'	THEN 'PLAN DE SALUD PRIVADO O LABORAL'
			ELSE NULL
		END),
		dp.in_obito,
		(SELECT MAX(t.dt_fecha)
			FROM turnos t
			WHERE t.paciente = dp.nr0_hc),
		dp.nr0_hc,
		FALSE,
		FALSE
		
		FROM paciente dp
		WHERE	dp.ape_y_nom<>'PACIENTE'
		AND		dp.in_Active=1;
		
		
/* Deshabilita los indices de la tabla auxiliar */
ALTER TABLE migra_diagnose_personas.diagnose_paciente_personas ENABLE KEYS;