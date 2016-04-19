/* ---------------------------------------------------------------------- */	
/* DIAGNOSE - carga los pacientes del diagnose a la base de personas      */
/* ---------------------------------------------------------------------- */

/* Si da el error de max_allowed_packet hacer:

	SET GLOBAL max_allowed_packet=256 * 1024 * 1024;
	
*/


/* !!!!!!!!!!!    ACTUALIZAR ID DE EFECTOR    !!!!!!!!!!!!!!!!! */

/* Hospital Cullen						->	id_efector = 71		*/
/* Hospital Iturraspe					->	id_efector = 72		*/
/* Inst. Vera Candiotti 				->	id_efector = 74		*/
/* Hospital Alassia						->	id_efector = 121	*/
/* Hospital Eva Peron   				->  id_efector = 167	*/
/* Hospital Centenario					->	id_efector = 183	*/
/* Hospital Provincial					->	id_efector = 184	*/
/* Hospital San Javier					->	id_efector = 251	*/
/* Hospital Agudo Avila					->	id_efector = 218	*/
/* Hospital Alcorta JJ Maiztegui		->	id_efector = 488	*/
/* SAMCo Arroyo Seco Gral San Martin	->	id_efector = 166	*/
/* Hospital Casilda San Carlos			->	id_efector = 434	*/
/* SAMCo Firmat - Gral San Martin 		->	id_efector = 522	*/
/* Hospital Reconquista					->	id_efector = 5		*/
/* SAMCo Roldan					 		->	id_efector = 311	*/
/* Hospital Cañada de Gomez - San Jose	->	id_efector = 38		*/
/* Hospital San Justo					->	id_efector = 292	*/
/* Hospital San Lorenzo					->	id_efector = 313	*/
/* SAMCo Totoras				 		->	id_efector = 45		*/
/* SAMCo Dr. Gutierrez - Venado Tuerto	->	id_efector = 536	*/

SET @id_efector := 74;








/* inserta en "origen_info" */
INSERT IGNORE INTO origen_info(id_origen_info, origen_info) VALUES (10,"DIAGNOSE");


/* marca en la tabla de migracion las personas NO fallecidas que ya esten en */
/* la tabla personas y SI esten fallecidas */
UPDATE personas p, migra_diagnose_personas.diagnose_paciente_personas dpp
	SET 	dpp.marca_borrado=TRUE
	WHERE	
			es_documento(dpp.tipo_doc,dpp.nro_doc,dpp.fecha_nac) = 1
	AND		p.nro_doc = dpp.nro_doc
	AND		p.fallecido IS TRUE
	AND		p.tipo_doc = dpp.tipo_doc;
				

				

	
/* ------------------------------------------- */			
/* Elimina las personas diferentes del efector */
DELETE FROM hc_personas_diagnose_diferentes
	WHERE id_efector = @id_efector;
	
/* Dehabilita los indices de personas diferentes */
ALTER TABLE hc_personas_diagnose_diferentes DISABLE KEYS;
	
/* Proceso para buscar tipo y numero de documentos cambiados entre migraciones anteriores y esta, */
/* a traves del numero de historia clinica */
INSERT INTO hc_personas_diagnose_diferentes
	SELECT 	hc.id_hc_persona,
			hc.id_efector,
			hc.id_persona,                       
			p.tipo_doc,
			p.nro_doc,
			p.apellido,
			p.nombre,
			p.fecha_nac,
			NULL,
			dpp.tipo_doc,
			dpp.nro_doc,
			dpp.apellido,
			dpp.nombre,
			dpp.fecha_nac,
			dpp.nr0_hc
			
		FROM
		
			hc_personas hc, 
			migra_diagnose_personas.diagnose_paciente_personas dpp, 
			personas p
			
		WHERE
		
			es_documento(dpp.tipo_doc,dpp.nro_doc,dpp.fecha_nac) = 1
		AND	dpp.nr0_hc		=	hc.nr0_hc_diagnose
		AND	hc.id_persona 	=	p.id_persona
		AND hc.id_efector 	=	@id_efector										
		AND	(dpp.tipo_doc 	<> p.tipo_doc
				OR	dpp.nro_doc	<> p.nro_doc);
		
			
/* Marca las personas diferentes en la tabla auxiliar de migracion */
UPDATE migra_diagnose_personas.diagnose_paciente_personas dpp, hc_personas_diagnose_diferentes hcd
	SET marca_diferente = TRUE
	WHERE	dpp.tipo_doc	= hcd.tipo_doc_nuevo
	AND		dpp.nro_doc		= hcd.nro_doc_nuevo;


/* habilita los indices de personas diferentes */
ALTER TABLE hc_personas_diagnose_diferentes ENABLE KEYS;

/* ----------- fin hc diferentes ------------- */





/* deshabilita los indices de la tabla personas */
ALTER TABLE hc_personas DISABLE KEYS;

INSERT INTO hc_personas
	SELECT	0,
			@id_efector,
			(SELECT id_persona
				FROM personas p
				WHERE	dpp.tipo_doc	= p.tipo_doc
				AND		dpp.nro_doc		= p.nro_doc),
			NULL,	/* id_sistema_propietario		*/
			NULL,	/* numero_paciente_sicap		*/
			NULL,	/* numero_grupo_familiar_sicap	*/
			NULL,	/* historia_familiar_sicap		*/
			NULL,	/* historia_personal_sicap		*/
			NULL,	/* his_cli_internacion_hmi		*/
			NULL,	/* his_cli_ce_hmi				*/
			NULL,	/* his_cli_sihos				*/
			NULL,	/* his_cli_sistema_propietario	*/
			dpp.nr0_hc
	FROM 	migra_diagnose_personas.diagnose_paciente_personas dpp
	WHERE 	
			es_documento(dpp.tipo_doc,dpp.nro_doc,dpp.fecha_nac) = 1
	AND		dpp.marca_borrado = 	TRUE
	AND		dpp.marca_diferente	=	FALSE
	
	ON DUPLICATE KEY UPDATE
	
		nr0_hc_diagnose = dpp.nr0_hc;
		
/* elimina de la tabla los que tienen marca de borrado */	
DELETE FROM migra_diagnose_personas.diagnose_paciente_personas
	WHERE	marca_borrado=TRUE;
	




/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;

INSERT INTO personas
	SELECT	0,
			dpp.id_localidad,
			dpp.tipo_doc,
			dpp.nro_doc,
			dpp.apellido,
			dpp.nombre,
			dpp.sexo,
			dpp.dom_calle,
			dpp.dom_nro,
			dpp.dom_dpto,
			dpp.dom_piso,
			dpp.dom_mza_monobloc,
			dpp.telefono_dom,
			dpp.telefono_cel,
			dpp.barrio,
			dpp.localidad,
			dpp.departamento,
			dpp.provincia,
			dpp.pais,
			dpp.fecha_nac,
			dpp.ocupacion,
			dpp.tipo_doc_madre,
			dpp.nro_doc_madre,
			dpp.nivel_academico,
			dpp.estado_civil,
			dpp.situacion_laboral,
			dpp.asociado,
			dpp.fallecido,
			dpp.fecha_ultima_cond,
			10,
			FALSE
	FROM	
			migra_diagnose_personas.diagnose_paciente_personas dpp
	
	WHERE
			es_documento(dpp.tipo_doc,dpp.nro_doc,dpp.fecha_nac) = 1
					
	ON DUPLICATE KEY UPDATE
	
		id_localidad	=	IFNULL(dpp.id_localidad,personas.id_localidad),
		apellido		=	dpp.apellido,
		nombre			=	dpp.nombre,
		sexo			=	dpp.sexo,
		dom_calle		=	IFNULL(dpp.dom_calle,personas.dom_calle),
		dom_nro			=	IFNULL(dpp.dom_nro,personas.dom_nro),
		dom_dpto		=	IFNULL(dpp.dom_dpto,personas.dom_dpto),
		dom_piso		=	IFNULL(dpp.dom_piso,personas.dom_piso),
		telefono_dom	=	IFNULL(dpp.telefono_dom,personas.telefono_dom),
		barrio			=	IFNULL(dpp.barrio,personas.barrio),
		localidad		=	IFNULL(dpp.localidad,personas.localidad),
		departamento	=	IFNULL(dpp.departamento,personas.departamento),
		provincia		=	IFNULL(dpp.provincia,personas.provincia),
		pais			=	IFNULL(dpp.pais,personas.pais),
		fecha_nac		=	IFNULL(dpp.fecha_nac,personas.fecha_nac),
		ocupacion		=	IFNULL(dpp.ocupacion,personas.ocupacion),
		tipo_doc_madre	=	IFNULL(dpp.tipo_doc_madre,personas.tipo_doc_madre),
		nro_doc_madre	=	IFNULL(dpp.nro_doc_madre,personas.nro_doc_madre),
		nivel_academico	=	IFNULL(dpp.nivel_academico,personas.nivel_academico),
		estado_civil	=	IFNULL(dpp.estado_civil,personas.estado_civil),
		situacion_laboral=	dpp.situacion_laboral,
		asociado		=	dpp.asociado,
		fallecido		=	dpp.fallecido,
		fecha_ultima_cond=	dpp.fecha_ultima_cond,
		id_origen_info	=	10;
		
/* habilita los indices de la tabla personas */
ALTER TABLE personas ENABLE KEYS;






/* Ingresa las pacientes que tienen documentos con inconsistencias */

/* Elimina los pacientes que tienen inconsistencias de documentos de la tabla correspondiente */
DELETE FROM personas_diagnose_docs_inconsistentes
	WHERE id_efector = @id_efector;
	
/* deshabilita los indices de la tabla personas */
ALTER TABLE personas_diagnose_docs_inconsistentes DISABLE KEYS;

INSERT INTO personas_diagnose_docs_inconsistentes
	SELECT	0,
			@id_efector,
			dpp.nr0_hc,
			dpp.id_localidad,
			dpp.tipo_doc,
			dpp.nro_doc,
			dpp.apellido,
			dpp.nombre,
			dpp.sexo,
			dpp.dom_calle,
			dpp.dom_nro,
			dpp.dom_dpto,
			dpp.dom_piso,
			dpp.dom_mza_monobloc,
			dpp.telefono_dom,
			dpp.telefono_cel,
			dpp.barrio,
			dpp.localidad,
			dpp.departamento,
			dpp.provincia,
			dpp.pais,
			dpp.fecha_nac,
			dpp.ocupacion,
			dpp.tipo_doc_madre,
			dpp.nro_doc_madre,
			dpp.nivel_academico,
			dpp.estado_civil,
			dpp.situacion_laboral,
			dpp.asociado,
			dpp.fallecido,
			dpp.fecha_ultima_cond,
			10,
			FALSE
	FROM	
			migra_diagnose_personas.diagnose_paciente_personas dpp
	
	WHERE
			es_documento(dpp.tipo_doc,dpp.nro_doc,dpp.fecha_nac) = 0
					
	ON DUPLICATE KEY UPDATE
	
		id_localidad	=	IFNULL(dpp.id_localidad,personas_diagnose_docs_inconsistentes.id_localidad),
		apellido		=	dpp.apellido,
		nombre			=	dpp.nombre,
		sexo			=	dpp.sexo,
		dom_calle		=	IFNULL(dpp.dom_calle,personas_diagnose_docs_inconsistentes.dom_calle),
		dom_nro			=	IFNULL(dpp.dom_nro,personas_diagnose_docs_inconsistentes.dom_nro),
		dom_dpto		=	IFNULL(dpp.dom_dpto,personas_diagnose_docs_inconsistentes.dom_dpto),
		dom_piso		=	IFNULL(dpp.dom_piso,personas_diagnose_docs_inconsistentes.dom_piso),
		telefono_dom	=	IFNULL(dpp.telefono_dom,personas_diagnose_docs_inconsistentes.telefono_dom),
		barrio			=	IFNULL(dpp.barrio,personas_diagnose_docs_inconsistentes.barrio),
		localidad		=	IFNULL(dpp.localidad,personas_diagnose_docs_inconsistentes.localidad),
		departamento	=	IFNULL(dpp.departamento,personas_diagnose_docs_inconsistentes.departamento),
		provincia		=	IFNULL(dpp.provincia,personas_diagnose_docs_inconsistentes.provincia),
		pais			=	IFNULL(dpp.pais,personas_diagnose_docs_inconsistentes.pais),
		fecha_nac		=	IFNULL(dpp.fecha_nac,personas_diagnose_docs_inconsistentes.fecha_nac),
		ocupacion		=	IFNULL(dpp.ocupacion,personas_diagnose_docs_inconsistentes.ocupacion),
		tipo_doc_madre	=	IFNULL(dpp.tipo_doc_madre,personas_diagnose_docs_inconsistentes.tipo_doc_madre),
		nro_doc_madre	=	IFNULL(dpp.nro_doc_madre,personas_diagnose_docs_inconsistentes.nro_doc_madre),
		nivel_academico	=	IFNULL(dpp.nivel_academico,personas_diagnose_docs_inconsistentes.nivel_academico),
		estado_civil	=	IFNULL(dpp.estado_civil,personas_diagnose_docs_inconsistentes.estado_civil),
		situacion_laboral=	dpp.situacion_laboral,
		asociado		=	dpp.asociado,
		fallecido		=	dpp.fallecido,
		fecha_ultima_cond=	dpp.fecha_ultima_cond,
		id_origen_info	=	10;
		
/* habilita los indices de la tabla personas */
ALTER TABLE personas_diagnose_docs_inconsistentes ENABLE KEYS;







/* Hospital Cullen		->	id_efector = 71		*/
/* Hospital Iturraspe	->	id_efector = 72		*/
/* Inst. Vera Candiotti ->	id_efector = 74		*/
/* Hospital Alassia		->	id_efector = 121	*/
/* Hospital Eva Peron   ->  id_efector = 167	*/
/* Hospital Centenario	->	id_efector = 183	*/
/* Hospital Provincial	->	id_efector = 184	*/
/* Hospital San Javier	->	id_efector = 251	*/

INSERT INTO hc_personas
	SELECT	0,
			@id_efector,
			(SELECT id_persona
				FROM personas p
				WHERE	dpp.tipo_doc	= p.tipo_doc
				AND		dpp.nro_doc		= p.nro_doc),
			NULL,	/* id_sistema_propietario		*/
			NULL,	/* numero_paciente_sicap		*/
			NULL,	/* numero_grupo_familiar_sicap	*/
			NULL,	/* historia_familiar_sicap		*/
			NULL,	/* historia_personal_sicap		*/
			NULL,	/* his_cli_internacion_hmi		*/
			NULL,	/* his_cli_ce_hmi				*/
			NULL,	/* his_cli_sihos				*/
			NULL,	/* his_cli_sistema_propietario	*/
			dpp.nr0_hc
	FROM 	
	
			migra_diagnose_personas.diagnose_paciente_personas dpp
			
	WHERE 	
	
			es_documento(dpp.tipo_doc,dpp.nro_doc,dpp.fecha_nac) = 1
	AND		dpp.marca_diferente	=	FALSE
		
	ON DUPLICATE KEY UPDATE
	
		nr0_hc_diagnose = dpp.nr0_hc;
		
/* Habilita los indices de la tabla hc_personas */
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
		hc_personas_diagnose_diferentes hcd,
		migra_diagnose_personas.diagnose_paciente_personas dpp
	SET 
		hcd.id_persona_nuevo = p.id_persona
	WHERE 
		hcd.tipo_doc_nuevo	=	p.tipo_doc
	AND	hcd.nro_doc_nuevo	=	p.nro_doc
	AND	dpp.tipo_doc		=	hcd.tipo_doc_nuevo
	AND	dpp.nro_doc			=	hcd.nro_doc_nuevo
	AND	dpp.marca_diferente	=	TRUE;
	
	
	

	
	
	
	
/* De acuerdo a las pruebas una sentencia de actualizacion de las historias clinicas no es realizable */
/* porque si para dicho efector el paciente tiene historia clinica de otro sistema que apunta al	  */
/* id_persona correcto y como en un proceso anterior de migracion de este script, se ingreso para	  */
/* dicha historia clinica un registro, que es el que quiero actualizar por el nuevo id_persona, se da */
/* el estado de que dicho paciente ya tiene registro en hc_personas. Esto es ya tiene hc de otro	  */
/* sistema y le quiero actualizar al registro que se ingreso por error en el tipo y nro de documento  */
/* en la tabla hc_personas, pero como ya existe un registro para el id_persona correcto, da un error  */
/* en el indice unico. Es por ello que la actualizacion de la informacion debe realizarse manualmente */
/* La sentencia de ejemplo es la que esta debajo */
/*UPDATE
		hc_personas hc,
		hc_personas_diagnose_diferentes hcd
	SET
		hc.id_persona = hcd.id_persona_nuevo
	WHERE
		hc.id_persona = hcd.id_persona_anterior;*/
			

		
		
/* Luego de actualizar las historias clinicas manualmente, puede ejecutarse la sentencia que esta	*/
/* debajo para dar de baja a las personas detectada con errores.									*/
/* NOTA: esta sentencia esta basada en el id_persona_anterior, notar que si por error este id		*/
/* no es el correcto, se estaria dando de baja a una persona que esta bien ingresada				*/		

/* Da de baja las personas que eran antes en los casos con diferencias */
/*UPDATE
		personas p, 
		hc_personas_diagnose_diferentes hcd
	SET
		p.baja = TRUE
	WHERE
		p.id_persona = hcd.id_persona_anterior;*/
		