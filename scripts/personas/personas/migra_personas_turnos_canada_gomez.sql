/* inserta en "origen_info" */
INSERT IGNORE INTO origen_info(id_origen_info, origen_info) VALUES (15,"HOSP SAN JOSE - CAÑADA DE GOMEZ");

/* inserta en "sistemas_propietarios" */
INSERT IGNORE INTO sistemas_propietarios
		(id_sistema_propietario, nom_corto, nom_largo, observacion) 
	VALUES 
		(8,
		'HOSP SAN JOSE',
		'HOSP SAN JOSE - CAÑADA DE GOMEZ',
		'Migración de los pacientes del sistema de Cañada de Gomez 27/04/2012');
		
		
/* set id_efector de Cañada de Gomez */		
SET @id_efector := 38;


/* pone 0 a una historia clinica de cada par de repetidas */
UPDATE 
	pacientes_turnos_canada_gomez pcg ,
	historias_repetidas_docs_act hda
SET
	pcg.num_histo = 0
WHERE

	pcg.tipo = hda.tipo1
AND	pcg.documento = hda.documento1;


/* marca en la tabla de migracion del hospital cañada de gomez las personas NO fallecidas que ya esten en */
/* la tabla personas y SI esten fallecidas */
UPDATE personas p, pacientes_turnos_canada_gomez pcg
	SET pcg.marca_borrado=TRUE
	WHERE	p.nro_doc = pcg.documento
	AND		p.fallecido IS TRUE
	AND		p.tipo_doc = pcg.tipo;
	
	
		
/* Tabla de personas_canadagomez_docs_inconsistentes */
DROP TABLE IF EXISTS personas_canadagomez_docs_inconsistentes;

CREATE TABLE personas_canadagomez_docs_inconsistentes (
	id_persona_canadagomez_doc_inconsistente	INT(10) 		UNSIGNED    	NOT NULL AUTO_INCREMENT,
	id_efector									INTEGER			UNSIGNED		NOT NULL	COMMENT 'id del efector donde se obtiene la inconsistencia de documento',	
	historia	 								VARCHAR(10)						NOT NULL	COMMENT 'Historia clinica del hospital de cañada de gomez',
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
	PRIMARY KEY (id_persona_canadagomez_doc_inconsistente),
	KEY fk_id_localidad (id_localidad),
	KEY fk_id_origen_info (id_origen_info),
	KEY idx_nro_doc (nro_doc),
	KEY idx_apellido (apellido),
	KEY idx_nombre (nombre),
	KEY idx_fecha_nac (fecha_nac),
	KEY idx_fallecido (fallecido),
	KEY idx_fecha_ultima_cond (fecha_ultima_cond)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 
COMMENT 'Documentos inconsistentes de Cañada de Gomez';

/* deshabilita los indices de la tabla personas_canadagomez_docs_inconsistentes */
ALTER TABLE personas_canadagomez_docs_inconsistentes DISABLE KEYS;
	
/* ingresa en la tabla de docs inconsistencias */
INSERT INTO	personas_canadagomez_docs_inconsistentes
	SELECT
		/* id_persona_canadagomez_doc_inconsistente	*/
		0,
		/* id_efector									*/
		@id_efector,
		/* clincod		 								*/
		pcg.num_histo,
		/* id_localidad								    */
		pcg.id_localidad,
        /* tipo_doc									    */
        pcg.tipo,
		/* nro_doc										*/
		pcg.documento,
		/* apellido									    */
		str_separa_ape(pcg.nombre,TRUE),
		/* nombre										*/
		str_separa_ape(pcg.nombre,FALSE),
		/* sexo										    */
		IFNULL(pcg.sexo,'I'),
		/* dom_calle									*/
		TRIM(pcg.direccion),
		/* dom_nro										*/
		NULL,                          
		/* dom_dpto									    */
		NULL,
		/* dom_piso									    */
		NULL,
		/* dom_mza_monobloc							    */
		NULL,
		/* telefono_dom								    */
		pcg.telefono,
		/* telefono_cel								    */
		NULL,
		/* barrio										*/
		NULL,
		/* localidad									*/
		IFNULL(
			(SELECT 
				nom_loc 
			FROM 
				localidades l
			WHERE
				l.id_localidad = pcg.id_localidad),
			pcg.localidad),
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
				l.id_localidad = pcg.id_localidad)
		),
		/* provincia									*/
		IFNULL(
			(SELECT 
				nom_prov 
			FROM 
				provincias p
			WHERE
				p.id_prov = pcg.id_prov),
			pcg.provincia),
		/* pais										    */
		(SELECT
			nom_pais
		FROM
			paises p, localidades l
		WHERE
			p.cod_pais = l.cod_pais
		AND l.id_localidad = pcg.id_localidad),
		/* fecha_nac									*/
		pcg.f_nac,
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
			pcg.codigo='0' OR pcg.codigo='',
			'obra social',
			'ninguna'
			),
		/* fallecido									*/
		IF (pcg.marca_borrado IS TRUE,TRUE,FALSE),             
		/* fecha_ultima_cond							*/
		NULL,
		/* id_origen_info								*/
		15,
		/* baja										    */
		FALSE
		
	FROM 
		pacientes_turnos_canada_gomez pcg
	
	WHERE 
		es_documento(pcg.tipo,pcg.documento,pcg.f_nac) = 0;

/* habilita los indices de la tabla personas_sanjusto_docs_hc_inconsistentes */
ALTER TABLE personas_canadagomez_docs_inconsistentes ENABLE KEYS;		

	
/* antes de borrar las personas fallecidas de la tabla origen, guarda las historias */
/* clinicas de las personas con marca de borrado */
INSERT INTO hc_personas
	SELECT	0,
			@id_efector,
			(SELECT id_persona
				FROM personas p
				WHERE	pcg.tipo		= p.tipo_doc
				AND		pcg.documento	= p.nro_doc
			),
			8,								/* id_sistema_propietario		*/
			NULL,							/* numero_paciente_sicap		*/
			NULL,							/* numero_grupo_familiar_sicap	*/
			NULL,							/* historia_familiar_sicap		*/
			NULL,							/* historia_personal_sicap		*/
			NULL,							/* his_cli_internacion_hmi		*/
			NULL,							/* his_cli_ce_hmi				*/
			NULL,							/* his_cli_sihos				*/
			num_histo,						/* his_cli_sistema_propietario	*/
			NULL							/* nr0_hc_diagnose				*/
	FROM 
		pacientes_turnos_canada_gomez pcg
		
	WHERE 	
			pcg.marca_borrado=TRUE
	AND		es_documento(pcg.tipo,pcg.documento,pcg.f_nac) = 1
	AND		pcg.num_histo <> 0
	
	ON DUPLICATE KEY UPDATE
		
		id_sistema_propietario = 8,
		his_cli_sistema_propietario = pcg.num_histo;

/* elimina de la tabla de auxiliar los que tienen marca de borrado */	
DELETE FROM pacientes_turnos_canada_gomez
	WHERE	marca_borrado=TRUE;	
	
	
/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;

/* ingresa los datos de las personas */
INSERT INTO personas
	SELECT
		/* id_persona	*/
		0,
		/* id_localidad								    */
		pcg.id_localidad,
        /* tipo_doc									    */
        pcg.tipo,
		/* nro_doc										*/
		pcg.documento,
		/* apellido									    */
		str_separa_ape(pcg.nombre,TRUE),
		/* nombre										*/
		str_separa_ape(pcg.nombre,FALSE),
		/* sexo										    */
		IFNULL(pcg.sexo,'I'),
		/* dom_calle									*/
		TRIM(pcg.direccion),
		/* dom_nro										*/
		NULL,                          
		/* dom_dpto									    */
		NULL,
		/* dom_piso									    */
		NULL,
		/* dom_mza_monobloc							    */
		NULL,
		/* telefono_dom								    */
		pcg.telefono,
		/* telefono_cel								    */
		NULL,
		/* barrio										*/
		NULL,
		/* localidad									*/
		IFNULL(
			(SELECT 
				nom_loc 
			FROM 
				localidades l
			WHERE
				l.id_localidad = pcg.id_localidad),
			pcg.localidad),
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
				l.id_localidad = pcg.id_localidad)
		),
		/* provincia									*/
		IFNULL(
			(SELECT 
				nom_prov 
			FROM 
				provincias p
			WHERE
				p.id_prov = pcg.id_prov),
			pcg.provincia),
		/* pais										    */
		(SELECT
			nom_pais
		FROM
			paises p, localidades l
		WHERE
			p.cod_pais = l.cod_pais
		AND l.id_localidad = pcg.id_localidad),
		/* fecha_nac									*/
		pcg.f_nac,
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
			pcg.codigo='0' OR pcg.codigo='',
			'obra social',
			'ninguna'
			),
		/* fallecido									*/
		IF (pcg.marca_borrado IS TRUE,TRUE,FALSE),             
		/* fecha_ultima_cond							*/
		NULL,
		/* id_origen_info								*/
		15,
		/* baja										    */
		FALSE
		
	FROM 
		pacientes_turnos_canada_gomez pcg
	
	WHERE 
		es_documento(pcg.tipo,pcg.documento,pcg.f_nac) = 1
		
		
	ON DUPLICATE KEY UPDATE
		
		id_localidad = 
			IFNULL(pcg.id_localidad,personas.id_localidad),
		
		apellido =
			str_separa_ape(pcg.nombre,TRUE),
			
		nombre =
			str_separa_ape(pcg.nombre,FALSE),
			
		sexo =
			IFNULL(pcg.sexo,personas.sexo),
			
        dom_calle =	
        	IFNULL(TRIM(pcg.direccion),personas.dom_calle),
        			
		fecha_nac =	
			IFNULL(pcg.f_nac,personas.fecha_nac),
		
		telefono_dom =
			IFNULL(pcg.telefono,personas.telefono_dom),
					
		localidad =
			IFNULL(
				IFNULL(
					(SELECT 
						nom_loc 
					FROM 
						localidades l
					WHERE
						l.id_localidad = pcg.id_localidad),
					pcg.localidad),
				personas.localidad),
		
		departamento =
			IFNULL(
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
						l.id_localidad = pcg.id_localidad)
				),
				personas.departamento),
		
		provincia =
			IFNULL(
				IFNULL(
					(SELECT 
						nom_prov 
					FROM 
						provincias p
					WHERE
						p.id_prov = pcg.id_prov),
					pcg.provincia),
				personas.provincia),
				
		pais =
			IFNULL(				
				(SELECT
					nom_pais
				FROM
					paises p, localidades l
				WHERE
					p.cod_pais = l.cod_pais
				AND l.id_localidad = pcg.id_localidad),
				personas.pais),
		
		fecha_nac =
			IFNULL(pcg.f_nac,personas.fecha_nac),
					
		asociado =
			IF (
			pcg.codigo='0',
			'obra social',
			personas.asociado
			),
			
		id_origen_info = 15	;	
	
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
				WHERE	pcg.tipo		= p.tipo_doc
				AND		pcg.documento	= p.nro_doc
			),
			8,								/* id_sistema_propietario		*/
			NULL,							/* numero_paciente_sicap		*/
			NULL,							/* numero_grupo_familiar_sicap	*/
			NULL,							/* historia_familiar_sicap		*/
			NULL,							/* historia_personal_sicap		*/
			NULL,							/* his_cli_internacion_hmi		*/
			NULL,							/* his_cli_ce_hmi				*/
			NULL,							/* his_cli_sihos				*/
			num_histo,						/* his_cli_sistema_propietario	*/
			NULL							/* nr0_hc_diagnose				*/
	FROM 
		pacientes_turnos_canada_gomez pcg
		
	WHERE 	
			es_documento(pcg.tipo,pcg.documento,pcg.f_nac) = 1
	AND		pcg.num_histo <> 0
	
	ON DUPLICATE KEY UPDATE
		
		id_sistema_propietario = 8,
		his_cli_sistema_propietario = pcg.num_histo;
		
/* habilita los indices en historia clinicas de personas */
ALTER TABLE hc_personas ENABLE KEYS;