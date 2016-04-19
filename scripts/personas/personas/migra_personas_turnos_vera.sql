/* inserta en "origen_info" */
INSERT IGNORE INTO origen_info(id_origen_info, origen_info) VALUES (19,"SAMCO VERA - SISTEMA DE PROPIETARIO");
	
		
/* set id_efector de Vera */		
SET @id_efector := 340;



/* marca en la tabla de migracion del samco vera las personas NO fallecidas que ya esten en */
/* la tabla personas y SI esten fallecidas */
UPDATE personas p, pacientes_turnos_vera ptv
	SET ptv.marca_borrado=TRUE
	WHERE	p.nro_doc = ptv.DNI
	AND		p.fallecido IS TRUE
	AND		p.tipo_doc = ptv.TipoDoc;
	
	
		
/* Tabla de personas_vera_docs_inconsistentes */
DROP TABLE IF EXISTS personas_vera_docs_inconsistentes;

CREATE TABLE personas_vera_docs_inconsistentes (
	id_persona_vera_doc_inconsistente			INT(10) 		UNSIGNED    	NOT NULL AUTO_INCREMENT,
	id_efector									INTEGER			UNSIGNED		NOT NULL	COMMENT 'id del efector donde se obtiene la inconsistencia de documento',	
	id_localidad								INT(10) 		UNSIGNED    	NULL 		COMMENT 'id_localidad de tabla localidades',
	tipo_doc									CHAR(3)			 		      	NOT NULL	COMMENT 'Se unifico a los tipo del HMI1 en formato texto: DNI, LC, LE, CI, OTR, DNR',
	nro_doc										INT(10) 		UNSIGNED    	NOT NULL	COMMENT 'Numero de documento en formato numerico',
	apellido									VARCHAR(255)	 		     	NOT NULL,
	nombre										VARCHAR(255)	 		     	NOT NULL,
	sexo										CHAR(1) 				        NOT NULL	COMMENT 'F, M o I',
	dom_calle									VARCHAR(255)	 		     	NULL		COMMENT 'Nombre de la calle o calle y numero en los casos donde no se pueda separar',
	dom_nro										VARCHAR(20) 			      	NULL,
	dom_dpto									CHAR(3) 				        NULL,
	dom_piso									VARCHAR(5) 				      	NULL,
	dom_mza_monobloc							VARCHAR(40) 			      	NULL,
	telefono_dom								VARCHAR(30) 			      	NULL		COMMENT 'Telefono del domicilio o el unico que se obtenga',
	telefono_cel								VARCHAR(30) 			      	NULL		COMMENT 'Telefono celular en caso de obtenerlo',
	barrio										VARCHAR(255)	 		     	NULL,
	localidad									VARCHAR(255)	 		     	NULL		COMMENT 'Descripcion de la localidad obtenida. Si se pudo identificar id_localidad, es la descripcion correspondiente a dicho id en la tabla localidades',
	departamento								VARCHAR(255)	 		     	NULL		COMMENT 'Idem',
	provincia									VARCHAR(255)	 		     	NULL		COMMENT 'Idem',
	pais										VARCHAR(255)	 		     	NULL		COMMENT 'Idem',
	fecha_nac									DATE 					        NULL,
	ocupacion									VARCHAR(255)	 		     	NULL,
	tipo_doc_madre								CHAR(3)			 		      	NULL,
	nro_doc_madre								INT(10) 		UNSIGNED    	NULL,
	nivel_academico								VARCHAR(255)	 		     	NULL,
	estado_civil								VARCHAR(25) 			      	NULL,
	situacion_laboral							VARCHAR(255)	 		     	NULL,
	asociado									VARCHAR(50) 			      	NULL,
	fallecido									TINYINT(1) 				      	NOT NULL,
	fecha_ultima_cond							DATE 					        NULL,
	id_origen_info								TINYINT(3) 		UNSIGNED 		NOT NULL,
	baja										TINYINT(1) 				      	NOT NULL,
	PRIMARY KEY (id_persona_vera_doc_inconsistente),
	KEY fk_id_localidad (id_localidad),
	KEY fk_id_origen_info (id_origen_info),
	KEY idx_nro_doc (nro_doc),
	KEY idx_apellido (apellido),
	KEY idx_nombre (nombre),
	KEY idx_fecha_nac (fecha_nac),
	KEY idx_fallecido (fallecido),
	KEY idx_fecha_ultima_cond (fecha_ultima_cond)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 
COMMENT 'Docs inconsistentes del Samco Vera';

/* deshabilita los indices de la tabla personas_vera_docs_inconsistentes */
ALTER TABLE personas_vera_docs_inconsistentes DISABLE KEYS;
	
/* ingresa en la tabla de docs inconsistencias */
INSERT INTO	personas_vera_docs_inconsistentes
	SELECT
		/* id_persona_vera_doc_inconsistente	*/
		0,
		/* id_efector									*/
		@id_efector,
		/* id_localidad								    */
		ptv.id_localidad,
        /* tipo_doc									    */
        ptv.Tipodoc,
		/* nro_doc										*/
		ptv.DNI,
		/* apellido									    */
		str_separa_ape(ptv.Nombre,TRUE),
		/* nombre										*/
		str_separa_ape(ptv.Nombre,FALSE),
		/* sexo										    */
		ptv.sexo,
		/* dom_calle									*/
		TRIM(ptv.Direccion),
		/* dom_nro										*/
		NULL,
		/* dom_dpto									    */
		NULL,
		/* dom_piso									    */
		NULL,
		/* dom_mza_monobloc							    */
		NULL,
		/* telefono_dom								    */
		TRIM(ptv.Telefono),
		/* telefono_cel								    */
		NULL,
		/* barrio										*/
		NULL,
		/* localidad									*/		
		(SELECT 
			nom_loc 
		FROM 
			localidades l
		WHERE
			l.id_localidad = ptv.id_localidad),
		/* departamento								    */
		(SELECT 
			nom_dpto 
		FROM 
			departamentos d
		WHERE
			d.id_dpto =
			(SELECT
				l.id_dpto
			FROM
				localidades l
			WHERE
				l.id_localidad = ptv.id_localidad)
		),
		/* provincia									*/
		(SELECT 
			p.nom_prov 
		FROM 
			provincias p
		WHERE
			p.id_prov = ptv.id_prov),
		/* pais										    */
		(SELECT
				pa.nom_pais
			FROM
				paises pa,
				provincias p
			WHERE
				pa.id_pais = p.id_pais
			AND p.id_prov = ptv.id_prov),
		/* fecha_nac									*/
		ptv.FechaNac,
		/* ocupacion									*/
		NULL,
		/* tipo_doc_madre								*/
		NULL,
		/* nro_doc_madre								*/
		NULL,
		/* nivel_academico								*/
		NULL,
		/* estado_civil								    */
		NULL,
		/* situacion_laboral							*/
		NULL,
		/* asociado									    */
		NULL,
		/* fallecido									*/
		IF (ptv.marca_borrado IS TRUE,TRUE,FALSE),             
		/* fecha_ultima_cond							*/
		NULL,
		/* id_origen_info								*/
		19,
		/* baja										    */
		FALSE
		
	FROM 
		pacientes_turnos_vera ptv
	
	WHERE 
		es_documento(ptv.Tipodoc,ptv.DNI,ptv.FechaNac) = 0;

/* habilita los indices de la tabla personas_vera_docs_inconsistentes */
ALTER TABLE personas_vera_docs_inconsistentes ENABLE KEYS;		
		

/* elimina de la tabla de auxiliar los que tienen marca de borrado */	
DELETE FROM pacientes_gamen
	WHERE	marca_borrado=TRUE;	
	
	
/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;

/* ingresa los datos de las personas */
INSERT INTO personas
	SELECT

		/* id_persona									*/
		0,
		/* id_localidad								    */
		ptv.id_localidad,
        /* tipo_doc									    */
        ptv.Tipodoc,
		/* nro_doc										*/
		ptv.DNI,
		/* apellido									    */
		str_separa_ape(ptv.Nombre,TRUE),
		/* nombre										*/
		str_separa_ape(ptv.Nombre,FALSE),
		/* sexo										    */
		ptv.sexo,
		/* dom_calle									*/
		TRIM(ptv.Direccion),
		/* dom_nro										*/
		NULL,
		/* dom_dpto									    */
		NULL,
		/* dom_piso									    */
		NULL,
		/* dom_mza_monobloc							    */
		NULL,
		/* telefono_dom								    */
		TRIM(ptv.Telefono),
		/* telefono_cel								    */
		NULL,
		/* barrio										*/
		NULL,
		/* localidad									*/		
		(SELECT 
			nom_loc 
		FROM 
			localidades l
		WHERE
			l.id_localidad = ptv.id_localidad),
		/* departamento								    */
		(SELECT 
			nom_dpto 
		FROM 
			departamentos d
		WHERE
			d.id_dpto =
			(SELECT
				l.id_dpto
			FROM
				localidades l
			WHERE
				l.id_localidad = ptv.id_localidad)
		),
		/* provincia									*/
		(SELECT 
			p.nom_prov 
		FROM 
			provincias p
		WHERE
			p.id_prov = ptv.id_prov),
		/* pais										    */
		(SELECT
			pa.nom_pais
		FROM
			paises pa,
			provincias p
		WHERE
			pa.id_pais = p.id_pais
		AND p.id_prov = ptv.id_prov),
		/* fecha_nac									*/
		ptv.FechaNac,
		/* ocupacion									*/
		NULL,
		/* tipo_doc_madre								*/
		NULL,
		/* nro_doc_madre								*/
		NULL,
		/* nivel_academico								*/
		NULL,
		/* estado_civil								    */
		NULL,
		/* situacion_laboral							*/
		NULL,
		/* asociado									    */
		NULL,
		/* fallecido									*/
		IF (ptv.marca_borrado IS TRUE,TRUE,FALSE),             
		/* fecha_ultima_cond							*/
		NULL,
		/* id_origen_info								*/
		19,
		/* baja										    */
		FALSE
		
	FROM 
		pacientes_turnos_vera ptv
	
	WHERE 
		es_documento(ptv.Tipodoc,ptv.DNI,ptv.FechaNac) = 1
		
		
	ON DUPLICATE KEY UPDATE
		
		id_localidad = 
			IFNULL(ptv.id_localidad,personas.id_localidad),
		
		apellido =
			str_separa_ape(ptv.Nombre,TRUE),
			
		nombre =
			str_separa_ape(ptv.Nombre,FALSE),
			
		sexo =
			IFNULL(ptv.sexo,personas.sexo),
			
        dom_calle =	
        	IFNULL(TRIM(ptv.Direccion),personas.dom_calle),
        
		fecha_nac =	
			IFNULL(ptv.FechaNac,personas.fecha_nac),
		
		telefono_dom =
			IFNULL(TRIM(ptv.Telefono),personas.telefono_dom),
					
		localidad =
			IFNULL(
				(SELECT 
					nom_loc 
				FROM 
					localidades l
				WHERE
					l.id_localidad = ptv.id_localidad),
				personas.localidad),
		
		departamento =
			IFNULL(
				(SELECT 
					nom_dpto 
				FROM 
					departamentos d,
					localidades l
				WHERE
					d.id_dpto = l.id_dpto
				AND l.id_localidad = ptv.id_localidad
				),
				personas.departamento),
		
		provincia =
			IFNULL(
				(SELECT 
					p.nom_prov 
				FROM 
					provincias p
				WHERE
					p.id_prov = ptv.id_prov),
				personas.provincia),
				
		pais =
			IFNULL(				
				(SELECT
					pa.nom_pais
				FROM
					paises pa,
					provincias p
				WHERE
					pa.id_pais = p.id_pais
				AND p.id_prov = ptv.id_prov),
				personas.pais),
			
		id_origen_info = 19	;	
	
/* habilita los indices para la tabla personas */	
ALTER TABLE personas ENABLE KEYS;