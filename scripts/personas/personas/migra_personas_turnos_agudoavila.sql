/* ------------------------------------------------------------------------------------------------- */	
/* Personas - carga los pacientes del sistema propietario del Agudo Avila a la base de personas      */
/* ------------------------------------------------------------------------------------------------- */

/* inserta en "origen_info" */
INSERT IGNORE INTO origen_info(id_origen_info, origen_info) VALUES (11,"AGUDO AVILA");

INSERT IGNORE INTO sistemas_propietarios
		(id_sistema_propietario, nom_corto, nom_largo, observacion) 
	VALUES 
		(5,
		'H. AGUDO AVILA',
		'CENTRO REGIONAL DE SALUD MENTAL AGUDO AVILA',
		'Migración de los pacientes del sistema del hospital Agudo Avila 03/08/2010');
		

/* Hospital Agudo Avila ->	id_efector = 218	*/
SET @id_efector := 218;

/* agrega el campo de marca_borrado para los fallecidos */
ALTER TABLE agudoavila.tgral_pacientes 
	ADD COLUMN  marca_borrado		TINYINT(1)		NOT NULL DEFAULT 0;

/* Modifica el campo tipo_doc de la tabla tgral_pacientes del agudo avila */
 ALTER TABLE 
	agudoavila.tgral_pacientes
	ADD COLUMN tipo_doc_char CHAR(3) NOT NULL; 
	
/* Actualiza los tipo de documentos de la tabla "tgral_pacientes" */
UPDATE agudoavila.tgral_pacientes
	SET tipo_doc_char = (CASE tipo_doc
							WHEN 0 THEN 'DNR'
							WHEN 1 THEN 'DNI'
							WHEN 2 THEN 'LC'
							WHEN 3 THEN 'PAS'
							WHEN 4 THEN 'LE'
							WHEN 5 THEN 'CI'
							ELSE 'DNR'
						END);





/* elimina de la tabla "tgral_pacientes" de la base del Agudo Avila las personas NO fallecidas que ya esten en */
/* la tabla personas y SI esten fallecidas */	
UPDATE personas p, agudoavila.tgral_pacientes atp
	SET atp.marca_borrado = TRUE
	WHERE	
			es_documento(atp.tipo_doc_char,atp.nro_doc,atp.fecha_nacimiento) = 1
	AND		p.nro_doc = atp.nro_doc
	AND		p.tipo_doc = atp.tipo_doc_char
	AND		p.fallecido IS TRUE;
	
/* Antes de eliminar los fallecido migra las historias clinicas */

/* deshabilita los indices de la tabla personas */
ALTER TABLE hc_personas DISABLE KEYS;

INSERT INTO hc_personas
	SELECT	0,
			@id_efector,
			(SELECT id_persona
				FROM personas p
				WHERE	atp.tipo_doc_char	= p.tipo_doc
				AND		atp.nro_doc		= p.nro_doc),
			5,   /* id_sistema_propietario		*/    
			NULL,   /* numero_paciente_sicap		*/     
			NULL,   /* numero_grupo_familiar_sicap	*/
			NULL,   /* historia_familiar_sicap		*/   
			NULL,   /* historia_personal_sicap		*/   
			NULL,
			NULL,
			NULL,	/* his_cli_sihos				*/
			atp.nro_historia,	/* his_cli_sistema_propietario	*/
			NULL	/* nr0_hc_diagnose				*/
	FROM 	
			agudoavila.tgral_pacientes atp
	WHERE 	
			es_documento(atp.tipo_doc_char,atp.nro_doc,atp.fecha_nacimiento) = 1
	AND NOT (nro_historia = 0)
	AND NOT (atp.nro_doc = 20305638 AND atp.tipo_doc_char = 'DNR')
	AND NOT (atp.nro_doc = 30406904 AND atp.tipo_doc_char = 'DNR')
	AND NOT (atp.nro_doc = 35703131 AND atp.tipo_doc_char = 'DNR')
	AND NOT (atp.nro_doc = 4488276 AND atp.tipo_doc_char = 'DNI')
	AND NOT (atp.nro_doc = 3684953 AND atp.tipo_doc_char = 'DNI')
	AND NOT (atp.nro_doc = 7841791 AND atp.tipo_doc_char = 'DNI')
	AND NOT (atp.nro_doc = 8599792 AND atp.tipo_doc_char = 'DNI')
	AND		atp.marca_borrado=TRUE
	
	ON DUPLICATE KEY UPDATE
		id_sistema_propietario = 5,
		his_cli_sistema_propietario = atp.nro_historia;
	

/* elimina de la tabla "tgral_pacientes" los que tienen marca de borrado */
SET FOREIGN_KEY_CHECKS=0;	
DELETE FROM agudoavila.tgral_pacientes
	WHERE	marca_borrado=TRUE;
SET FOREIGN_KEY_CHECKS=1;
	


/* Tabla de personas_agudoavila_docs_inconsistentes */
DROP TABLE IF EXISTS personas_agudoavila_docs_inconsistentes;

CREATE TABLE personas_agudoavila_docs_inconsistentes (
	id_persona_agudoavila_doc_inconsistente	INT(10) 	UNSIGNED    			NOT NULL AUTO_INCREMENT,
	id_efector							INTEGER		UNSIGNED				NOT NULL	COMMENT 'id del efector donde se obtiene la inconsistencia de documento',	
	nro_historia 						INTEGER		UNSIGNED				NOT NULL,
	id_localidad						INT(10) 	UNSIGNED    			NULL 		COMMENT 'id_localidad de tabla localidades',
	tipo_doc							CHAR(3)		 		      			NOT NULL	COMMENT 'Se unifico a los tipo del HMI1 en formato texto: DNI, LC, LE, CI, OTR, DNR',
	nro_doc								INT(10) 	UNSIGNED    			NOT NULL	COMMENT 'Numero de documento en formato numerico',
	apellido							VARCHAR(255) 		     			NOT NULL,
	nombre								VARCHAR(255) 		     			NOT NULL,
	sexo								CHAR(1) 			        		NOT NULL	COMMENT 'F, M o I',
	dom_calle							VARCHAR(255) 		     			NULL		COMMENT 'Nombre de la calle o calle y numero en los casos donde no se pueda separar',
	dom_nro								VARCHAR(20) 		      			NULL,
	dom_dpto							CHAR(3) 			        		NULL,
	dom_piso							VARCHAR(5) 			      			NULL,
	dom_mza_monobloc					VARCHAR(40) 		      			NULL,
	telefono_dom						VARCHAR(30) 		      			NULL		COMMENT 'Telefono del domicilio o el unico que se obtenga',
	telefono_cel						VARCHAR(30) 		      			NULL		COMMENT 'Telefono celular en caso de obtenerlo',
	barrio								VARCHAR(255) 		     			NULL,
	localidad							VARCHAR(255) 		     			NULL		COMMENT 'Descripcion de la localidad obtenida. Si se pudo identificar id_localidad, es la descripcion correspondiente a dicho id en la tabla localidades',
	departamento						VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	provincia							VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	pais								VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	fecha_nac							DATE 				        		NULL,
	ocupacion							VARCHAR(255) 		     			NULL,
	tipo_doc_madre						CHAR(3)		 		      			NULL,
	nro_doc_madre						INT(10) 	UNSIGNED    			NULL,
	nivel_academico						VARCHAR(255) 		     			NULL,
	estado_civil						VARCHAR(25) 		      			NULL,
	situacion_laboral					VARCHAR(255) 		     			NULL,
	asociado							VARCHAR(50) 		      			NULL,
	fallecido							TINYINT(1) 			      			NOT NULL,
	fecha_ultima_cond					DATE 				        		NULL,
	id_origen_info						TINYINT(3) 	UNSIGNED 				NOT NULL,
	baja								TINYINT(1) 			      			NOT NULL,
	PRIMARY KEY (id_persona_hmi_doc_inconsistente),
	UNIQUE KEY idx_unique_tipo_nro_doc (id_efector,tipo_doc,nro_doc),
	KEY fk_id_localidad (id_localidad),
	KEY fk_id_origen_info (id_origen_info),
	KEY idx_nro_doc (nro_doc),
	KEY idx_apellido (apellido),
	KEY idx_nombre (nombre),
	KEY idx_fecha_nac (fecha_nac),
	KEY idx_fallecido (fallecido),
	KEY idx_fecha_ultima_cond (fecha_ultima_cond)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/* deshabilita los indices de la tabla personas_agudoavila_docs_inconsistentes */
ALTER TABLE personas_agudoavila_docs_inconsistentes DISABLE KEYS;

INSERT INTO personas_agudoavila_docs_inconsistentes
	SELECT	
		0,
		/* id_efector = 218 */
		@id_efector,
		/* nro_historia */
		atp.nro_historia,
		/* id_localidad */
		(SELECT l.id_localidad
			FROM localidades l
			WHERE l.nom_loc = 
				(SELECT c.ciudad 
					FROM agudoavila.tparam_codigos_postales c 
					WHERE c.cod_postal = atp.cod_postal
				)
			AND l.id_dpto IS NOT NULL
			
		),
		/* tipo_doc */
		atp.tipo_doc_char,
		/* nro_doc */
		atp.nro_doc,
		/* apellido */
		atp.apellido,
		/* nombre */
		TRIM(CONCAT(atp.nombre1,' ',atp.nombre2) ),
		/* sexo */
		IF(atp.masc_fem='1','M','F'),
		/* dom_calle */
		atp.calle,
		/* dom_nro */
		TRIM( CONCAT(atp.numero,' ',IF(atp.bis='1',' BIS','')) ),
		/* dom_dpto */
		NULL,
		/* dom_piso */
		NULL,
		/* dom_mza_monobloc */
		NULL,
		/* telefono_dom	*/
		NULL,
		/* telefono_cel	*/
		NULL,
		/* barrio */
		NULL,
		/* localidad */
		(SELECT c.ciudad 
					FROM agudoavila.tparam_codigos_postales c 
					WHERE c.cod_postal = atp.cod_postal
			),
		/* departamento	*/
		(SELECT nom_dpto
			FROM departamentos d
			WHERE 
				d.id_dpto = 
					(SELECT l.id_dpto
						FROM localidades l
						WHERE l.nom_loc = 
							(SELECT c.ciudad 
								FROM agudoavila.tparam_codigos_postales c 
								WHERE c.cod_postal = atp.cod_postal
							)
						AND l.id_dpto IS NOT NULL
					)
			LIMIT 0,1
		),
		/* provincia */
		(SELECT nom_prov
			FROM provincias pr
			WHERE 
				pr.cod_prov = 
					(SELECT l.cod_prov
						FROM localidades l
						WHERE l.nom_loc = 
							(SELECT c.ciudad 
								FROM agudoavila.tparam_codigos_postales c 
								WHERE c.cod_postal = atp.cod_postal
							)
						AND l.id_dpto IS NOT NULL
					)
			LIMIT 0,1
		),
		/* pais */
		(SELECT nom_pais
			FROM paises pa
			WHERE 
				pa.cod_pais = 
					(SELECT l.cod_pais
						FROM localidades l
						WHERE l.nom_loc = 
							(SELECT c.ciudad 
								FROM agudoavila.tparam_codigos_postales c 
								WHERE c.cod_postal = atp.cod_postal
							)
						AND l.id_dpto IS NOT NULL
					)
			LIMIT 0,1
		),
		/* fecha_nac */
		atp.fecha_nacimiento,
		/* ocupacion */
		IF (atp.cat_ocupacional = 1, 'AMA DE CASA',
			IF (atp.profesion<>0,
				(SELECT prof.descripcion 
				FROM agudoavila.tparam_profesion prof 
				WHERE atp.profesion = prof.profesion),
			NULL)
		),
		/* tipo_doc_madre */
		NULL,
		/* nro_doc_madre */
		NULL,
		/* nivel_academico */
		(CASE atp.escolaridad
			WHEN 0 THEN NULL
			WHEN 1 THEN 'primaria completa'
			WHEN 2 THEN 'primaria incompleta'
			WHEN 3 THEN 'secundario incompleto'
			WHEN 4 THEN 'secundario completo'
			WHEN 5 THEN 'EGB'
			WHEN 6 THEN 'polimodal'
			WHEN 7 THEN 'universitario incompleto'
			WHEN 8 THEN 'universitario completo'
			ELSE NULL
		END),
		/* estado_civil	*/
		(CASE atp.estado_civil
			WHEN 0 THEN NULL
			WHEN 1 THEN 'SOLTERO'
			WHEN 2 THEN 'CASADO'
			WHEN 3 THEN 'DIVORCIADO'
			WHEN 4 THEN 'SEPARADO'
			WHEN 5 THEN 'CONCUBINADO'
			ELSE NULL
		END),
		/* situacion_laboral */
		IF (atp.cond_laboral = 0 OR atp.cond_laboral=2,NULL,'trabaja o esta de licencia'),
		/* asociado	*/
		IF (atp.obra_social<>'','obra social',NULL),
		/* fallecido */
		FALSE,
		/* fecha_ultima_cond */
		NULL,
		/* id_origen_info */
		11,
		/* baja	*/
		FALSE
			
	FROM 	
		agudoavila.tgral_pacientes atp
	WHERE 	
			es_documento(atp.tipo_doc_char,atp.nro_doc,atp.fecha_nacimiento) = 0;
			
			

	
/* -------------- */
/* TABLA PERSONAS */
/* -------------- */

/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;

INSERT INTO personas
	SELECT
		/* id_persona */	
		0,
		/* id_localidad */
		(SELECT l.id_localidad
			FROM localidades l
			WHERE l.nom_loc = 
				(SELECT c.ciudad 
					FROM agudoavila.tparam_codigos_postales c 
					WHERE c.cod_postal = atp.cod_postal
				)
			AND l.id_dpto IS NOT NULL
		),
		/* tipo_doc */
		atp.tipo_doc_char,
		/* nro_doc */
		atp.nro_doc,
		/* apellido */
		atp.apellido,
		/* nombre */
		TRIM(CONCAT(atp.nombre1,' ',atp.nombre2) ),
		/* sexo */
		IF(atp.masc_fem='1','M','F'),
		/* dom_calle */
		atp.calle,
		/* dom_nro */
		TRIM( CONCAT(atp.numero,' ',IF(atp.bis='1',' BIS','')) ),
		/* dom_dpto */
		NULL,
		/* dom_piso */
		NULL,
		/* dom_mza_monobloc */
		NULL,
		/* telefono_dom	*/
		NULL,
		/* telefono_cel	*/
		NULL,
		/* barrio */
		NULL,
		/* localidad */
		(SELECT c.ciudad 
					FROM agudoavila.tparam_codigos_postales c 
					WHERE c.cod_postal = atp.cod_postal
			),
		/* departamento	*/
		(SELECT nom_dpto
			FROM departamentos d
			WHERE 
				d.id_dpto = 
					(SELECT l.id_dpto
						FROM localidades l
						WHERE l.nom_loc = 
							(SELECT c.ciudad 
								FROM agudoavila.tparam_codigos_postales c 
								WHERE c.cod_postal = atp.cod_postal
							)
						AND l.id_dpto IS NOT NULL
					)
			LIMIT 0,1
		),
		/* provincia */
		(SELECT nom_prov
			FROM provincias pr
			WHERE 
				pr.cod_prov = 
					(SELECT l.cod_prov
						FROM localidades l
						WHERE l.nom_loc = 
							(SELECT c.ciudad 
								FROM agudoavila.tparam_codigos_postales c 
								WHERE c.cod_postal = atp.cod_postal
							)
						AND l.id_dpto IS NOT NULL
					)
			LIMIT 0,1
		),
		/* pais */
		(SELECT nom_pais
			FROM paises pa
			WHERE 
				pa.cod_pais = 
					(SELECT l.cod_pais
						FROM localidades l
						WHERE l.nom_loc = 
							(SELECT c.ciudad 
								FROM agudoavila.tparam_codigos_postales c 
								WHERE c.cod_postal = atp.cod_postal
							)
						AND l.id_dpto IS NOT NULL
					)
			LIMIT 0,1
		),
		/* fecha_nac */
		atp.fecha_nacimiento,
		/* ocupacion */
		IF (atp.cat_ocupacional = 1, 'AMA DE CASA',
			IF (atp.profesion<>0,
				(SELECT prof.descripcion 
				FROM agudoavila.tparam_profesion prof 
				WHERE atp.profesion = prof.profesion),
			NULL)
		),
		/* tipo_doc_madre */
		NULL,
		/* nro_doc_madre */
		NULL,
		/* nivel_academico */
		(CASE atp.escolaridad
			WHEN 0 THEN NULL
			WHEN 1 THEN 'primaria completa'
			WHEN 2 THEN 'primaria incompleta'
			WHEN 3 THEN 'secundario incompleto'
			WHEN 4 THEN 'secundario completo'
			WHEN 5 THEN 'EGB'
			WHEN 6 THEN 'polimodal'
			WHEN 7 THEN 'universitario incompleto'
			WHEN 8 THEN 'universitario completo'
			ELSE NULL
		END),
		/* estado_civil	*/
		(CASE atp.estado_civil
			WHEN 0 THEN NULL
			WHEN 1 THEN 'SOLTERO'
			WHEN 2 THEN 'CASADO'
			WHEN 3 THEN 'DIVORCIADO'
			WHEN 4 THEN 'SEPARADO'
			WHEN 5 THEN 'CONCUBINADO'
			ELSE NULL
		END),
		/* situacion_laboral */
		IF (atp.cond_laboral = 0 OR atp.cond_laboral=2,NULL,'trabaja o esta de licencia'),
		/* asociado	*/
		IF (atp.obra_social<>'','obra social',NULL),
		/* fallecido */
		FALSE,
		/* fecha_ultima_cond */
		NULL,
		/* id_origen_info */
		11,
		/* baja	*/
		FALSE
			
	FROM 	
		agudoavila.tgral_pacientes atp
	WHERE 	
			es_documento(atp.tipo_doc_char,atp.nro_doc,atp.fecha_nacimiento) = 1
	
	ON DUPLICATE KEY UPDATE
	
		/* id_localidad */
		id_localidad = 
			IFNULL(
				(SELECT l.id_localidad
					FROM localidades l
					WHERE l.nom_loc = 
						(SELECT c.ciudad 
							FROM agudoavila.tparam_codigos_postales c 
							WHERE c.cod_postal = atp.cod_postal
						)
					AND l.id_dpto IS NOT NULL
				),
			personas.id_localidad),
		/* apellido */
		apellido = atp.apellido,
		/* nombre */
		nombre = TRIM(CONCAT(atp.nombre1,' ',atp.nombre2) ),
		/* sexo */
		sexo = IF(atp.masc_fem='1','M','F'),
		/* dom_calle */
		dom_calle = atp.calle,
		/* dom_nro */
		dom_nro = TRIM( CONCAT(atp.numero,' ',IF(atp.bis='1',' BIS','')) ),
		/* localidad */
		localidad =
			IFNULL(
				(SELECT c.ciudad 
					FROM agudoavila.tparam_codigos_postales c 
					WHERE c.cod_postal = atp.cod_postal
				),
			personas.localidad),
		/* departamento	*/
		departamento =
			IFNULL(
				(SELECT nom_dpto
					FROM departamentos d
					WHERE 
						d.id_dpto = 
							(SELECT l.id_dpto
								FROM localidades l
								WHERE l.nom_loc = 
									(SELECT c.ciudad 
										FROM agudoavila.tparam_codigos_postales c 
										WHERE c.cod_postal = atp.cod_postal
									)
								AND l.id_dpto IS NOT NULL
							)
					LIMIT 0,1
				),
			personas.departamento),
		/* provincia */
		provincia =
			IFNULL(
				(SELECT nom_prov
					FROM provincias pr
					WHERE 
						pr.cod_prov = 
							(SELECT l.cod_prov
								FROM localidades l
								WHERE l.nom_loc = 
									(SELECT c.ciudad 
										FROM agudoavila.tparam_codigos_postales c 
										WHERE c.cod_postal = atp.cod_postal
									)
								AND l.id_dpto IS NOT NULL
							)
					LIMIT 0,1
				),
			personas.provincia),
		/* pais */
		pais =
			IFNULL (
				
				(SELECT nom_pais
					FROM paises pa
					WHERE 
						pa.cod_pais = 
							(SELECT l.cod_pais
								FROM localidades l
								WHERE l.nom_loc = 
									(SELECT c.ciudad 
										FROM agudoavila.tparam_codigos_postales c 
										WHERE c.cod_postal = atp.cod_postal
									)
								AND l.id_dpto IS NOT NULL
							)
					LIMIT 0,1
				),
			personas.pais),
		/* fecha_nac */
		fecha_nac = atp.fecha_nacimiento,
		/* ocupacion */
		ocupacion =
			IF (atp.cat_ocupacional = 1, 'AMA DE CASA',
				IF (atp.profesion<>0,
					(SELECT prof.descripcion 
					FROM agudoavila.tparam_profesion prof 
					WHERE atp.profesion = prof.profesion),
				personas.ocupacion)
			),
		/* nivel_academico */
		nivel_academico =
			(CASE atp.escolaridad
				WHEN 1 THEN 'primaria completa'
				WHEN 2 THEN 'primaria incompleta'
				WHEN 3 THEN 'secundario incompleto'
				WHEN 4 THEN 'secundario completo'
				WHEN 5 THEN 'EGB'
				WHEN 6 THEN 'polimodal'
				WHEN 7 THEN 'universitario incompleto'
				WHEN 8 THEN 'universitario completo'
				ELSE personas.nivel_academico
			END),
		/* estado_civil	*/
		estado_civil =
			(CASE atp.estado_civil
				WHEN 1 THEN 'SOLTERO'
				WHEN 2 THEN 'CASADO'
				WHEN 3 THEN 'DIVORCIADO'
				WHEN 4 THEN 'SEPARADO'
				WHEN 5 THEN 'CONCUBINADO'
				ELSE personas.estado_civil
			END),
		/* situacion_laboral */
		situacion_laboral = IF (atp.cond_laboral = 0 OR atp.cond_laboral=2,personas.situacion_laboral,'trabaja o esta de licencia'),
		/* asociado	*/
		asociado = IF (atp.obra_social<>'','obra social',personas.asociado),
		/* id_origen_info */
		id_origen_info = 11	;
		
/* habilita los indices de la tabla personas */
ALTER TABLE personas ENABLE KEYS;


/* Hospital Cullen		->	id_efector = 71		*/
/* Hospital Iturraspe	->	id_efector = 72		*/
/* Inst. Vera Candiotti ->	id_efector = 74		*/
/* Hospital Alassia		->	id_efector = 121	*/
/* Hospital Eva Peron   ->  id_efector = 167	*/
/* Hospital Centenario	->	id_efector = 183	*/
/* Hospital Provincial	->	id_efector = 184	*/
/* Hospital San Javier	->	id_efector = 251	*/
/* Hospital Agudo Avila ->	id_efector = 218	*/

INSERT INTO hc_personas
	SELECT	0,
			@id_efector,
			(SELECT id_persona
				FROM personas p
				WHERE	atp.tipo_doc_char	= p.tipo_doc
				AND		atp.nro_doc		= p.nro_doc),
			5,   /* id_sistema_propietario		*/    
			NULL,   /* numero_paciente_sicap		*/     
			NULL,   /* numero_grupo_familiar_sicap	*/
			NULL,   /* historia_familiar_sicap		*/   
			NULL,   /* historia_personal_sicap		*/   
			NULL,
			NULL,
			NULL,	/* his_cli_sihos				*/
			atp.nro_historia,	/* his_cli_sistema_propietario	*/
			NULL	/* nr0_hc_diagnose				*/
	FROM 	
			agudoavila.tgral_pacientes atp
	WHERE 	
			es_documento(atp.tipo_doc_char,atp.nro_doc,atp.fecha_nacimiento) = 1
	AND NOT (nro_historia = 0)
	AND NOT (atp.nro_doc = 20305638 AND atp.tipo_doc_char = 'DNR')
	AND NOT (atp.nro_doc = 30406904 AND atp.tipo_doc_char = 'DNR')
	AND NOT (atp.nro_doc = 35703131 AND atp.tipo_doc_char = 'DNR')
	AND NOT (atp.nro_doc = 4488276 AND atp.tipo_doc_char = 'DNI')
	AND NOT (atp.nro_doc = 3684953 AND atp.tipo_doc_char = 'DNI')
	AND NOT (atp.nro_doc = 7841791 AND atp.tipo_doc_char = 'DNI')
	AND NOT (atp.nro_doc = 8599792 AND atp.tipo_doc_char = 'DNI')
	
	ON DUPLICATE KEY UPDATE
	
		id_sistema_propietario = 5,
		his_cli_sistema_propietario = atp.nro_historia;
		
/* habilita los indices de la tabla personas */
ALTER TABLE hc_personas ENABLE KEYS;