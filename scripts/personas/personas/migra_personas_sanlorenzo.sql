/* --------------------------------------------------------------------- */
/* Hospital San Lorenzo - carga las personas del Hospital de San Lorenzo */
/* --------------------------------------------------------------------- */

/* inserta en "origen_info" */
INSERT IGNORE INTO origen_info(id_origen_info, origen_info) VALUES (13,"HOSPITAL SAN LORENZO");

/* inserta en "sistemas_propietarios" */
INSERT IGNORE INTO sistemas_propietarios
		(id_sistema_propietario, nom_corto, nom_largo, observacion) 
	VALUES 
		(6,
		'H. SAN LORENZO',
		'SAMCO GRANADEROS A CABALLO',
		'Migraci�n de los pacientes del sistema del hospital San Lorenzo 28/09/2011');

/* Hospital San Lorenzo, Granaderos a caballo ->	id_efector = 313	*/
SET @id_efector := 313;
	
/* marca en la tabla de migracion del hospital san lorenzo las personas NO fallecidas que ya esten en */
/* la tabla personas y SI esten fallecidas */
UPDATE personas p, clinhist_sanlorenzo csl
	SET csl.marca_borrado=TRUE
	WHERE	p.nro_doc = csl.CLINDOC
	AND		p.fallecido IS TRUE
	AND		p.tipo_doc = 'DNI'
	AND		es_documento('DNI',csl.CLINDOC,csl.CLINFCN) = 1;
	
	
		
/* Tabla de personas_sanlorenzo_docs_hc_inconsistentes */
DROP TABLE IF EXISTS personas_sanlorenzo_docs_hc_inconsistentes;

CREATE TABLE personas_sanlorenzo_docs_hc_inconsistentes (
	id_persona_sanlorenzo_doc_hc_inconsistente	INT(10) 		UNSIGNED    	NOT NULL AUTO_INCREMENT,
	id_efector									INTEGER			UNSIGNED		NOT NULL	COMMENT 'id del efector donde se obtiene la inconsistencia de documento',	
	clincod		 								VARCHAR(10)						NOT NULL	COMMENT 'Historia clinica del hospital de san lorenzo',
	id_localidad								INT(10) 		UNSIGNED    	NULL 		COMMENT 'id_localidad de tabla localidades',
	tipo_doc									CHAR(3)			 		      	NOT NULL	COMMENT 'Se unifico a los tipo del HMI1 en formato texto: DNI, LC, LE, CI, OTR, DNR',
	nro_doc										INT(10) 		UNSIGNED    	NOT NULL	COMMENT 'Numero de documento en formato numerico',
	apellido									VARCHAR(255)	 		     	NOT NULL,
	nombre										VARCHAR(255)	 		     	NOT NULL,
	sexo										CHAR(1) 				        NOT NULL		COMMENT 'F, M o I',
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
	PRIMARY KEY (id_persona_sanlorenzo_doc_hc_inconsistente),
	KEY fk_id_localidad (id_localidad),
	KEY fk_id_origen_info (id_origen_info),
	KEY idx_nro_doc (nro_doc),
	KEY idx_apellido (apellido),
	KEY idx_nombre (nombre),
	KEY idx_fecha_nac (fecha_nac),
	KEY idx_fallecido (fallecido),
	KEY idx_fecha_ultima_cond (fecha_ultima_cond)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 
COMMENT 'Documentos e historias clinicas inconsistentes';

/* deshabilita los indices de la tabla personas_sanlorenzo_docs_hc_inconsistentes */
ALTER TABLE personas_sanlorenzo_docs_hc_inconsistentes DISABLE KEYS;
	
/* ingresa en la tabla de inconsistencias las historias clinicas que tienen 'BIS' */
INSERT INTO	personas_sanlorenzo_docs_hc_inconsistentes
	SELECT
		/* id_persona_sanlorenzo_doc_hc_inconsistente	*/
		0,
		/* id_efector									*/
		@id_efector,
		/* clincod		 								*/
		TRIM(csl.CLINCOD),
		/* id_localidad								    */
		NULL,
        /* tipo_doc									    */
        'DNI',
		/* nro_doc										*/
		csl.CLINDOC,
		/* apellido									    */
		str_separa_ape(csl.CLINNOM,TRUE),
		/* nombre										*/
		str_separa_ape(csl.CLINNOM,FALSE),
		/* sexo										    */
		TRIM(csl.CLINSEX),
		/* dom_calle									*/
		TRIM(csl.CLINDOM),
		/* dom_nro										*/
		NULL,                          
		/* dom_dpto									    */
		NULL,
		/* dom_piso									    */
		NULL,
		/* dom_mza_monobloc							    */
		NULL,
		/* telefono_dom								    */
		TRIM(csl.CLINTEL),
		/* telefono_cel								    */
		NULL,
		/* barrio										*/
		NULL,
		/* localidad									*/
		NULL,
		/* departamento								    */
		NULL,
		/* provincia									*/
		NULL,
		/* pais										    */
		NULL,
		/* fecha_nac									*/
		csl.CLINFCN,
		/* ocupacion									*/
		csl.CLINOCU,
		/* tipo_doc_madre								*/
		NULL,
		/* nro_doc_madre								*/
		NULL,
		/* nivel_academico								*/
		csl.CLINESC,
		/* estado_civil								    */
		NULL,
		/* situacion_laboral							*/
		NULL,
		/* asociado									    */
		IF (
			TRIM(csl.CLINAFI)<>'0',
			'obra social',
			'ninguna'),
		/* fallecido									*/
		IF (csl.marca_borrado IS TRUE,TRUE,FALSE),             
		/* fecha_ultima_cond							*/
		csl.CLINFCC,
		/* id_origen_info								*/
		13,
		/* baja										    */
		FALSE
		
	FROM clinhist_sanlorenzo csl
	
	WHERE 
		csl.CLINCOD LIKE '%BIS%'
	OR	es_documento('DNI',csl.CLINDOC,csl.CLINFCN) = 0;

/* habilita los indices de la tabla personas_sanlorenzo_docs_hc_inconsistentes */
ALTER TABLE personas_sanlorenzo_docs_hc_inconsistentes ENABLE KEYS;		
	
						
/* antes de borrar las personas fallecidas de la tabla origen, guarda las historias */
/* clinicas de las personas con marca de borrado */
INSERT INTO hc_personas
	SELECT	0,
			@id_efector,
			(SELECT id_persona
				FROM personas p
				WHERE	'DNI'	= p.tipo_doc
				AND		csl.CLINDOC	= p.nro_doc
			),
			6,								/* id_sistema_propietario		*/
			NULL,							/* numero_paciente_sicap		*/
			NULL,							/* numero_grupo_familiar_sicap	*/
			NULL,							/* historia_familiar_sicap		*/
			NULL,							/* historia_personal_sicap		*/
			NULL,							/* his_cli_internacion_hmi		*/
			NULL,							/* his_cli_ce_hmi				*/
			NULL,							/* his_cli_sihos				*/
			CAST(csl.CLINCOD AS UNSIGNED),	/* his_cli_sistema_propietario	*/
			NULL							/* nr0_hc_diagnose				*/
	FROM clinhist_sanlorenzo csl
		
	WHERE 	
			csl.marca_borrado=TRUE
	AND		csl.CLINCOD NOT LIKE '%BIS%'
	AND		es_documento('DNI',csl.CLINDOC,csl.CLINFCN) = 1
	
	ON DUPLICATE KEY UPDATE
		
		his_cli_sistema_propietario = CAST(csl.CLINCOD AS UNSIGNED);

/* elimina de la tabla de auxiliar los que tienen marca de borrado */	
DELETE FROM clinhist_sanlorenzo
	WHERE	marca_borrado=TRUE;	
	
/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;

INSERT INTO personas
	SELECT
		/* id_persona	*/
		0,
		/* id_localidad								    */
		NULL,
        /* tipo_doc									    */
        'DNI',
		/* nro_doc										*/
		csl.CLINDOC,
		/* apellido									    */
		str_separa_ape(csl.CLINNOM,TRUE),
		/* nombre										*/
		str_separa_ape(csl.CLINNOM,FALSE),
		/* sexo										    */
		TRIM(csl.CLINSEX),
		/* dom_calle									*/
		TRIM(csl.CLINDOM),
		/* dom_nro										*/
		NULL,                          
		/* dom_dpto									    */
		NULL,
		/* dom_piso									    */
		NULL,
		/* dom_mza_monobloc							    */
		NULL,
		/* telefono_dom								    */
		TRIM(csl.CLINTEL),
		/* telefono_cel								    */
		NULL,
		/* barrio										*/
		NULL,
		/* localidad									*/
		NULL,
		/* departamento								    */
		NULL,
		/* provincia									*/
		NULL,
		/* pais										    */
		NULL,
		/* fecha_nac									*/
		csl.CLINFCN,
		/* ocupacion									*/
		csl.CLINOCU,
		/* tipo_doc_madre								*/
		NULL,
		/* nro_doc_madre								*/
		NULL,
		/* nivel_academico								*/
		csl.CLINESC,
		/* estado_civil								    */
		NULL,
		/* situacion_laboral							*/
		NULL,
		/* asociado									    */
		IF (
			TRIM(csl.CLINAFI)<>'0',
			'obra social',
			'ninguna'),
		/* fallecido									*/
		FALSE,             
		/* fecha_ultima_cond							*/
		csl.CLINFCC,
		/* id_origen_info								*/
		13,
		/* baja										    */
		FALSE
		
	FROM clinhist_sanlorenzo csl
	
	WHERE 
		es_documento('DNI',csl.CLINDOC,csl.CLINFCN) = 1
		
		
	ON DUPLICATE KEY UPDATE
		
		apellido =
			str_separa_ape(csl.CLINNOM,TRUE),
			
		nombre =
			str_separa_ape(csl.CLINNOM,FALSE),
			
		sexo =
			TRIM(csl.CLINSEX),
        	
        dom_calle =	
        	TRIM(csl.CLINDOM),
        
		telefono_dom = 
			TRIM(csl.CLINTEL),
					
		fecha_nac =	
			IFNULL(csl.CLINFCN,personas.fecha_nac),
			
		ocupacion =	
			IFNULL(csl.CLINOCU,personas.ocupacion),
		
		nivel_academico =
			IFNULL(csl.CLINESC,personas.nivel_academico),
				
		asociado =
			IF (TRIM(csl.CLINAFI)<>'0',
				'obra social',
				personas.asociado),
		
		fecha_ultima_cond =	
			csl.CLINFCC,
			
		id_origen_info = 13	;	
	
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
				WHERE	'DNI'	= p.tipo_doc
				AND		csl.CLINDOC	= p.nro_doc
			),
			6,								/* id_sistema_propietario		*/
			NULL,							/* numero_paciente_sicap		*/
			NULL,							/* numero_grupo_familiar_sicap	*/
			NULL,							/* historia_familiar_sicap		*/
			NULL,							/* historia_personal_sicap		*/
			NULL,							/* his_cli_internacion_hmi		*/
			NULL,							/* his_cli_ce_hmi				*/
			NULL,							/* his_cli_sihos				*/
			CAST(csl.CLINCOD AS UNSIGNED),	/* his_cli_sistema_propietario	*/
			NULL							/* nr0_hc_diagnose				*/
	FROM clinhist_sanlorenzo csl
		
	WHERE
			es_documento('DNI',csl.CLINDOC,csl.CLINFCN) = 1
	AND		csl.CLINCOD NOT LIKE '%BIS%'
	
	ON DUPLICATE KEY UPDATE
		
		his_cli_sistema_propietario = CAST(csl.CLINCOD AS UNSIGNED);
		
/* habilita los indices en historia clinicas de personas */
ALTER TABLE hc_personas ENABLE KEYS;