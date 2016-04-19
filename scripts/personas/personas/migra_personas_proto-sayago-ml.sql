/* ---------------------------- 

Protomedico 	-> id_efector = 63
Sayago			-> id_efector = 64
Mira y Lopez	-> id_efector = 73

------------------------------ */

SET @id_efector = 63;

/* Agrega los origenes de informacion */
INSERT IGNORE INTO origen_info VALUES (12,"PROTOMEDICO-SAYAGO-MIRA Y LOPEZ");


/* elimina de la tabla cruda las personas NO fallecidas que ya esten en */
/* la tabla personas y SI esten fallecidas */
UPDATE personas p, proto_sayago_ml psm
	SET psm.marca_borrado=TRUE
	WHERE	
			es_documento(psm.tipodoc,psm.documento,psm.fecnac) = 1
	AND		p.nro_doc = psm.documento
	AND		p.tipo_doc = psm.tipodoc
	AND		p.fallecido IS TRUE;

/* elimina los fallecidos */
DELETE FROM proto_sayago_ml
	WHERE	marca_borrado=TRUE;

	
	
/* Tabla de personas_agudoavila_docs_inconsistentes */
CREATE TABLE IF NOT EXISTS personas_proto_sayago_ml_docs_inconsistentes (
	id_persona_proto_sayago_ml_doc_inconsistente	INT(10) 	UNSIGNED    			NOT NULL AUTO_INCREMENT,
	id_efector										INTEGER		UNSIGNED				NOT NULL	COMMENT 'id del efector donde se obtiene la inconsistencia de documento',	
	id_localidad									INT(10) 	UNSIGNED    			NULL 		COMMENT 'id_localidad de tabla localidades',
	tipo_doc										CHAR(3)		 		      			NOT NULL	COMMENT 'Se unifico a los tipo del HMI1 en formato texto: DNI, LC, LE, CI, OTR, DNR',
	nro_doc											INT(10) 	UNSIGNED    			NOT NULL	COMMENT 'Numero de documento en formato numerico',
	apellido										VARCHAR(255) 		     			NOT NULL,
	nombre											VARCHAR(255) 		     			NOT NULL,
	sexo											CHAR(1) 			        		NOT NULL	COMMENT 'F, M o I',
	dom_calle										VARCHAR(255) 		     			NULL		COMMENT 'Nombre de la calle o calle y numero en los casos donde no se pueda separar',
	dom_nro											VARCHAR(20) 		      			NULL,
	dom_dpto										CHAR(3) 			        		NULL,
	dom_piso										VARCHAR(5) 			      			NULL,
	dom_mza_monobloc								VARCHAR(40) 		      			NULL,
	telefono_dom									VARCHAR(30) 		      			NULL		COMMENT 'Telefono del domicilio o el unico que se obtenga',
	telefono_cel									VARCHAR(30) 		      			NULL		COMMENT 'Telefono celular en caso de obtenerlo',
	barrio											VARCHAR(255) 		     			NULL,
	localidad										VARCHAR(255) 		     			NULL		COMMENT 'Descripcion de la localidad obtenida. Si se pudo identificar id_localidad, es la descripcion correspondiente a dicho id en la tabla localidades',
	departamento									VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	provincia										VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	pais											VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	fecha_nac										DATE 				        		NULL,
	ocupacion										VARCHAR(255) 		     			NULL,
	tipo_doc_madre									CHAR(3)		 		      			NULL,
	nro_doc_madre									INT(10) 	UNSIGNED    			NULL,
	nivel_academico									VARCHAR(255) 		     			NULL,
	estado_civil									VARCHAR(25) 		      			NULL,
	situacion_laboral								VARCHAR(255) 		     			NULL,
	asociado										VARCHAR(50) 		      			NULL,
	fallecido										TINYINT(1) 			      			NOT NULL,
	fecha_ultima_cond								DATE 				        		NULL,
	id_origen_info									TINYINT(3) 	UNSIGNED 				NOT NULL,
	baja											TINYINT(1) 			      			NOT NULL,
	PRIMARY KEY (id_persona_proto_sayago_ml_doc_inconsistente),
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

/* deshabilita los indices de la tabla personas_proto_sayago_ml_docs_inconsistentes */
ALTER TABLE personas_proto_sayago_ml_docs_inconsistentes DISABLE KEYS;


/* guarda las personas con documentos inconsistentes */	
INSERT IGNORE INTO personas_proto_sayago_ml_docs_inconsistentes
	SELECT	0,
			/* id_efector */
			@id_efector,
			/* id_localidad */
			(SELECT l.id_localidad
				FROM localidades l
				WHERE nom_loc = 
					(SELECT pl.nombre
						FROM proto_sayago_ml_localidades pl
						WHERE psm.localidad = pl.localidad
						LIMIT 0,1
					)
				AND id_dpto IS NOT NULL
			),
			/* tipo_doc */
			psm.tipodoc,
			/* nro_doc */
			psm.documento,
			/* apellido */
			str_separa_ape(psm.nombre,TRUE),
			/* nombre */
			str_separa_ape(psm.nombre,FALSE),
			/* sexo */
			(CASE psm.sexo
				WHEN 'Femenino' THEN 'F'
				WHEN 'Masculino' THEN 'M'
				ELSE NULL
			END),
			/* dom_calle */
			psm.domicilio,
			/* dom_nro */
			NULL,
			/* dom_dpto */
			NULL,
			/* dom_piso */
			NULL,
			/* dom_mza_monobloc */
			NULL,
			/* telefono_dom */
			NULL,
			/* telefono_cel */
			NULL,
			/* barrio */
			NULL,
			/* localidad */
			(SELECT l.nom_loc
				FROM localidades l
				WHERE nom_loc = 
					(SELECT pl.nombre
						FROM proto_sayago_ml_localidades pl
						WHERE psm.localidad = pl.localidad
						LIMIT 0,1
					)
				AND id_dpto IS NOT NULL
			),
			/* departamento */
			(SELECT d.nom_dpto
				FROM departamentos d
				WHERE d.id_dpto = 
					(SELECT l.id_dpto
						FROM localidades l
						WHERE nom_loc = 
							(SELECT pl.nombre
								FROM proto_sayago_ml_localidades pl
								WHERE psm.localidad = pl.localidad
								LIMIT 0,1
							)
						AND id_dpto IS NOT NULL
					)
			),
			/* provincia */
			(SELECT p.nom_prov
				FROM provincias p
				WHERE p.id_prov = 
					(SELECT d.id_prov
						FROM departamentos d
						WHERE d.id_dpto = 
							(SELECT l.id_dpto
								FROM localidades l
								WHERE nom_loc = 
									(SELECT pl.nombre
										FROM proto_sayago_ml_localidades pl
										WHERE psm.localidad = pl.localidad
										LIMIT 0,1
									)
								AND id_dpto IS NOT NULL
							)
					)
			),
			/* pais */
			(SELECT pa.nom_pais
				FROM paises pa
				WHERE id_pais =
					(SELECT p.id_pais
						FROM provincias p
						WHERE p.id_prov = 
							(SELECT d.id_prov
								FROM departamentos d
								WHERE d.id_dpto = 
									(SELECT l.id_dpto
										FROM localidades l
										WHERE nom_loc = 
											(SELECT pl.nombre
												FROM proto_sayago_ml_localidades pl
												WHERE psm.localidad = pl.localidad
												LIMIT 0,1
											)
										AND id_dpto IS NOT NULL
									)
							)
					)
			),
			/* fecha_nac */
			psm.fecnac,
			/* ocupacion */
			NULL,
			/* tipo_doc_madre */
			NULL,
			/* nro_doc_madre */
			NULL,
			/* nivel_academico */
			NULL,
			/* estado_civil */
			NULL,
			/* situacion_laboral */
			NULL,
			/* asociado */
			NULL,
			/* fallecido */
			FALSE,
			/* fecha_ultima_cond */
			NULL,
			12,
			FALSE
	FROM	
			proto_sayago_ml psm
	WHERE
			es_documento(psm.tipodoc,psm.documento,psm.fecnac) = 0;
			
/* habilita los indices de la tabla personas_proto_sayago_ml_docs_inconsistentes */
ALTER TABLE personas_proto_sayago_ml_docs_inconsistentes ENABLE KEYS;



/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;

/* guarda las personas con documentos validos */	
INSERT INTO personas
	SELECT	0,
			/* id_localidad */
			(SELECT l.id_localidad
				FROM localidades l
				WHERE nom_loc = 
					(SELECT pl.nombre
						FROM proto_sayago_ml_localidades pl
						WHERE psm.localidad = pl.localidad
						LIMIT 0,1
					)
				AND id_dpto IS NOT NULL
			),
			/* tipo_doc */
			psm.tipodoc,
			/* nro_doc */
			psm.documento,
			/* apellido */
			str_separa_ape(psm.nombre,TRUE),
			/* nombre */
			str_separa_ape(psm.nombre,FALSE),
			/* sexo */
			(CASE psm.sexo
				WHEN 'Femenino' THEN 'F'
				WHEN 'Masculino' THEN 'M'
				ELSE NULL
			END),
			/* dom_calle */
			psm.domicilio,
			/* dom_nro */
			NULL,
			/* dom_dpto */
			NULL,
			/* dom_piso */
			NULL,
			/* dom_mza_monobloc */
			NULL,
			/* telefono_dom */
			NULL,
			/* telefono_cel */
			NULL,
			/* barrio */
			NULL,
			/* localidad */
			(SELECT l.nom_loc
				FROM localidades l
				WHERE nom_loc = 
					(SELECT pl.nombre
						FROM proto_sayago_ml_localidades pl
						WHERE psm.localidad = pl.localidad
						LIMIT 0,1
					)
				AND id_dpto IS NOT NULL
			),
			/* departamento */
			(SELECT d.nom_dpto
				FROM departamentos d
				WHERE d.id_dpto = 
					(SELECT l.id_dpto
						FROM localidades l
						WHERE nom_loc = 
							(SELECT pl.nombre
								FROM proto_sayago_ml_localidades pl
								WHERE psm.localidad = pl.localidad
								LIMIT 0,1
							)
						AND id_dpto IS NOT NULL
					)
			),
			/* provincia */
			(SELECT p.nom_prov
				FROM provincias p
				WHERE p.id_prov = 
					(SELECT d.id_prov
						FROM departamentos d
						WHERE d.id_dpto = 
							(SELECT l.id_dpto
								FROM localidades l
								WHERE nom_loc = 
									(SELECT pl.nombre
										FROM proto_sayago_ml_localidades pl
										WHERE psm.localidad = pl.localidad
										LIMIT 0,1
									)
								AND id_dpto IS NOT NULL
							)
					)
			),
			/* pais */
			(SELECT pa.nom_pais
				FROM paises pa
				WHERE id_pais =
					(SELECT p.id_pais
						FROM provincias p
						WHERE p.id_prov = 
							(SELECT d.id_prov
								FROM departamentos d
								WHERE d.id_dpto = 
									(SELECT l.id_dpto
										FROM localidades l
										WHERE nom_loc = 
											(SELECT pl.nombre
												FROM proto_sayago_ml_localidades pl
												WHERE psm.localidad = pl.localidad
												LIMIT 0,1
											)
										AND id_dpto IS NOT NULL
									)
							)
					)
			),
			/* fecha_nac */
			psm.fecnac,
			/* ocupacion */
			NULL,
			/* tipo_doc_madre */
			NULL,
			/* nro_doc_madre */
			NULL,
			/* nivel_academico */
			NULL,
			/* estado_civil */
			NULL,
			/* situacion_laboral */
			NULL,
			/* asociado */
			NULL,
			/* fallecido */
			FALSE,
			/* fecha_ultima_cond */
			NULL,
			/* id_origen_info */
			12,
			/* baja */
			FALSE
	FROM	
			proto_sayago_ml psm
	WHERE
			es_documento(psm.tipodoc,psm.documento,psm.fecnac) = 1
			
	ON DUPLICATE KEY UPDATE
	
			/* id_localidad */
			id_localidad = IFNULL(
								(SELECT l.id_localidad
									FROM localidades l
									WHERE nom_loc = 
										(SELECT pl.nombre
											FROM proto_sayago_ml_localidades pl
											WHERE psm.localidad = pl.localidad
											LIMIT 0,1
										)
									AND id_dpto IS NOT NULL
								), 
							personas.id_localidad
							),
			/* apellido */
			apellido = str_separa_ape(psm.nombre,TRUE),
			/* nombre */
			nombre = str_separa_ape(psm.nombre,FALSE),
			/* sexo */
			sexo =
				(CASE psm.sexo
					WHEN 'Femenino' THEN 'F'
					WHEN 'Masculino' THEN 'M'
					ELSE personas.sexo
				END),
			/* dom_calle */
			dom_calle = IF (personas.dom_calle IS NULL,psm.domicilio,personas.dom_calle),
			/* localidad */
			localidad = IFNULL(
							(SELECT l.nom_loc
								FROM localidades l
								WHERE nom_loc = 
									(SELECT pl.nombre
										FROM proto_sayago_ml_localidades pl
										WHERE psm.localidad = pl.localidad
										LIMIT 0,1
									)
								AND id_dpto IS NOT NULL
							),
						personas.localidad
						),
			/* departamento */
			departamento = IFNULL(
							(SELECT d.nom_dpto
								FROM departamentos d
								WHERE d.id_dpto = 
									(SELECT l.id_dpto
										FROM localidades l
										WHERE nom_loc = 
											(SELECT pl.nombre
												FROM proto_sayago_ml_localidades pl
												WHERE psm.localidad = pl.localidad
												LIMIT 0,1
											)
										AND id_dpto IS NOT NULL
									)
							),
							personas.departamento
							),
			/* provincia */
			provincia = IFNULL(
							(SELECT p.nom_prov
								FROM provincias p
								WHERE p.id_prov = 
									(SELECT d.id_prov
										FROM departamentos d
										WHERE d.id_dpto = 
											(SELECT l.id_dpto
												FROM localidades l
												WHERE nom_loc = 
													(SELECT pl.nombre
														FROM proto_sayago_ml_localidades pl
														WHERE psm.localidad = pl.localidad
														LIMIT 0,1
													)
												AND id_dpto IS NOT NULL
											)
									)
							),
						personas.provincia
						),
			/* pais */
			pais = IFNULL(
						(SELECT pa.nom_pais
							FROM paises pa
							WHERE id_pais =
								(SELECT p.id_pais
									FROM provincias p
									WHERE p.id_prov = 
										(SELECT d.id_prov
											FROM departamentos d
											WHERE d.id_dpto = 
												(SELECT l.id_dpto
													FROM localidades l
													WHERE nom_loc = 
														(SELECT pl.nombre
															FROM proto_sayago_ml_localidades pl
															WHERE psm.localidad = pl.localidad
															LIMIT 0,1
														)
													AND id_dpto IS NOT NULL
												)
										)
								)
						),
					personas.pais
					),
			/* fecha_nac */
			fecha_nac = psm.fecnac,
			/* id_origen_info */
			id_origen_info = 12;
			
/* habilita los indices de la tabla personas */
ALTER TABLE personas ENABLE KEYS;