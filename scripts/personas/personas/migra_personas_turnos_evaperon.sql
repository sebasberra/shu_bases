/* ------------------------------------------------------------------------- */
/* TURNOS EVA PERON - carga las personas del sistema de turnos del eva peron */
/* ------------------------------------------------------------------------- */

/* NOTAS: para la generacion de la tabla "paciente_turnos_evaperon" se procedio a levantar un	*/
/*	backup de la base completa en SQL Server en la PC de Jorge y desde alli se exporto la tabla */
/*  "paciente" al MySql de la PC de Sebastian, con el nombre de "paciente_turnos_evaperon"		*/
/*  Se utilizo la herramienta "administrador corporativo" del SQL Server						*/



INSERT IGNORE INTO origen_info(id_origen_info, origen_info) VALUES (5,'TURNOS EVA PERON');

/* marca en la tabla de migracion del sistema de turnos del eva peron las personas que ya esten en */
/* la tabla personas y ESTEN fallecidas */
UPDATE personas p, paciente_turnos_evaperon pep
	SET pep.marca_borrado=TRUE
	WHERE	p.nro_doc = pep.NroDoc
	AND		p.fallecido IS TRUE
	AND		(CASE pep.TipoDoc
				
				WHEN '3' THEN 'DNI'
				WHEN '7' THEN 'DNI'
				WHEN '13' THEN 'DNI'
				WHEN '16' THEN 'DNI'
				WHEN '17' THEN 'DNI'
				WHEN '18' THEN 'DNI'
				WHEN '19' THEN 'DNI'
				WHEN '22' THEN 'DNI'
				WHEN '23' THEN 'DNI'
				WHEN '24' THEN 'DNI'
				WHEN '25' THEN 'DNI'
				WHEN '26' THEN 'DNI'
				
				WHEN '5' THEN 'OTR'
				
				WHEN '2' THEN 'LC'
				WHEN '1' THEN 'LE'
				
				WHEN '6' THEN 'CI'
				WHEN '8' THEN 'CI'
				
				ELSE 'DNR'
			END) = p.tipo_doc;

/* Antes de generar las historias clinicas, pone en NULL los numeros de */
/* historias clinicas de turnos del eva peron porque encontre personas */
/* que le modificaron el documento entonces el nro de hc del eva peron */
/* ya existia, pero se me genero un nuevo id de persona */
/* NOTA: faltaria buscar registros de personas que tengan todos los */
/* numeros de historias clinicas en NULL y limpiarlos o eliminarlos */

/*UPDATE hc_personas
	SET his_cli_turnos_evaperon = NULL
	
	WHERE
		numero_paciente_sicap IS NOT NULL
	OR	numero_grupo_familiar_sicap IS NOT NULL
	OR	historia_familiar_sicap IS NOT NULL
	OR	historia_personal_sicap IS NOT NULL
	OR	his_cli_internacion_hmi IS NOT NULL
	OR	his_cli_ce_hmi IS NOT NULL
	OR	his_cli_sihos IS NOT NULL
	OR	his_cli_hosp_reconquista IS NOT NULL;
	
DELETE FROM hc_personas
	WHERE
		his_cli_turnos_evaperon IS NOT NULL
	AND	numero_paciente_sicap IS NULL
	AND	numero_grupo_familiar_sicap IS NULL
	AND	historia_familiar_sicap IS NULL
	AND	historia_personal_sicap IS NULL
	AND	his_cli_internacion_hmi IS NULL
	AND	his_cli_ce_hmi IS NULL
	AND	his_cli_sihos IS NULL
	AND	his_cli_hosp_reconquista IS NULL;*/
				
/* deshabilita los indices de la tabla personas */
ALTER TABLE hc_personas DISABLE KEYS;
			
/* antes de borrar, guarda las historias clinicas de las personas fallecidas */
INSERT INTO hc_personas
	SELECT	0,
			167,
			(SELECT id_persona
				FROM personas p
				WHERE	pep.NroDoc			= p.nro_doc
				AND
						(CASE pep.TipoDoc
				
							WHEN '3' THEN 'DNI'
							WHEN '7' THEN 'DNI'
							WHEN '13' THEN 'DNI'
							WHEN '16' THEN 'DNI'
							WHEN '17' THEN 'DNI'
							WHEN '18' THEN 'DNI'
							WHEN '19' THEN 'DNI'
							WHEN '22' THEN 'DNI'
							WHEN '23' THEN 'DNI'
							WHEN '24' THEN 'DNI'
							WHEN '25' THEN 'DNI'
							WHEN '26' THEN 'DNI'
							
							WHEN '5' THEN 'OTR'
							
							WHEN '2' THEN 'LC'
							WHEN '1' THEN 'LE'
							
							WHEN '6' THEN 'CI'
							WHEN '8' THEN 'CI'
							
							ELSE 'DNR'
						END)				= p.tipo_doc 
				LIMIT 0,1),
			1, /* id_sistema_propietario */
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			pep.IdHistCli,
			NULL
			
	FROM 	paciente_turnos_evaperon pep
	WHERE 	
		pep.IdHistCli>0 
	AND pep.IdHistCli<270000
	AND pep.marca_borrado = TRUE
	
	ON DUPLICATE KEY UPDATE 
		his_cli_sistema_propietario = pep.IdHistCli;			
			
/* elimina de la tabla de hmi cruda los que tienen marca de borrado */	
DELETE FROM paciente_turnos_evaperon
	WHERE	marca_borrado=TRUE;			
											
			
			
/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;			
								
/* inserta los pacientes de turnos del eva peron */
/* NOTA: */
INSERT INTO personas
	SELECT	0,
			(SELECT id_localidad
				FROM	localidades
				WHERE	nom_loc = (SELECT Localidad 
										FROM localida_turnos_evaperon l 
										WHERE pep.Idlocalidad = l.IdLocalidad
										LIMIT 0,1)
				LIMIT 0,1
				),
			CASE pep.TipoDoc
				
				WHEN '3' THEN 'DNI'
				WHEN '7' THEN 'DNI'
				WHEN '13' THEN 'DNI'
				WHEN '16' THEN 'DNI'
				WHEN '17' THEN 'DNI'
				WHEN '18' THEN 'DNI'
				WHEN '19' THEN 'DNI'
				WHEN '22' THEN 'DNI'
				WHEN '23' THEN 'DNI'
				WHEN '24' THEN 'DNI'
				WHEN '25' THEN 'DNI'
				WHEN '26' THEN 'DNI'
				
				WHEN '5' THEN 'OTR'
				
				WHEN '2' THEN 'LC'
				WHEN '1' THEN 'LE'
				
				WHEN '6' THEN 'CI'
				WHEN '8' THEN 'CI'
				
				ELSE 'DNR'
			END,
			pep.NroDoc,
			str_separa_ape(pep.apellido,true),
			str_separa_ape(pep.apellido,false),
			CASE pep.sexo
				WHEN '1' THEN 'M'
				WHEN '3' THEN 'M'
				WHEN '2' THEN 'F'
				WHEN '5' THEN 'F'
				ELSE 'D'
        	END,
			pep.Calle,
			pep.NroDom,
			pep.DptoDom,
			pep.PisoDom,
			NULL,
			pep.Telefono,
			NULL,
			NULL,
			(SELECT Localidad 
				FROM localida_turnos_evaperon l 
				WHERE pep.Idlocalidad = l.IdLocalidad
				LIMIT 0,1),
			(SELECT nom_dpto 
				FROM departamentos 
				WHERE	id_dpto = (SELECT id_dpto
										FROM	localidades
										WHERE	nom_loc = (SELECT Localidad 
																FROM localida_turnos_evaperon l 
																WHERE pep.Idlocalidad = l.IdLocalidad
																LIMIT 0,1)
										LIMIT 0,1
									)
				),
			(SELECT nom_prov
				FROM provincias
				WHERE	id_prov =(SELECT id_prov 
									FROM departamentos 
									WHERE	id_dpto = (SELECT id_dpto
															FROM	localidades
															WHERE	nom_loc = (SELECT Localidad 
																					FROM localida_turnos_evaperon l 
																					WHERE pep.Idlocalidad = l.IdLocalidad
																					LIMIT 0,1)
															LIMIT 0,1
														)
									)
				),
			(SELECT nom_pais
				FROM paises
				WHERE id_pais = (SELECT id_pais
									FROM provincias
									WHERE	id_prov =(SELECT id_prov 
														FROM departamentos 
														WHERE	id_dpto = (SELECT id_dpto
																				FROM	localidades
																				WHERE	nom_loc = (SELECT Localidad 
																										FROM localida_turnos_evaperon l 
																										WHERE pep.Idlocalidad = l.IdLocalidad
																										LIMIT 0,1)
																				LIMIT 0,1
																			)
														)
									)
				),
			IF(FechNaci=0,NULL,DATE_ADD('1800-12-28',INTERVAL FechNaci DAY)),
			(SELECT DOcupacion
				FROM	ocupaciones_turnos_evaperon o
				WHERE o.IdOcupacion = pep.IdOcupacion
				LIMIT 0,1),
			NULL,
			NULL,
			NULL,
			CASE pep.EstCivil
				WHEN 5	THEN 'VIUDO'
				WHEN 11 THEN 'VIUDO'
				WHEN 1 	THEN 'SOLTERO'
				WHEN 2 	THEN 'CASADO'
				WHEN 3	THEN 'DIVORCIADO'
				WHEN 10	THEN 'DIVORCIADO'
				ELSE NULL
        	END,
        	NULL,
        	NULL,
        	FALSE,
        	IF(FechUltCons=0,NULL,DATE_ADD('1800-12-28',INTERVAL FechUltCons DAY)),
        	5,
        	FALSE
        	
        FROM 	paciente_turnos_evaperon pep
        WHERE
        		pep.NroDoc>10000
        
        ON DUPLICATE KEY UPDATE
        
        	id_localidad = (SELECT id_localidad
				FROM	localidades
				WHERE	nom_loc = (SELECT Localidad 
										FROM localida_turnos_evaperon l 
										WHERE pep.Idlocalidad = l.IdLocalidad
										LIMIT 0,1)
				LIMIT 0,1
				),
			tipo_doc = (CASE pep.TipoDoc
				
				WHEN '3' THEN 'DNI'
				WHEN '7' THEN 'DNI'
				WHEN '13' THEN 'DNI'
				WHEN '16' THEN 'DNI'
				WHEN '17' THEN 'DNI'
				WHEN '18' THEN 'DNI'
				WHEN '19' THEN 'DNI'
				WHEN '22' THEN 'DNI'
				WHEN '23' THEN 'DNI'
				WHEN '24' THEN 'DNI'
				WHEN '25' THEN 'DNI'
				WHEN '26' THEN 'DNI'
				
				WHEN '5' THEN 'OTR'
				
				WHEN '2' THEN 'LC'
				WHEN '1' THEN 'LE'
				
				WHEN '6' THEN 'CI'
				WHEN '8' THEN 'CI'
				
				ELSE 'DNR'
			END),
			nro_doc = pep.NroDoc,
			apellido = str_separa_ape(pep.apellido,true),
			nombre =str_separa_ape(pep.apellido,false),
			sexo = (CASE pep.sexo
				WHEN '1' THEN 'M'
				WHEN '3' THEN 'M'
				WHEN '2' THEN 'F'
				WHEN '5' THEN 'F'
				ELSE 'D'
        	END),
			dom_calle = pep.Calle,
			dom_nro = pep.NroDom,
			dom_dpto = pep.DptoDom,
			dom_piso = pep.PisoDom,
			
			telefono_dom = pep.Telefono,
			
			localidad = (SELECT Localidad 
				FROM localida_turnos_evaperon l 
				WHERE pep.Idlocalidad = l.IdLocalidad
				LIMIT 0,1),
			
			departamento = (SELECT nom_dpto 
				FROM departamentos 
				WHERE	id_dpto = (SELECT id_dpto
										FROM	localidades
										WHERE	nom_loc = (SELECT Localidad 
																FROM localida_turnos_evaperon l 
																WHERE pep.Idlocalidad = l.IdLocalidad
																LIMIT 0,1)
										LIMIT 0,1
									)
				),
			provincia = (SELECT nom_prov
				FROM provincias
				WHERE	id_prov =(SELECT id_prov 
									FROM departamentos 
									WHERE	id_dpto = (SELECT id_dpto
															FROM	localidades
															WHERE	nom_loc = (SELECT Localidad 
																					FROM localida_turnos_evaperon l 
																					WHERE pep.Idlocalidad = l.IdLocalidad
																					LIMIT 0,1)
															LIMIT 0,1
														)
									)
				),
			pais = (SELECT nom_pais
				FROM paises
				WHERE id_pais = (SELECT id_pais
									FROM provincias
									WHERE	id_prov =(SELECT id_prov 
														FROM departamentos 
														WHERE	id_dpto = (SELECT id_dpto
																				FROM	localidades
																				WHERE	nom_loc = (SELECT Localidad 
																										FROM localida_turnos_evaperon l 
																										WHERE pep.Idlocalidad = l.IdLocalidad
																										LIMIT 0,1)
																				LIMIT 0,1
																			)
														)
									)
				),
			fecha_nac = IF(FechNaci=0,NULL,DATE_ADD('1800-12-28',INTERVAL FechNaci DAY)),
			ocupacion = (SELECT DOcupacion
				FROM	ocupaciones_turnos_evaperon o
				WHERE o.IdOcupacion = pep.IdOcupacion
				LIMIT 0,1),
			
			estado_civil = (CASE pep.EstCivil
				WHEN 5	THEN 'VIUDO'
				WHEN 11 THEN 'VIUDO'
				WHEN 1 	THEN 'SOLTERO'
				WHEN 2 	THEN 'CASADO'
				WHEN 3	THEN 'DIVORCIADO'
				WHEN 10	THEN 'DIVORCIADO'
				ELSE NULL
        	END),
        	fecha_ultima_cond =	IF(FechUltCons=0,NULL,DATE_ADD('1800-12-28',INTERVAL FechUltCons DAY)),
        	id_origen_info = 5;

/* habilita los indices para la tabla personas*/	
ALTER TABLE personas ENABLE KEYS;
				
/* Deshabilita los indices de historias clinicas de personas*/
ALTER TABLE hc_personas DISABLE KEYS;

/* inserta las historias clinicas de los pacientes */
INSERT INTO hc_personas
	SELECT	0,
			167,
			(SELECT id_persona
				FROM personas p
				WHERE	pep.NroDoc			= p.nro_doc
				AND
						(CASE pep.TipoDoc
				
							WHEN '3' THEN 'DNI'
							WHEN '7' THEN 'DNI'
							WHEN '13' THEN 'DNI'
							WHEN '16' THEN 'DNI'
							WHEN '17' THEN 'DNI'
							WHEN '18' THEN 'DNI'
							WHEN '19' THEN 'DNI'
							WHEN '22' THEN 'DNI'
							WHEN '23' THEN 'DNI'
							WHEN '24' THEN 'DNI'
							WHEN '25' THEN 'DNI'
							WHEN '26' THEN 'DNI'
							
							WHEN '5' THEN 'OTR'
							
							WHEN '2' THEN 'LC'
							WHEN '1' THEN 'LE'
							
							WHEN '6' THEN 'CI'
							WHEN '8' THEN 'CI'
							
							ELSE 'DNR'
						END)				= p.tipo_doc 
				LIMIT 0,1),
			1, /* id_sistema_propietario */
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			pep.IdHistCli,
			NULL
			
	FROM 	paciente_turnos_evaperon pep
	WHERE 	
			pep.IdHistCli>0 
	AND 	pep.IdHistCli<270000
	AND		pep.NroDoc>10000
	
	ON DUPLICATE KEY UPDATE 
		his_cli_sistema_propietario = pep.IdHistCli;
		
/* habilita los indices en historia clinicas de personas */
ALTER TABLE hc_personas ENABLE KEYS;
				