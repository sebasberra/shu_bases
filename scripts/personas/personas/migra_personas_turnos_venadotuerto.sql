/* ------------------------------------------------------------------------------------------------ */
/* TURNOS SAMCo VENADO TUERTO - carga las personas del sistema de turnos del SAMCo de Venado Tuerto */
/* ------------------------------------------------------------------------------------------------ */


INSERT IGNORE INTO origen_info(id_origen_info, origen_info) VALUES (8,"TURNOS VENADO TUERTO");

/* marca en la tabla de migracion del sistema de turnos del eva peron las personas que ya esten en */
/* la tabla personas y ESTEN fallecidas */
UPDATE personas p, pacientes_turnos_venadotuerto pvt
	SET pvt.marca_borrado=TRUE
	WHERE	p.nro_doc = pvt.Numerodocumento
	AND		pvt.Numerodocumento > 100000
	AND		p.fallecido IS TRUE
	AND		(CASE pvt.Codigodocumento
		         
				WHEN 96 THEN 'DNI'
				
				WHEN 0	THEN 'DNI'
				WHEN 1	THEN 'DNI'
				WHEN 2	THEN 'DNI'
				WHEN 3	THEN 'DNI'
				WHEN 4	THEN 'DNI'
				WHEN 5	THEN 'DNI'
				WHEN 6	THEN 'DNI'
				WHEN 7	THEN 'DNI'
				WHEN 8	THEN 'DNI'
				WHEN 9	THEN 'DNI'
				WHEN 10	THEN 'DNI'
				WHEN 11	THEN 'DNI'
				WHEN 12	THEN 'DNI'
				WHEN 13	THEN 'DNI'
				WHEN 14	THEN 'DNI'
				WHEN 15 THEN 'DNI'
				WHEN 16 THEN 'DNI'
				WHEN 17 THEN 'DNI'
				WHEN 18 THEN 'DNI'
				WHEN 19 THEN 'DNI'
				WHEN 20	THEN 'DNI'
				WHEN 21 THEN 'DNI'
				WHEN 22 THEN 'DNI'
				WHEN 23 THEN 'DNI'
				WHEN 24 THEN 'DNI'
				
				WHEN 94 THEN 'OTR'
				WHEN 80 THEN 'OTR'
				
				WHEN 90 THEN 'LC'
				WHEN 89 THEN 'LE'
				
				ELSE 'DNR'
			END) = p.tipo_doc
		;

				
/* deshabilita los indices de la tabla personas */
ALTER TABLE hc_personas DISABLE KEYS;
			
/* antes de borrar, guarda las historias clinicas de las personas fallecidas */
INSERT INTO hc_personas
	SELECT	0,
			536,
			(SELECT id_persona
				FROM personas p
				WHERE	pvt.Numerodocumento			= p.nro_doc
				AND
						(CASE pvt.Codigodocumento
				
							WHEN 96 THEN 'DNI'
				
							WHEN 0	THEN 'DNI'
							WHEN 1	THEN 'DNI'
							WHEN 2	THEN 'DNI'
							WHEN 3	THEN 'DNI'
							WHEN 4	THEN 'DNI'
							WHEN 5	THEN 'DNI'
							WHEN 6	THEN 'DNI'
							WHEN 7	THEN 'DNI'
							WHEN 8	THEN 'DNI'
							WHEN 9	THEN 'DNI'
							WHEN 10	THEN 'DNI'
							WHEN 11	THEN 'DNI'
							WHEN 12	THEN 'DNI'
							WHEN 13	THEN 'DNI'
							WHEN 14	THEN 'DNI'
							WHEN 15 THEN 'DNI'
							WHEN 16 THEN 'DNI'
							WHEN 17 THEN 'DNI'
							WHEN 18 THEN 'DNI'
							WHEN 19 THEN 'DNI'
							WHEN 20	THEN 'DNI'
							WHEN 21 THEN 'DNI'
							WHEN 22 THEN 'DNI'
							WHEN 23 THEN 'DNI'
							WHEN 24 THEN 'DNI'
							
							WHEN 94 THEN 'OTR'
							WHEN 80 THEN 'OTR'
							
							WHEN 90 THEN 'LC'
							WHEN 89 THEN 'LE'
							
							ELSE 'DNR'
						END) = p.tipo_doc 
				LIMIT 0,1),
			3,		/* id_sistema_propietario		*/
			NULL,	/* numero_paciente_sicap		*/
			NULL,	/* numero_grupo_familiar_sicap	*/
			NULL,	/* historia_familiar_sicap		*/
			NULL,	/* historia_personal_sicap		*/
			NULL,	/* his_cli_internacion_hmi		*/
			NULL,	/* his_cli_ce_hmi				*/
			NULL,	/* his_cli_sihos				*/
			pvt.Nropaciente,	/* his_cli_sistema_propietario	*/
			NULL	/* nr0_hc_diagnose				*/
			
	FROM 	pacientes_turnos_venadotuerto pvt
	
	WHERE 	
		pvt.marca_borrado = TRUE
	
	ON DUPLICATE KEY UPDATE 
		his_cli_sistema_propietario = pvt.Nropaciente;
			
/* elimina de la tabla de venado tuerto cruda los que tienen marca de borrado */	
DELETE FROM pacientes_turnos_venadotuerto
	WHERE	marca_borrado=TRUE;			
											
			
			
/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;			
								


/* inserta los pacientes de turnos del eva peron */
/* NOTA: */
INSERT INTO personas
	SELECT	0,
			IFNULL(
				(SELECT id_localidad
					FROM localidades
					WHERE 
						nom_loc = 
							(SELECT Localidad
								FROM localidades_turnos_venadotuerto lvt
								WHERE lvt.Codigopostal = pvt.Codigopostal
							)
					AND id_dpto IS NOT NULL
				), 570
			),
			(CASE pvt.Codigodocumento
				
				WHEN 96 THEN 'DNI'
	
				WHEN 0	THEN 'DNI'
				WHEN 1	THEN 'DNI'
				WHEN 2	THEN 'DNI'
				WHEN 3	THEN 'DNI'
				WHEN 4	THEN 'DNI'
				WHEN 5	THEN 'DNI'
				WHEN 6	THEN 'DNI'
				WHEN 7	THEN 'DNI'
				WHEN 8	THEN 'DNI'
				WHEN 9	THEN 'DNI'
				WHEN 10	THEN 'DNI'
				WHEN 11	THEN 'DNI'
				WHEN 12	THEN 'DNI'
				WHEN 13	THEN 'DNI'
				WHEN 14	THEN 'DNI'
				WHEN 15 THEN 'DNI'
				WHEN 16 THEN 'DNI'
				WHEN 17 THEN 'DNI'
				WHEN 18 THEN 'DNI'
				WHEN 19 THEN 'DNI'
				WHEN 20	THEN 'DNI'
				WHEN 21 THEN 'DNI'
				WHEN 22 THEN 'DNI'
				WHEN 23 THEN 'DNI'
				WHEN 24 THEN 'DNI'
				
				WHEN 94 THEN 'OTR'
				WHEN 80 THEN 'OTR'
				
				WHEN 90 THEN 'LC'
				WHEN 89 THEN 'LE'
				
				ELSE 'DNR'
			END),
			pvt.NumeroDocumento,
			str_separa_ape(pvt.Razonsocial,true),
			str_separa_ape(pvt.Razonsocial,false),
			(CASE pvt.sexo
				WHEN '1' THEN 'M'
				WHEN '2' THEN 'F'
				ELSE 'D'
        	END),
			pvt.Domicilio,
			NULL,
			NULL,
			NULL,
			NULL,
			TRIM(CONCAT(pvt.Telefonoparticular,' t: ',pvt.Telefonocomercial)),
			pvt.Celular,
			NULL,
			(SELECT Localidad
				FROM localidades_turnos_venadotuerto lvt
				WHERE lvt.Codigopostal = pvt.Codigopostal
			),
			(SELECT nom_dpto
				FROM departamentos
				WHERE 
					id_dpto =
						(SELECT id_dpto
							FROM localidades
							WHERE 
								nom_loc = 
									(SELECT Localidad
										FROM localidades_turnos_venadotuerto lvt
										WHERE lvt.Codigopostal = pvt.Codigopostal
									)
							AND id_dpto IS NOT NULL
						)
			),
			(SELECT Provincia
				FROM provincias_turnos_venadotuerto prvt
				WHERE prvt.Codigo_Provincia = pvt.Codigoprovincia
			),
			(SELECT nom_pais
				FROM paises
				WHERE 
					id_pais =
						(SELECT id_pais
							FROM provincias
							WHERE 
								nom_prov = 
									(SELECT Provincia
										FROM provincias_turnos_venadotuerto prvt
										WHERE prvt.Codigo_Provincia = pvt.Codigoprovincia
									)
						)
			),
			
			IF(Fechanacimiento='  /  /',
				NULL,
				CONCAT( RIGHT(Fechanacimiento,4),'-', 
						LEFT(RIGHT(Fechanacimiento,7),2),'-',
						LEFT(Fechanacimiento,2)
					)
			),
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
        	NULL,
        	NULL,
        	FALSE,
        	NULL,
        	8,
        	FALSE
        	
        FROM 	pacientes_turnos_venadotuerto pvt
        
        WHERE
        		pvt.Numerodocumento > 100000
        
        ON DUPLICATE KEY UPDATE
        
        	id_localidad = 
        		IFNULL(
					(SELECT id_localidad
						FROM localidades
						WHERE 
							nom_loc = 
								(SELECT Localidad
									FROM localidades_turnos_venadotuerto lvt
									WHERE lvt.Codigopostal = pvt.Codigopostal
								)
						AND id_dpto IS NOT NULL
					), 570
				),
							
			tipo_doc = 
				(CASE pvt.Codigodocumento
				
					WHEN 96 THEN 'DNI'
		
					WHEN 0	THEN 'DNI'
					WHEN 1	THEN 'DNI'
					WHEN 2	THEN 'DNI'
					WHEN 3	THEN 'DNI'
					WHEN 4	THEN 'DNI'
					WHEN 5	THEN 'DNI'
					WHEN 6	THEN 'DNI'
					WHEN 7	THEN 'DNI'
					WHEN 8	THEN 'DNI'
					WHEN 9	THEN 'DNI'
					WHEN 10	THEN 'DNI'
					WHEN 11	THEN 'DNI'
					WHEN 12	THEN 'DNI'
					WHEN 13	THEN 'DNI'
					WHEN 14	THEN 'DNI'
					WHEN 15 THEN 'DNI'
					WHEN 16 THEN 'DNI'
					WHEN 17 THEN 'DNI'
					WHEN 18 THEN 'DNI'
					WHEN 19 THEN 'DNI'
					WHEN 20	THEN 'DNI'
					WHEN 21 THEN 'DNI'
					WHEN 22 THEN 'DNI'
					WHEN 23 THEN 'DNI'
					WHEN 24 THEN 'DNI'
					
					WHEN 94 THEN 'OTR'
					WHEN 80 THEN 'OTR'
					
					WHEN 90 THEN 'LC'
					WHEN 89 THEN 'LE'
					
					ELSE 'DNR'
				END),
			
			nro_doc = pvt.NumeroDocumento,
			
			apellido = str_separa_ape(pvt.Razonsocial,true),
			
			nombre =str_separa_ape(pvt.Razonsocial,false),
			
			sexo = 
				(CASE pvt.sexo
					WHEN '1' THEN 'M'
					WHEN '2' THEN 'F'
					ELSE 'D'
        		END),
        		
			dom_calle = pvt.Domicilio,
			
			telefono_dom = TRIM(CONCAT(pvt.Telefonoparticular,' t: ',pvt.Telefonocomercial)),
			
			telefono_cel = pvt.Celular,
			
			localidad = 
				(SELECT Localidad
					FROM localidades_turnos_venadotuerto lvt
					WHERE lvt.Codigopostal = pvt.Codigopostal
				),
			
			departamento = 
				(SELECT nom_dpto
					FROM departamentos
					WHERE 
						id_dpto =
							(SELECT id_dpto
								FROM localidades
								WHERE 
									nom_loc = 
										(SELECT Localidad
											FROM localidades_turnos_venadotuerto lvt
											WHERE lvt.Codigopostal = pvt.Codigopostal
										)
								AND id_dpto IS NOT NULL
							)
				),
				
			provincia = 
				(SELECT Provincia
					FROM provincias_turnos_venadotuerto prvt
					WHERE prvt.Codigo_Provincia = pvt.Codigoprovincia
				),
				
			pais = 
				(SELECT nom_pais
					FROM paises
					WHERE 
						id_pais =
							(SELECT id_pais
								FROM provincias
								WHERE 
									nom_prov = 
										(SELECT Provincia
											FROM provincias_turnos_venadotuerto prvt
											WHERE prvt.Codigo_Provincia = pvt.Codigoprovincia
										)
							)
				),
				
			fecha_nac = 
				IF(Fechanacimiento='  /  /',
					fecha_nac,
					CONCAT( RIGHT(Fechanacimiento,4),'-', 
							LEFT(RIGHT(Fechanacimiento,7),2),'-',
							LEFT(Fechanacimiento,2)
						)
				),
				
        	id_origen_info = 8;

/* habilita los indices para la tabla personas*/	
ALTER TABLE personas ENABLE KEYS;
				
/* Deshabilita los indices de historias clinicas de personas*/
ALTER TABLE hc_personas DISABLE KEYS;

/* inserta las historias clinicas de los pacientes */
INSERT INTO hc_personas
	SELECT	0,
			536,
			(SELECT id_persona
				FROM personas p
				WHERE	pvt.Numerodocumento			= p.nro_doc
				AND
						(CASE pvt.Codigodocumento
				
							WHEN 96 THEN 'DNI'
				
							WHEN 0	THEN 'DNI'
							WHEN 1	THEN 'DNI'
							WHEN 2	THEN 'DNI'
							WHEN 3	THEN 'DNI'
							WHEN 4	THEN 'DNI'
							WHEN 5	THEN 'DNI'
							WHEN 6	THEN 'DNI'
							WHEN 7	THEN 'DNI'
							WHEN 8	THEN 'DNI'
							WHEN 9	THEN 'DNI'
							WHEN 10	THEN 'DNI'
							WHEN 11	THEN 'DNI'
							WHEN 12	THEN 'DNI'
							WHEN 13	THEN 'DNI'
							WHEN 14	THEN 'DNI'
							WHEN 15 THEN 'DNI'
							WHEN 16 THEN 'DNI'
							WHEN 17 THEN 'DNI'
							WHEN 18 THEN 'DNI'
							WHEN 19 THEN 'DNI'
							WHEN 20	THEN 'DNI'
							WHEN 21 THEN 'DNI'
							WHEN 22 THEN 'DNI'
							WHEN 23 THEN 'DNI'
							WHEN 24 THEN 'DNI'
							
							WHEN 94 THEN 'OTR'
							WHEN 80 THEN 'OTR'
							
							WHEN 90 THEN 'LC'
							WHEN 89 THEN 'LE'
							
							ELSE 'DNR'
						END) = p.tipo_doc 
				LIMIT 0,1),
			3,		/* id_sistema_propietario		*/
			NULL,	/* numero_paciente_sicap		*/
			NULL,	/* numero_grupo_familiar_sicap	*/
			NULL,	/* historia_familiar_sicap		*/
			NULL,	/* historia_personal_sicap		*/
			NULL,	/* his_cli_internacion_hmi		*/
			NULL,	/* his_cli_ce_hmi				*/
			NULL,	/* his_cli_sihos				*/
			pvt.Nropaciente,	/* his_cli_sistema_propietario	*/
			NULL	/* nr0_hc_diagnose				*/
	FROM 	
		pacientes_turnos_venadotuerto pvt
		
	WHERE
        pvt.Numerodocumento > 100000
        		
	ON DUPLICATE KEY UPDATE 
		his_cli_sistema_propietario = pvt.Nropaciente;
		
/* habilita los indices en historia clinicas de personas */
ALTER TABLE hc_personas ENABLE KEYS;
				