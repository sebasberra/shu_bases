/* inserta en "origen_info" */
INSERT IGNORE INTO origen_info(id_origen_info, origen_info) VALUES (18,"HOSPITAL ANSELMO GAMEN - VILLA GDOR GALVEZ");

/* inserta en "sistemas_propietarios" */
INSERT IGNORE INTO sistemas_propietarios
		(id_sistema_propietario, nom_corto, nom_largo, observacion) 
	VALUES 
		(11,
		'HOSP ANSELMO GAMEN',
		'HOSPITAL ANSELMO GAMEN - VILLA GDOR GALVEZ',
		'Migración de los pacientes del sistema del SAMCO Gamen, Villa Gdor Galvez 22/10/2012');
		
		
/* set id_efector de Gdor Galvez */		
SET @id_efector := 168;




/* marca en la tabla de migracion del hospital gamen las personas NO fallecidas que ya esten en */
/* la tabla personas y SI esten fallecidas */
UPDATE personas p, pacientes_gamen pg
	SET pg.marca_borrado=TRUE
	WHERE	p.nro_doc = pg.nro_doc
	AND		p.fallecido IS TRUE
	AND		p.tipo_doc = pg.tipo_doc;
	
	
		
/* Tabla de personas_gamen_docs_inconsistentes */
DROP TABLE IF EXISTS personas_gamen_docs_inconsistentes;

CREATE TABLE personas_gamen_docs_inconsistentes (
	id_persona_gamen_doc_inconsistente			INT(10) 		UNSIGNED    	NOT NULL AUTO_INCREMENT,
	id_efector									INTEGER			UNSIGNED		NOT NULL	COMMENT 'id del efector donde se obtiene la inconsistencia de documento',	
	nro_hc		 								VARCHAR(10)						NOT NULL	COMMENT 'Historia clinica del hospital de cañada de gomez',
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
	PRIMARY KEY (id_persona_gamen_doc_inconsistente),
	KEY fk_id_localidad (id_localidad),
	KEY fk_id_origen_info (id_origen_info),
	KEY idx_nro_doc (nro_doc),
	KEY idx_apellido (apellido),
	KEY idx_nombre (nombre),
	KEY idx_fecha_nac (fecha_nac),
	KEY idx_fallecido (fallecido),
	KEY idx_fecha_ultima_cond (fecha_ultima_cond)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 
COMMENT 'Docs inconsistentes del Hosp Gamen';

/* deshabilita los indices de la tabla personas_gamen_docs_inconsistentes */
ALTER TABLE personas_gamen_docs_inconsistentes DISABLE KEYS;
	
/* ingresa en la tabla de docs inconsistencias */
INSERT INTO	personas_gamen_docs_inconsistentes
	SELECT
		/* id_persona_gamen_doc_inconsistente	*/
		0,
		/* id_efector									*/
		@id_efector,
		/* nro_hc		 								*/
		pg.nro_hc,
		/* id_localidad								    */
		pg.localidad,
        /* tipo_doc									    */
        pg.tipo_doc,
		/* nro_doc										*/
		pg.nro_doc,
		/* apellido									    */
		TRIM(pg.apellido),
		/* nombre										*/
		TRIM(CONCAT(TRIM(pg.nombre1),' ',TRIM(pg.nombre2))),
		/* sexo										    */
		pg.sexo,
		/* dom_calle									*/
		TRIM(pg.calle_nombre),
		/* dom_nro										*/
		CONCAT(
			TRIM(pg.calle_num),
			IF(
				TRIM(pg.i_calle)='BIS',
				'BIS',
				''
			)
		),
		/* dom_dpto									    */
		pg.dpto,
		/* dom_piso									    */
		pg.piso,
		/* dom_mza_monobloc							    */
		NULL,
		/* telefono_dom								    */
		TRIM(pg.telefono),
		/* telefono_cel								    */
		TRIM(pg.telefono2),
		/* barrio										*/
		NULL,
		/* localidad									*/		
		(SELECT 
			nom_loc 
		FROM 
			localidades l
		WHERE
			l.id_localidad = pg.localidad),
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
				l.id_localidad = pg.localidad)
		),
		/* provincia									*/
		(SELECT 
			p.nom_prov 
		FROM 
			provincias p,
			departamentos d,
			localidades l
		WHERE
			p.id_prov = d.id_prov
		AND	d.id_dpto = l.id_dpto
		AND	l.id_localidad = pg.localidad),
		/* pais										    */
		(SELECT
			pa.nom_pais
		FROM
			paises pa,
			provincias p,
			departamentos d, 
			localidades l
		WHERE
			pa.id_pais = p.id_pais
		AND p.id_prov = d.id_prov
		AND d.id_dpto = l.id_dpto
		AND l.id_localidad = pg.localidad),
		/* fecha_nac									*/
		pg.fecha_nac,
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
		IF (
			pg.os=0,
			'ninguna',
			'obra social'	
		),
		/* fallecido									*/
		IF (pg.marca_borrado IS TRUE,TRUE,FALSE),             
		/* fecha_ultima_cond							*/
		NULL,
		/* id_origen_info								*/
		18,
		/* baja										    */
		FALSE
		
	FROM 
		pacientes_gamen pg
	
	WHERE 
		es_documento(pg.tipo_doc,pg.nro_doc,pg.fecha_nac) = 0;

/* habilita los indices de la tabla personas_gamen_docs_inconsistentes */
ALTER TABLE personas_gamen_docs_inconsistentes ENABLE KEYS;		

	
/* antes de borrar las personas fallecidas de la tabla origen, guarda las historias */
/* clinicas de las personas con marca de borrado */
INSERT INTO hc_personas
	SELECT	0,
			@id_efector,
			(SELECT id_persona
				FROM personas p
				WHERE	pg.tipo_doc		= p.tipo_doc
				AND		pg.nro_doc		= p.nro_doc
			),
			11,								/* id_sistema_propietario		*/
			NULL,							/* numero_paciente_sicap		*/
			NULL,							/* numero_grupo_familiar_sicap	*/
			NULL,							/* historia_familiar_sicap		*/
			NULL,							/* historia_personal_sicap		*/
			NULL,							/* his_cli_internacion_hmi		*/
			NULL,							/* his_cli_ce_hmi				*/
			NULL,							/* his_cli_sihos				*/
			pg.nro_hc,						/* his_cli_sistema_propietario	*/
			NULL							/* nr0_hc_diagnose				*/
	FROM 
		pacientes_gamen pg
		
	WHERE 	
			pg.marca_borrado=TRUE
	AND		es_documento(pg.tipo_doc,pg.nro_doc,pg.fecha_nac) = 1
	AND		pg.nro_hc <> 0
	
	ON DUPLICATE KEY UPDATE
		
		id_sistema_propietario = 11,
		his_cli_sistema_propietario = pg.nro_hc;
		
		
		

/* elimina de la tabla de auxiliar los que tienen marca de borrado */	
DELETE FROM pacientes_gamen
	WHERE	marca_borrado=TRUE;	
	
	
/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;

/* ingresa los datos de las personas */
INSERT INTO personas
	SELECT
		/* id_persona	*/
		0,
		/* id_localidad								    */
		pg.localidad,
        /* tipo_doc									    */
        pg.tipo_doc,
		/* nro_doc										*/
		pg.nro_doc,
		/* apellido									    */
		TRIM(pg.apellido),
		/* nombre										*/
		TRIM(CONCAT(TRIM(pg.nombre1),' ',TRIM(pg.nombre2))),
		/* sexo										    */
		pg.sexo,
		/* dom_calle									*/
		TRIM(pg.calle_nombre),
		/* dom_nro										*/
		CONCAT(
			TRIM(pg.calle_num),
			IF(
				TRIM(pg.i_calle)='BIS',
				'BIS',
				''
			)
		),
		/* dom_dpto									    */
		pg.dpto,
		/* dom_piso									    */
		pg.piso,
		/* dom_mza_monobloc							    */
		NULL,
		/* telefono_dom								    */
		TRIM(pg.telefono),
		/* telefono_cel								    */
		TRIM(pg.telefono2),
		/* barrio										*/
		NULL,
		/* localidad									*/		
		(SELECT 
			nom_loc 
		FROM 
			localidades l
		WHERE
			l.id_localidad = pg.localidad),
		/* departamento								    */
		(SELECT 
			nom_dpto 
		FROM 
			departamentos d,
			localidades l
		WHERE
			d.id_dpto = l.id_dpto
		AND l.id_localidad = pg.localidad
		),
		/* provincia									*/
		(SELECT 
			p.nom_prov 
		FROM 
			provincias p,
			departamentos d,
			localidades l
		WHERE
			p.id_prov = d.id_prov
		AND	d.id_dpto = l.id_dpto
		AND	l.id_localidad = pg.localidad),
		/* pais										    */
		(SELECT
			pa.nom_pais
		FROM
			paises pa,
			provincias p,
			departamentos d, 
			localidades l
		WHERE
			pa.id_pais = p.id_pais
		AND p.id_prov = d.id_prov
		AND d.id_dpto = l.id_dpto
		AND l.id_localidad = pg.localidad),
		/* fecha_nac									*/
		pg.fecha_nac,
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
		IF (
			pg.os=0,
			'ninguna',
			'obra social'	
		),
		/* fallecido									*/
		FALSE,             
		/* fecha_ultima_cond							*/
		NULL,
		/* id_origen_info								*/
		18,
		/* baja										    */
		FALSE
		
	FROM
	 
		pacientes_gamen pg
	
	WHERE 
	
		es_documento(pg.tipo_doc,pg.nro_doc,pg.fecha_nac) = 1
		
		
	ON DUPLICATE KEY UPDATE
		
		id_localidad = 
			IFNULL(pg.localidad,personas.id_localidad),
		
		apellido =
			TRIM(pg.apellido),
			
		nombre =
			TRIM(CONCAT(TRIM(pg.nombre1),' ',TRIM(pg.nombre2))),
			
		sexo =
			IFNULL(pg.sexo,personas.sexo),
			
        dom_calle =	
        	IFNULL(TRIM(pg.calle_nombre),personas.dom_calle),
        
        dom_nro = 
        	IFNULL(
        			CONCAT(
						TRIM(pg.calle_num),
						IF(
							TRIM(pg.i_calle)='BIS',
							'BIS',
							''
						)
					), personas.dom_nro),
		fecha_nac =	
			IFNULL(pg.fecha_nac,personas.fecha_nac),
		
		telefono_dom =
			IFNULL(TRIM(pg.telefono),personas.telefono_dom),
			
		telefono_cel =
			IFNULL(TRIM(pg.telefono2),personas.telefono_cel),
					
		localidad =
			IFNULL(
				(SELECT 
					nom_loc 
				FROM 
					localidades l
				WHERE
					l.id_localidad = pg.localidad),
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
				AND l.id_localidad = pg.localidad
				),
				personas.departamento),
		
		provincia =
			IFNULL(
				(SELECT 
					p.nom_prov 
				FROM 
					provincias p,
					departamentos d,
					localidades l
				WHERE
					p.id_prov = d.id_prov
				AND	d.id_dpto = l.id_dpto
				AND	l.id_localidad = pg.localidad),
				personas.provincia),
				
		pais =
			IFNULL(				
				(SELECT
					pa.nom_pais
				FROM
					paises pa,
					provincias p,
					departamentos d, 
					localidades l
				WHERE
					pa.id_pais = p.id_pais
				AND p.id_prov = d.id_prov
				AND d.id_dpto = l.id_dpto
				AND l.id_localidad = pg.localidad),
				personas.pais),
					
		asociado =
			IF (
				pg.os=0,
				'ninguna',
				'obra social'	
			),
			
		id_origen_info = 18	;	
	
/* habilita los indices para la tabla personas */	
ALTER TABLE personas ENABLE KEYS;


/* Deshabilita los indices de historias clinicas de personas */
ALTER TABLE hc_personas DISABLE KEYS;

/* inserta las historias clinicas */ 
INSERT INTO hc_personas
	SELECT	0,
			@id_efector,
			(SELECT id_persona
				FROM personas p
				WHERE	pg.tipo_doc		= p.tipo_doc
				AND		pg.nro_doc		= p.nro_doc
			),
			11,								/* id_sistema_propietario		*/
			NULL,							/* numero_paciente_sicap		*/
			NULL,							/* numero_grupo_familiar_sicap	*/
			NULL,							/* historia_familiar_sicap		*/
			NULL,							/* historia_personal_sicap		*/
			NULL,							/* his_cli_internacion_hmi		*/
			NULL,							/* his_cli_ce_hmi				*/
			NULL,							/* his_cli_sihos				*/
			nro_hc,							/* his_cli_sistema_propietario	*/
			NULL							/* nr0_hc_diagnose				*/
	FROM 
		pacientes_gamen pg
		
	WHERE 	
			es_documento(pg.tipo_doc,pg.nro_doc,pg.fecha_nac) = 1
	AND		pg.nro_hc <> 0
	
	ON DUPLICATE KEY UPDATE
		
		id_sistema_propietario = 11,
		his_cli_sistema_propietario = pg.nro_hc;
		
/* habilita los indices en historia clinicas de personas */
ALTER TABLE hc_personas ENABLE KEYS;