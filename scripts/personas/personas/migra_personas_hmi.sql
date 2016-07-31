/* -------------------------------- */
/* HMI - carga las personas del hmi */
/* -------------------------------- */

/* !!!!!!!!!!!    ACTUALIZAR ID DE EFECTOR    !!!!!!!!!!!!!!!!! */

/* Casilda, Hospital SC 					->	id_efector = 434	*/
/* Samco Ceres								->  id_efector = 226	*/
/* Samco Hersilia							->  id_efector = 230	*/
/* Samco Maria Susana						->  id_efector = 329	*/
/* Samco Pilar								->  id_efector = 127	*/
/* Samco Rafaela							->  id_efector = 450	*/
/* Samco Sastre								->  id_efector = 333	*/
/* Hospital Mira y Lope						->  id_efector = 73		*/
/* Samco San Jorge							->  id_efector = 331	*/
/* Samco Villa Eloisa						->  id_efector = 47		*/
/* Samco Vera								->  id_efector = 340	*/
/* Hospital Cullen							->	id_efector = 71		*/
/* Hospital Iturraspe						->	id_efector = 72		*/
/* Inst. Vera Candiotti 					->	id_efector = 74		*/
/* Hospital Alassia							->	id_efector = 121	*/
/* Hospital Eva Peron   					->  id_efector = 167	*/
/* Hospital Centenario						->	id_efector = 183	*/
/* Hospital Provincial						->	id_efector = 184	*/
/* Hospital San Javier						->	id_efector = 251	*/
/* Hospital Santo Tome  					->  id_efector = 86		*/
/* Hospital San Lorenzo 					->  id_efector = 313	*/
/* Hospital Cañada de Gomez (Hosp San Jose) ->  id_efector = 38		*/
/* Hospital San Justo						->	id_efector = 292	*/
/* Hospital Totaras							->	id_efector = 45		*/
/* Hospital Protomedico						->	id_efector = 63		*/

SET @id_efector := 251;



/* --------------------------------------------------------------------- */
/* se eliminan personas que esten dadas de baja de la tabla de migracion */
/* NOTA: se supone que si una persona tiene la bandera de baja es porque */
/* hubo un motivo concreto en la migracion para hacerlo */
UPDATE personas p, migra_hmi_personas.hmi_dg_pacientes_personas hpp
	SET hpp.marca_borrado=TRUE
	WHERE	
			p.nro_doc = hpp.nro_doc
	AND		p.tipo_doc = hpp.tipo_doc
	AND		p.baja = TRUE;
	
/* elimina de la tabla de migracion las personas dadas de baja de la tabla personas */	
DELETE FROM migra_hmi_personas.hmi_dg_pacientes_personas
	WHERE	marca_borrado=TRUE;	

/* ---------------------------------------------------------------------- */
	
	
	


/* elimina de la tabla de hmi cruda las personas NO fallecidas que ya esten en */
/* la tabla personas y SI esten fallecidas */
UPDATE personas p, migra_hmi_personas.hmi_dg_pacientes_personas hpp
	SET hpp.marca_borrado=TRUE
	WHERE	
			es_documento(hpp.tipo_doc,hpp.nro_doc,hpp.fecha_nac) = 1
	AND		p.nro_doc = hpp.nro_doc
	AND		p.tipo_doc = hpp.tipo_doc
	AND		p.fallecido IS TRUE
	AND		hpp.fallecido IS NOT TRUE
	AND		p.baja = FALSE;
	



	
/* ----------------------------------------------------- */	
/* Elimina las historias clinicas diferentes del efector */
DELETE FROM hc_personas_hmi_diferentes
	WHERE id_efector = @id_efector;
	
	
/* Dehabilita los indices de personas diferentes */
ALTER TABLE hc_personas_hmi_diferentes DISABLE KEYS;
	
/* Proceso para buscar tipo y numero de documentos cambiados entre migraciones anteriores y esta, */
/* a traves del numero de historia clinica de internacion */
INSERT INTO hc_personas_hmi_diferentes
	SELECT 	hc.id_hc_persona,
			hc.id_efector,
			hc.id_persona,                       
			p.tipo_doc,
			p.nro_doc,
			p.apellido,
			p.nombre,
			p.fecha_nac,
			NULL,			
			hpp.tipo_doc,
			hpp.nro_doc,
			hpp.apellido,
			hpp.nombre,
			hpp.fecha_nac,
			hpp.s1hiscli,
			hpp.s3hisclice
			
		FROM
		
			hc_personas hc, 
			migra_hmi_personas.hmi_dg_pacientes_personas hpp, 
			personas p
			
		WHERE
		
			es_documento(hpp.tipo_doc,hpp.nro_doc,hpp.fecha_nac) = 1
		AND	hpp.s1hiscli		=	hc.his_cli_internacion_hmi
		AND	hc.id_persona 	=	p.id_persona
		AND hc.id_efector 	=	@id_efector										
		AND	(hpp.tipo_doc 	<> p.tipo_doc
				OR	hpp.nro_doc	<> p.nro_doc)
				
		ON DUPLICATE KEY UPDATE
			his_cli_internacion_hmi = hpp.s1hiscli,
			his_cli_ce_hmi			= hpp.s3hisclice;
			
/* Proceso para buscar tipo y numero de documentos cambiados entre migraciones anteriores y esta, */
/* a traves del numero de historia clinica de consultorio externo */
INSERT INTO hc_personas_hmi_diferentes
	SELECT 	hc.id_hc_persona,
			hc.id_efector,
			hc.id_persona,                       
			p.tipo_doc,
			p.nro_doc,
			p.apellido,
			p.nombre,
			p.fecha_nac,
			NULL,			
			hpp.tipo_doc,
			hpp.nro_doc,
			hpp.apellido,
			hpp.nombre,
			hpp.fecha_nac,
			hpp.s1hiscli,
			hpp.s3hisclice
			
		FROM
		
			hc_personas hc, 
			migra_hmi_personas.hmi_dg_pacientes_personas hpp, 
			personas p
			
		WHERE
			
			es_documento(hpp.tipo_doc,hpp.nro_doc,hpp.fecha_nac) = 1
		AND	hpp.s3hisclice	=	hc.his_cli_ce_hmi
		AND	hc.id_persona 	=	p.id_persona
		AND hc.id_efector 	=	@id_efector										
		AND	(hpp.tipo_doc 	<> p.tipo_doc
				OR	hpp.nro_doc	<> p.nro_doc)
		AND	p.baja = FALSE
				
		ON DUPLICATE KEY UPDATE
			his_cli_internacion_hmi = hpp.s1hiscli,
			his_cli_ce_hmi			= hpp.s3hisclice;

	
	
/* Marca las personas diferentes en la tabla auxiliar de migracion */
UPDATE migra_hmi_personas.hmi_dg_pacientes_personas hpp, hc_personas_hmi_diferentes hcd
	SET marca_diferente = TRUE
	WHERE	
			es_documento(hpp.tipo_doc,hpp.nro_doc,hpp.fecha_nac) = 1
	AND		hpp.tipo_doc	= hcd.tipo_doc_nuevo
	AND		hpp.nro_doc		= hcd.nro_doc_nuevo;


/* habilita los indices de personas diferentes */
ALTER TABLE hc_personas_hmi_diferentes ENABLE KEYS;
/* ----------------------------------------------------- */





/* deshabilita los indices de la tabla personas */
ALTER TABLE hc_personas DISABLE KEYS;

INSERT INTO hc_personas
	SELECT	0,
			@id_efector,
			(SELECT id_persona
				FROM personas p
				WHERE	hpp.tipo_doc	= p.tipo_doc
				AND		hpp.nro_doc		= p.nro_doc),
			NULL,   /* id_sistema_propietario		*/    
			NULL,   /* numero_paciente_sicap		*/     
			NULL,   /* numero_grupo_familiar_sicap	*/
			NULL,   /* historia_familiar_sicap		*/   
			NULL,   /* historia_personal_sicap		*/   
			hpp.s1hiscli,
			hpp.s3hisclice,
			NULL,	/* his_cli_sihos				*/
			NULL,	/* his_cli_sistema_propietario	*/
			NULL	/* nr0_hc_diagnose				*/
	FROM 	
			migra_hmi_personas.hmi_dg_pacientes_personas hpp
	WHERE 	
			es_documento(hpp.tipo_doc,hpp.nro_doc,hpp.fecha_nac) = 1
	AND		(hpp.s1hiscli IS NOT NULL
	OR		hpp.s3hisclice IS NOT NULL)
	AND		hpp.marca_borrado=TRUE
	AND		hpp.marca_diferente=FALSE
	
	ON DUPLICATE KEY UPDATE
	
		his_cli_internacion_hmi = hpp.s1hiscli,
		his_cli_ce_hmi 			= hpp.s3hisclice;

/* elimina de la tabla de hmi cruda los que tienen marca de borrado */	
DELETE FROM migra_hmi_personas.hmi_dg_pacientes_personas
	WHERE	marca_borrado=TRUE;






/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;

INSERT INTO personas
	SELECT	0,
			hpp.id_localidad,
			hpp.tipo_doc,
			hpp.nro_doc,
			hpp.apellido,
			hpp.nombre,
			hpp.sexo,
			hpp.dom_calle,
			hpp.dom_nro,
			hpp.dom_dpto,
			hpp.dom_piso,
			hpp.dom_mza_monobloc,
			hpp.telefono_dom,
			hpp.telefono_cel,
			hpp.barrio,
			hpp.localidad,
			hpp.departamento,
			hpp.provincia,
			hpp.pais,
			hpp.fecha_nac,
			hpp.ocupacion,
			hpp.tipo_doc_madre,
			hpp.nro_doc_madre,
			hpp.nivel_academico,
			hpp.estado_civil,
			hpp.situacion_laboral,
			hpp.asociado,
			hpp.fallecido,
			hpp.fecha_ultima_cond,
			1,
			FALSE
	FROM	
			migra_hmi_personas.hmi_dg_pacientes_personas hpp
	WHERE
			es_documento(hpp.tipo_doc,hpp.nro_doc,hpp.fecha_nac) = 1
					
	ON DUPLICATE KEY UPDATE
	
		id_localidad	=	IFNULL(hpp.id_localidad,personas.id_localidad),
		apellido		=	hpp.apellido,
		nombre			=	hpp.nombre,
		sexo			=	hpp.sexo,
		dom_calle		=	IFNULL(hpp.dom_calle,personas.dom_calle),
		dom_nro			=	IFNULL(hpp.dom_nro,personas.dom_nro),
		dom_dpto		=	IFNULL(hpp.dom_dpto,personas.dom_dpto),
		dom_piso		=	IFNULL(hpp.dom_piso,personas.dom_piso),
		telefono_dom	=	IFNULL(hpp.telefono_dom,personas.telefono_dom),
		barrio			=	IFNULL(hpp.barrio,personas.barrio),
		localidad		=	IFNULL(hpp.localidad,personas.localidad),
		departamento	=	IFNULL(hpp.departamento,personas.departamento),
		provincia		=	IFNULL(hpp.provincia,personas.provincia),
		pais			=	IFNULL(hpp.pais,personas.pais),
		fecha_nac		=	IFNULL(hpp.fecha_nac,personas.fecha_nac),
		ocupacion		=	IFNULL(hpp.ocupacion,personas.ocupacion),
		tipo_doc_madre	=	IFNULL(hpp.tipo_doc_madre,personas.tipo_doc_madre),
		nro_doc_madre	=	IFNULL(hpp.nro_doc_madre,personas.nro_doc_madre),
		nivel_academico	=	IFNULL(hpp.nivel_academico,personas.nivel_academico),
		estado_civil	=	IFNULL(hpp.estado_civil,personas.estado_civil),
		situacion_laboral=	hpp.situacion_laboral,
		asociado		=	hpp.asociado,
		fallecido		=	hpp.fallecido,
		fecha_ultima_cond=	hpp.fecha_ultima_cond,
		id_origen_info	=	1;
		
/* habilita los indices de la tabla personas */
ALTER TABLE personas ENABLE KEYS;



/* Ingresa las pacientes que tienen documentos con inconsistencias */

/* Elimina los pacientes que tienen inconsistencias de documentos de la tabla correspondiente */
DELETE FROM personas_hmi_docs_inconsistentes
	WHERE id_efector = @id_efector;
	
/* deshabilita los indices de la tabla personas_hmi_docs_inconsistentes */
ALTER TABLE personas_hmi_docs_inconsistentes DISABLE KEYS;

INSERT INTO personas_hmi_docs_inconsistentes
	SELECT	0,
			@id_efector,
			hpp.s1hiscli,
			hpp.s3hisclice,
			hpp.id_localidad,
			hpp.tipo_doc,
			hpp.nro_doc,
			hpp.apellido,
			hpp.nombre,
			hpp.sexo,
			hpp.dom_calle,
			hpp.dom_nro,
			hpp.dom_dpto,
			hpp.dom_piso,
			hpp.dom_mza_monobloc,
			hpp.telefono_dom,
			hpp.telefono_cel,
			hpp.barrio,
			hpp.localidad,
			hpp.departamento,
			hpp.provincia,
			hpp.pais,
			hpp.fecha_nac,
			hpp.ocupacion,
			hpp.tipo_doc_madre,
			hpp.nro_doc_madre,
			hpp.nivel_academico,
			hpp.estado_civil,
			hpp.situacion_laboral,
			hpp.asociado,
			hpp.fallecido,
			hpp.fecha_ultima_cond,
			1,
			FALSE
	FROM	
			migra_hmi_personas.hmi_dg_pacientes_personas hpp
	WHERE
			es_documento(hpp.tipo_doc,hpp.nro_doc,hpp.fecha_nac) = 0
					
	ON DUPLICATE KEY UPDATE
	
		his_cli_internacion_hmi = 	hpp.s1hiscli,
		his_cli_ce_hmi			=	hpp.s3hisclice,
		id_localidad			=	IFNULL(hpp.id_localidad,personas_hmi_docs_inconsistentes.id_localidad),
		apellido				=	hpp.apellido,
		nombre					=	hpp.nombre,
		sexo					=	hpp.sexo,
		dom_calle				=	IFNULL(hpp.dom_calle,personas_hmi_docs_inconsistentes.dom_calle),
		dom_nro					=	IFNULL(hpp.dom_nro,personas_hmi_docs_inconsistentes.dom_nro),
		dom_dpto				=	IFNULL(hpp.dom_dpto,personas_hmi_docs_inconsistentes.dom_dpto),
		dom_piso				=	IFNULL(hpp.dom_piso,personas_hmi_docs_inconsistentes.dom_piso),
		telefono_dom			=	IFNULL(hpp.telefono_dom,personas_hmi_docs_inconsistentes.telefono_dom),
		barrio					=	IFNULL(hpp.barrio,personas_hmi_docs_inconsistentes.barrio),
		localidad				=	IFNULL(hpp.localidad,personas_hmi_docs_inconsistentes.localidad),
		departamento			=	IFNULL(hpp.departamento,personas_hmi_docs_inconsistentes.departamento),
		provincia				=	IFNULL(hpp.provincia,personas_hmi_docs_inconsistentes.provincia),
		pais					=	IFNULL(hpp.pais,personas_hmi_docs_inconsistentes.pais),
		fecha_nac				=	IFNULL(hpp.fecha_nac,personas_hmi_docs_inconsistentes.fecha_nac),
		ocupacion				=	IFNULL(hpp.ocupacion,personas_hmi_docs_inconsistentes.ocupacion),
		tipo_doc_madre			=	IFNULL(hpp.tipo_doc_madre,personas_hmi_docs_inconsistentes.tipo_doc_madre),
		nro_doc_madre			=	IFNULL(hpp.nro_doc_madre,personas_hmi_docs_inconsistentes.nro_doc_madre),
		nivel_academico			=	IFNULL(hpp.nivel_academico,personas_hmi_docs_inconsistentes.nivel_academico),
		estado_civil			=	IFNULL(hpp.estado_civil,personas_hmi_docs_inconsistentes.estado_civil),
		situacion_laboral		=	hpp.situacion_laboral,
		asociado				=	hpp.asociado,
		fallecido				=	hpp.fallecido,
		fecha_ultima_cond		=	hpp.fecha_ultima_cond,
		id_origen_info			=	1;
		
/* habilita los indices de la tabla personas */
ALTER TABLE personas_hmi_docs_inconsistentes ENABLE KEYS;




/* ------------------------------------------ */	
/* HMI - carga las historias clinicas del hmi */
/* ------------------------------------------ */

INSERT INTO hc_personas
	SELECT	0,
			@id_efector,
			(SELECT id_persona
				FROM personas p
				WHERE	hpp.tipo_doc	= p.tipo_doc
				AND		hpp.nro_doc		= p.nro_doc),
			NULL,   /* id_sistema_propietario		*/    
			NULL,   /* numero_paciente_sicap		*/     
			NULL,   /* numero_grupo_familiar_sicap	*/
			NULL,   /* historia_familiar_sicap		*/   
			NULL,   /* historia_personal_sicap		*/   
			hpp.s1hiscli,
			hpp.s3hisclice,
			NULL,	/* his_cli_sihos				*/
			NULL,	/* his_cli_sistema_propietario	*/
			NULL	/* nr0_hc_diagnose				*/
	FROM 	migra_hmi_personas.hmi_dg_pacientes_personas hpp
			
	WHERE 	
			es_documento(hpp.tipo_doc,hpp.nro_doc,hpp.fecha_nac) = 1
	AND		(hpp.s1hiscli IS NOT NULL
	OR		hpp.s3hisclice IS NOT NULL)
	AND		hpp.marca_diferente	=	FALSE
		
	ON DUPLICATE KEY UPDATE
	
		his_cli_internacion_hmi = hpp.s1hiscli,
		his_cli_ce_hmi 			= hpp.s3hisclice;
									
									
/* habilita los indices de la tabla hc_personas */
ALTER TABLE hc_personas ENABLE KEYS;

/* Actualiza en la tabla de diferencias el id_persona de la nueva persona para dicha historia clinica */
/* pero no modifica en la tabla hc_personas porque puede ser que se halla modificado el documento por */
/* error y dicha persona, ademas, tenga historias clinicas de otros sistemas o efectores, lo cual     */
/* se estaria modificando tambien dicha informacion. La metodologia seria que en cada efector se 	  */
/* verifique dicha info y despues se informe cual documento es el correcto.							  */
/* Aunque supuestamente la informacion de documento si ha cambiado es porque se verifico que estaba	  */
/* que en un estado anterior este dato era incorrecto, en el caso de la reutilizacion de un nro de	  */
/* historia clinica, una actualizacion sobre el id_persona en la tabla hc_personas haria que si la	  */
/* persona que antes tenia el nro de historia clinica en dicho efector y tenia tambien historias	  */
/* clinicas en otros efectores, se actualice otras historias clinicas, las cuales no deberian 		  */
/* actualizarse																						  */
UPDATE 	
		personas p, 
		hc_personas_hmi_diferentes hcd,
		migra_hmi_personas.hmi_dg_pacientes_personas hpp
	SET 
		hcd.id_persona_nuevo = p.id_persona
	WHERE 
		es_documento(hpp.tipo_doc,hpp.nro_doc,hpp.fecha_nac) = 1
	AND	hcd.tipo_doc_nuevo	=	p.tipo_doc
	AND	hcd.nro_doc_nuevo	=	p.nro_doc
	AND	hpp.tipo_doc		=	hcd.tipo_doc_nuevo
	AND	hpp.nro_doc			=	hcd.nro_doc_nuevo
	AND	hpp.marca_diferente	=	TRUE;
