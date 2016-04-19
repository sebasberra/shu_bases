/* ---------------------------------------------------- */
/* HOSPITAL NIÑOS ZOMA NORTE ROSARIO - id_efector = 181 */
/* ---------------------------------------------------- */

INSERT IGNORE INTO origen_info(id_origen_info, origen_info) VALUES (9,"HOSPITAL NIÑOS ZONA NORTE ROSARIO");

INSERT IGNORE INTO sistemas_propietarios
		(id_sistema_propietario, nom_corto, nom_largo, observacion) 
	VALUES 
		(4,
		'H. NIÑOS ZONA NOR ROSARIO',
		'HOSPITAL DE NIÑOS ZONA NORTE ROSARIO',
		'Migración de los pacientes del sistema del hospital de niños zona norte rosario 30/07/2010');

/* marca en la tabla del hospital de niños zona norte rosario las personas que ya esten en */
/* la tabla personas y ESTEN fallecidas */
UPDATE personas p, pacientes_hosp_ninos_zona_norte_rosario hnznr
	SET hnznr.marca_borrado=TRUE
	WHERE	p.nro_doc = hnznr.docum
	AND		'DNI' = p.tipo_doc
	AND		p.fallecido IS TRUE;
	

				
/* deshabilita los indices de la tabla personas */
ALTER TABLE hc_personas DISABLE KEYS;
			
/* antes de borrar, guarda las historias clinicas de las personas fallecidas */
INSERT INTO hc_personas
	SELECT	0,
			181,
			(SELECT id_persona
				FROM personas p
				WHERE	hnznr.docum			= p.nro_doc
				AND		'DNI' = p.tipo_doc 
				LIMIT 0,1),
			4,		/* id_sistema_propietario		*/
			NULL,	/* numero_paciente_sicap		*/
			NULL,	/* numero_grupo_familiar_sicap	*/
			NULL,	/* historia_familiar_sicap		*/
			NULL,	/* historia_personal_sicap		*/
			NULL,	/* his_cli_internacion_hmi		*/
			NULL,	/* his_cli_ce_hmi				*/
			NULL,	/* his_cli_sihos				*/
			hnznr.codigo,	/* his_cli_sistema_propietario	*/
			NULL	/* nr0_hc_diagnose				*/
			
			
	FROM 	pacientes_hosp_ninos_zona_norte_rosario hnznr
	WHERE 	
		hnznr.marca_borrado = TRUE
	
	ON DUPLICATE KEY UPDATE 
		his_cli_sistema_propietario = hnznr.codigo;
			
/* elimina de la tabla del hospital de venado tuerto cruda los que tienen marca de borrado */	
DELETE FROM pacientes_hosp_ninos_zona_norte_rosario
	WHERE	marca_borrado=TRUE;			
											
/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;			

/* inserta los pacientes del hospital de ninos de rosario */
INSERT INTO personas
	SELECT	0,
			IFNULL(
				(SELECT id_localidad
					FROM localidades
					WHERE 
						nom_loc = hnznr.localidad
					AND id_dpto IS NOT NULL
				), 570
			),
			'DNI',
			hnznr.docum,
			str_separa_ape(hnznr.nomyape,true),
			str_separa_ape(hnznr.nomyape,false),
			(CASE hnznr.sexo
				WHEN '1' THEN 'M'
				WHEN '2' THEN 'F'
				WHEN 'M' THEN 'M'
				WHEN 'F' THEN 'F'
				ELSE 'D'
        	END),
			hnznr.direc,
			NULL,
			NULL,
			NULL,
			NULL,
			hnznr.telefono,
			NULL,
			hnznr.barrio,
			hnznr.localidad,
			(SELECT nom_dpto
				FROM departamentos
				WHERE 
					id_dpto =
						(SELECT id_dpto
							FROM localidades
							WHERE 
								nom_loc = hnznr.localidad
							AND id_dpto IS NOT NULL
						)
			),
			(SELECT nom_prov
				FROM provincias
				WHERE id_prov = 
					(SELECT id_prov
						FROM departamentos
						WHERE 
							id_dpto =
								(SELECT id_dpto
									FROM localidades
									WHERE 
										nom_loc = hnznr.localidad
									AND id_dpto IS NOT NULL
								)
					)
			),
			(SELECT nom_pais
				FROM paises
				WHERE id_pais =
					(SELECT id_pais
						FROM provincias
						WHERE id_prov = 
							(SELECT id_prov
								FROM departamentos
								WHERE 
									id_dpto =
										(SELECT id_dpto
											FROM localidades
											WHERE 
												nom_loc = hnznr.localidad
											AND id_dpto IS NOT NULL
										)
							)
					)
			),
			(IF	(hnznr.fecnac='0000-00-00',
				IF (TRIM(hnznr.fecnacpac)<>'',
					CONCAT( RIGHT(hnznr.fecnacpac,4),
							'-', 
							LEFT(RIGHT(hnznr.fecnacpac,7),2),
							'-',
							LEFT(hnznr.fecnacpac,2)
					)
					,NULL),
				hnznr.fecnac)
			),
			NULL,
			IF (hnznr.mdocum=0,'DNR',
				IF (hnznr.mdocum < 10000000 AND hnznr.tipodocm<>1,
					'CI',
					IF (hnznr.mdocum > 50000000 , 'OTR','DNI')
				)
			),
			IF(hnznr.mdocum=0,NULL,hnznr.mdocum),
			NULL,
			NULL,
        	NULL,
        	IF (hnznr.obsoc<>'999' 
        		AND hnznr.obsoc<>'0' 
        		AND TRIM(hnznr.obsoc)<>'',
        			'obra social',
        			'ninguna'),
        	FALSE,
        	NULL,
        	9,
        	FALSE
        FROM 	pacientes_hosp_ninos_zona_norte_rosario hnznr
        
        WHERE
        		docum>10000000
        		
        ON DUPLICATE KEY UPDATE
        
        	id_localidad = 
        		IFNULL(
					(SELECT id_localidad
						FROM localidades
						WHERE 
							nom_loc = hnznr.localidad
						AND id_dpto IS NOT NULL
					), personas.id_localidad
				),
							
			tipo_doc = 
				(IF (hnznr.docum < 10000000,
					'CI',
					'DNI'
					)
			 	),
			
			nro_doc = hnznr.docum,
			
			apellido = str_separa_ape(hnznr.nomyape,true),
			
			nombre = str_separa_ape(hnznr.nomyape,false),
			
			sexo = 
				(CASE hnznr.sexo
					WHEN '1' THEN 'M'
					WHEN '2' THEN 'F'
					WHEN 'M' THEN 'M'
					WHEN 'F' THEN 'F'
					ELSE 'D'
	        	END),
        		
			dom_calle = hnznr.direc,
			
			telefono_dom = hnznr.telefono,
			
			barrio = hnznr.barrio,
			
			localidad = 
				IFNULL( (SELECT nom_dpto
					FROM departamentos
					WHERE 
						id_dpto =
							(SELECT id_dpto
								FROM localidades
								WHERE 
									nom_loc = hnznr.localidad
								AND id_dpto IS NOT NULL
							)
				), personas.localidad),
			
			departamento = 
				IFNULL( (SELECT nom_dpto
					FROM departamentos
					WHERE 
						id_dpto =
							(SELECT id_dpto
								FROM localidades
								WHERE 
									nom_loc = hnznr.localidad
								AND id_dpto IS NOT NULL
							)
				), personas.departamento),
				
			provincia = 
				IFNULL( (SELECT nom_prov
					FROM provincias
					WHERE id_prov = 
						(SELECT id_prov
							FROM departamentos
							WHERE 
								id_dpto =
									(SELECT id_dpto
										FROM localidades
										WHERE 
											nom_loc = hnznr.localidad
										AND id_dpto IS NOT NULL
									)
						)
				), personas.provincia),
				
			pais = 
				IFNULL( (SELECT nom_pais
					FROM paises
					WHERE id_pais =
						(SELECT id_pais
							FROM provincias
							WHERE id_prov = 
								(SELECT id_prov
									FROM departamentos
									WHERE 
										id_dpto =
											(SELECT id_dpto
												FROM localidades
												WHERE 
													nom_loc = hnznr.localidad
												AND id_dpto IS NOT NULL
											)
								)
						)
				), personas.pais),
				
			fecha_nac = 
				IF(hnznr.fecnac='0000-00-00',
					IF (TRIM(hnznr.fecnacpac)<>'',
						CONCAT( RIGHT(hnznr.fecnacpac,4),'-', LEFT(RIGHT(hnznr.fecnacpac,7),2),'-',LEFT(hnznr.fecnacpac,2))
						,NULL),
					hnznr.fecnac),
			
			tipo_doc_madre = IF (hnznr.mdocum=0,'DNR',
								IF (hnznr.mdocum < 10000000 AND hnznr.tipodocm<>1,
									'CI',
									IF (hnznr.mdocum > 50000000 , 'OTR','DNI')
								)
				),
			nro_doc_madre = IF(hnznr.mdocum=0,NULL,hnznr.mdocum),
        	asociado = 
        		(IF (hnznr.obsoc<>'999' 
	        		AND hnznr.obsoc<>'0' 
	        		AND TRIM(hnznr.obsoc)<>'',
	        			'obra social',
	        			'ninguna')
	        	),
        			
        	id_origen_info = 9;

/* habilita los indices para la tabla personas*/	
ALTER TABLE personas ENABLE KEYS;
				
/* Deshabilita los indices de historias clinicas de personas*/
ALTER TABLE hc_personas DISABLE KEYS;

/* inserta las historias clinicas de los pacientes */
INSERT INTO hc_personas
	SELECT	0,
			181,
			(SELECT id_persona
				FROM personas p
				WHERE	hnznr.docum			= p.nro_doc
				AND
						(IF (hnznr.docum < 10000000,
							'CI',
							'DNI'
							)
					 	) = p.tipo_doc 
				LIMIT 0,1),
			4,		/* id_sistema_propietario		*/
			NULL,	/* numero_paciente_sicap		*/
			NULL,	/* numero_grupo_familiar_sicap	*/
			NULL,	/* historia_familiar_sicap		*/
			NULL,	/* historia_personal_sicap		*/
			NULL,	/* his_cli_internacion_hmi		*/
			NULL,	/* his_cli_ce_hmi				*/
			NULL,	/* his_cli_sihos				*/
			hnznr.codigo,	/* his_cli_sistema_propietario	*/
			NULL	/* nr0_hc_diagnose				*/
	FROM 	
		pacientes_hosp_ninos_zona_norte_rosario hnznr
	WHERE
        docum>10000000
	ON DUPLICATE KEY UPDATE 
		id_sistema_propietario = 4,
		his_cli_sistema_propietario = hnznr.codigo;
		
/* habilita los indices en historia clinicas de personas */
ALTER TABLE hc_personas ENABLE KEYS;