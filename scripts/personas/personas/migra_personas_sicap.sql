/* ------------------------------------------ */	
/* SICAP - carga los pacientes del sicap      */
/* ------------------------------------------ */

/* inserta en "origen_info" */
INSERT IGNORE INTO origen_info(id_origen_info, origen_info) VALUES (2,"SICAP");
	
/* marca en la tabla de migracion del sicap las personas NO fallecidas que ya esten en */
/* la tabla personas y SI esten fallecidas */
UPDATE 
	personas p, 
	paciente_sicap ps
SET 	
	ps.marca_borrado=TRUE
WHERE	
	p.nro_doc = nrodocumento
AND	p.tipo_doc = codtipdocumento
AND	p.fallecido IS TRUE
AND	LEFT(ps.CodEstadoReg,1)='A'
AND	es_documento(
		ps.codtipdocumento,
		ps.nrodocumento,
		ps.fechanacimiento) = 1;
						
/* antes de borrar, guarda las historias clinicas de las personas */
/* con marca de borrado */
INSERT INTO hc_personas
	SELECT	0,
			(SELECT 
				id_efector
			FROM 
				efectores e
			WHERE 
				e.claveestd = hs.codestablecimiento),
			(SELECT 
				id_persona
			FROM 
				personas p, 
				paciente_sicap ps
			WHERE	
				p.tipo_doc 			=	ps.codtipdocumento
			AND	p.nro_doc 			=	ps.nrodocumento
			AND ps.numeropaciente	=	hs.numeropaciente
			AND ps.marca_borrado	=	TRUE
			LIMIT 
				0,1),
			NULL,					/* id_sistema_propietario		*/
			hs.numeropaciente,     	/* numero_paciente_sicap		*/
			hs.numerogrupofamiliar,	/* numero_grupo_familiar_sicap	*/
			hs.historiafamiliar,   	/* historia_familiar_sicap		*/
			hs.historiapersonal,   	/* historia_personal_sicap		*/
			NULL,					/* his_cli_internacion_hmi		*/
			NULL,					/* his_cli_ce_hmi				*/
			NULL,					/* his_cli_sihos				*/
			NULL,					/* his_cli_sistema_propietario	*/
			NULL					/* nr0_hc_diagnose				*/
			
	FROM 
		historiasclinicas_sicap hs, 
		paciente_sicap ps2
	
	WHERE	ps2.marca_borrado = TRUE
	AND		ps2.numeropaciente = hs.numeropaciente
	AND		es_documento(
				ps2.codtipdocumento,
				ps2.nrodocumento,
				ps2.fechanacimiento) = 1
	
	ON DUPLICATE KEY UPDATE
		
		numero_paciente_sicap		=	hs.numeropaciente,
		numero_grupo_familiar_sicap	=	hs.numerogrupofamiliar,
		historia_familiar_sicap		=	hs.historiafamiliar,
		historia_personal_sicap		=	hs.historiapersonal;

/* elimina de la tabla auxiliar los que tienen marca de borrado */	
DELETE FROM 
	paciente_sicap
WHERE	
	marca_borrado=TRUE;

/* elimina la tabla de inconsistencias de documentos del sicap */	
DROP TABLE IF EXISTS personas_sicap_docs_inconsistentes;
	
/* Tabla de personas_sicap_docs_inconsistentes */
CREATE TABLE personas_sicap_docs_inconsistentes (
	id_persona_sicap_doc_inconsistente		INTEGER 	UNSIGNED    			NOT NULL AUTO_INCREMENT,
	id_localidad							INTEGER 	UNSIGNED    			NULL 		COMMENT 'id_localidad de tabla localidades',
	tipo_doc								CHAR(3)		 		      			NOT NULL	COMMENT 'Se unifico a los tipo del HMI1 en formato texto: DNI, LC, LE, CI, OTR, DNR',
	nro_doc									INTEGER 	UNSIGNED    			NOT NULL	COMMENT 'Numero de documento en formato numerico',
	apellido								VARCHAR(255) 		     			NOT NULL,
	nombre									VARCHAR(255) 		     			NOT NULL,
	sexo									CHAR(1) 			        		NOT NULL	COMMENT 'F, M o I',
	dom_calle								VARCHAR(255) 		     			NULL		COMMENT 'Nombre de la calle o calle y numero en los casos donde no se pueda separar',
	dom_nro									VARCHAR(20) 		      			NULL,
	dom_dpto								CHAR(3) 			        		NULL,
	dom_piso								VARCHAR(5) 			      			NULL,
	dom_mza_monobloc						VARCHAR(40) 		      			NULL,
	telefono_dom							VARCHAR(30) 		      			NULL		COMMENT 'Telefono del domicilio o el unico que se obtenga',
	telefono_cel							VARCHAR(30) 		      			NULL		COMMENT 'Telefono celular en caso de obtenerlo',
	barrio									VARCHAR(255) 		     			NULL,
	localidad								VARCHAR(255) 		     			NULL		COMMENT 'Descripcion de la localidad obtenida. Si se pudo identificar id_localidad, es la descripcion correspondiente a dicho id en la tabla localidades',
	departamento							VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	provincia								VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	pais									VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	fecha_nac								DATE 				        		NULL,
	ocupacion								VARCHAR(255) 		     			NULL,
	tipo_doc_madre							CHAR(3)		 		      			NULL,
	nro_doc_madre							INTEGER 	UNSIGNED    			NULL,
	nivel_academico							VARCHAR(255) 		     			NULL,
	estado_civil							VARCHAR(25) 		      			NULL,
	situacion_laboral						VARCHAR(255) 		     			NULL,
	asociado								VARCHAR(50) 		      			NULL,
	fallecido								TINYINT(1) 			      			NOT NULL,
	fecha_ultima_cond						DATE 				        		NULL,
	id_origen_info							TINYINT(3) 	UNSIGNED 				NOT NULL,
	baja									TINYINT(1) 			      			NOT NULL,
	PRIMARY KEY (id_persona_sicap_doc_inconsistente),
	KEY fk_id_localidad (id_localidad),
	KEY fk_id_origen_info (id_origen_info),
	KEY idx_nro_doc (nro_doc),
	KEY idx_apellido (apellido),
	KEY idx_nombre (nombre),
	KEY idx_fecha_nac (fecha_nac),
	KEY idx_fallecido (fallecido),
	KEY idx_fecha_ultima_cond (fecha_ultima_cond)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;		

/* deshabilita los indices de la tabla personas_sicap_docs_inconsistentes */
ALTER TABLE personas_sicap_docs_inconsistentes DISABLE KEYS;


/* ingresa en la tabla de documentos inconsistentes de sicap */
INSERT INTO

	personas_sicap_docs_inconsistentes
	
	SELECT
		
		/* id_persona_sicap_doc_inconsistente */
		0,
		/* id_localidad */
		(SELECT id_localidad 
			FROM localidades l,departamentos d 
				WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
				AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
				AND		l.id_dpto	= d.id_dpto),
		/* tipo_doc */
		ps.codtipdocumento,
		/* nro_doc */
		ps.nrodocumento,
		/* apellido */
		ps.apellido,
		/* nombre */
		ps.nombre,
		/* sexo */
		CASE ps.codsexo
			WHEN '1' THEN 'F'
			WHEN '2' THEN 'M'
			WHEN '3' THEN 'I'
			ELSE 'I'
    	END,
    	/* dom_calle */
		ps.calle,
		/* dom_nro */
		ps.numero,
		/* dom_dpto */
		IF (ps.depto='',NULL,ps.depto),
		/* dom_piso */
		IF (ps.piso='',NULL,ps.piso),
		/* dom_mza_monobloc */
		IF (ps.manzana='',NULL,ps.manzana),
		/* telefono_dom */
		NULL,
		/* telefono_cel */
		ps.telefono,
		/* barrio */
		NULL,
		/* localidad */
		(SELECT nom_loc 
			FROM localidades l,departamentos d 
				WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
				AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
				AND		l.id_dpto	= d.id_dpto),
		/* departamento */
		(SELECT nom_dpto 
			FROM localidades l,departamentos d 
				WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
				AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
				AND		l.id_dpto	= d.id_dpto),
		/* provincia */
		(SELECT nom_prov 
			FROM localidades l,departamentos d, provincias p
				WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
				AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
				AND		l.id_dpto	= d.id_dpto
				AND		p.id_prov	= d.id_prov),
		/* pais */
		(SELECT nom_pais 
			FROM localidades l,departamentos d, provincias p, paises pa
				WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
				AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
				AND		l.id_dpto	= d.id_dpto
				AND		p.id_prov	= d.id_prov
				AND		p.id_pais	= pa.id_pais),
		/* fecha_nac */
		fechanacimiento,
		/* ocupacion */
		(SELECT descripocupacion
			FROM ocupacion_sicap os
			WHERE os.codocupacion=ps.codocupacion),
		/* tipo_doc_madre */
		NULL,
		/* nro_doc_madre */
		NULL,
		/* nivel_academico */
		(SELECT descripniveleduc 
			FROM niveleducacion_sicap ne
			WHERE ne.codniveleduc=ps.codniveleduc),
		/* estado_civil */
		descripestciv, 
		/* situacion_laboral */
		NULL,
		/* asociado */
		IF (seguro='S' AND obra='S',(SELECT desc_asociado
										FROM asociado_hmi a
										WHERE a.id_asociado=4),
			IF (seguro='N' AND obra='N',(SELECT desc_asociado
											FROM asociado_hmi a
											WHERE a.id_asociado=5),
				IF (seguro='S' AND obra='N',(SELECT desc_asociado
													FROM asociado_hmi a
													WHERE a.id_asociado=3),(SELECT desc_asociado
													FROM asociado_hmi a
													WHERE a.id_asociado=1))
				)
			),
		/* fallecido */
		IF (LEFT(ps.codestadoreg,1)='F',TRUE,FALSE),
		/* fecha_ultima_cond */
		NULL,
		/* id_origen_info */
		2,
		/* baja */
		FALSE
		
FROM 
	paciente_sicap ps
WHERE	
	es_documento(
				ps.codtipdocumento,
				ps.nrodocumento,
				ps.fechanacimiento) = 0
AND		(ps.clasedocumento='P' OR ps.clasedocumento='')
AND		LEFT(ps.codestadoreg,1)<>'B';

/* habilita los indices de la tabla de documentos inconsistentes */
ALTER TABLE personas_sicap_docs_inconsistentes ENABLE KEYS;


/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;

INSERT INTO personas
	SELECT 0,
			(SELECT id_localidad 
				FROM localidades l,departamentos d 
					WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
					AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
					AND		l.id_dpto	= d.id_dpto),
			codtipdocumento,
			nrodocumento,
			ps.apellido,
			ps.nombre,
			CASE ps.codsexo
				WHEN '1' THEN 'F'
				WHEN '2' THEN 'M'
				WHEN '3' THEN 'I'
				ELSE 'I'
        	END,
			ps.calle,
			ps.numero,
			IF (ps.depto='',NULL,ps.depto),
			IF (ps.piso='',NULL,ps.piso),
			IF (ps.manzana='',NULL,ps.manzana),
			NULL,
			ps.telefono,
			NULL,
			(SELECT nom_loc 
				FROM localidades l,departamentos d 
					WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
					AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
					AND		l.id_dpto	= d.id_dpto),
			(SELECT nom_dpto 
				FROM localidades l,departamentos d 
					WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
					AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
					AND		l.id_dpto	= d.id_dpto),
			(SELECT nom_prov 
				FROM localidades l,departamentos d, provincias p
					WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
					AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
					AND		l.id_dpto	= d.id_dpto
					AND		p.id_prov	= d.id_prov),
			(SELECT nom_pais 
				FROM localidades l,departamentos d, provincias p, paises pa
					WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
					AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
					AND		l.id_dpto	= d.id_dpto
					AND		p.id_prov	= d.id_prov
					AND		p.id_pais	= pa.id_pais),
			fechanacimiento,
			(SELECT descripocupacion
				FROM ocupacion_sicap os
				WHERE os.codocupacion=ps.codocupacion),
			NULL,
			NULL,
			(SELECT descripniveleduc 
				FROM niveleducacion_sicap ne
				WHERE ne.codniveleduc=ps.codniveleduc),
			descripestciv, 
			NULL,
			IF (seguro='S' AND obra='S',(SELECT desc_asociado
											FROM asociado_hmi a
											WHERE a.id_asociado=4),
				IF (seguro='N' AND obra='N',(SELECT desc_asociado
												FROM asociado_hmi a
												WHERE a.id_asociado=5),
					IF (seguro='S' AND obra='N',(SELECT desc_asociado
														FROM asociado_hmi a
														WHERE a.id_asociado=3),(SELECT desc_asociado
														FROM asociado_hmi a
														WHERE a.id_asociado=1))
					)
				),
			IF (LEFT(ps.codestadoreg,1)='F',TRUE,FALSE),
			NULL,
			2,
			FALSE
			
	FROM 
		paciente_sicap ps
	WHERE	
		es_documento(
			ps.codtipdocumento,
			ps.nrodocumento,
			ps.fechanacimiento) = 1
	AND	(ps.clasedocumento='P' OR ps.clasedocumento='')
	AND	LEFT(ps.codestadoreg,1)<>'B'
	
	ON DUPLICATE KEY UPDATE
	
		id_localidad =
			IFNULL(
				(SELECT id_localidad 
					FROM localidades l,departamentos d 
						WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
						AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
						AND		l.id_dpto	= d.id_dpto),
					personas.id_localidad),
		apellido 	=					
			ps.apellido,
		nombre 		= 
			ps.nombre,
		sexo 		=
			(CASE codsexo
				WHEN '1' THEN 'F'
				WHEN '2' THEN 'M'
				WHEN '3' THEN personas.sexo
				ELSE	personas.sexo
        	END),
        dom_calle	=
			ps.calle,
		dom_nro		=
			ps.numero,
		dom_dpto	=
			IF (depto='',NULL,depto),
		dom_piso	=
			IF (piso='',NULL,piso),
		dom_mza_monobloc =
			IF (manzana='',NULL,manzana),
			
		telefono_cel=	
			IFNULL(
				telefono,personas.telefono_cel),
			
		localidad =
			IFNULL(
				(SELECT nom_loc 
					FROM localidades l,departamentos d 
						WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
						AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
						AND		l.id_dpto	= d.id_dpto),
					personas.localidad),
					
		departamento =
			IFNULL(
				(SELECT nom_dpto 
					FROM localidades l,departamentos d 
						WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
						AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
						AND		l.id_dpto	= d.id_dpto),
					personas.departamento),
		provincia	=
			IFNULL(
				(SELECT nom_prov 
					FROM localidades l,departamentos d, provincias p
						WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
						AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
						AND		l.id_dpto	= d.id_dpto
						AND		p.id_prov	= d.id_prov),
					personas.provincia),
		pais		=
			IFNULL(
				(SELECT nom_pais 
					FROM localidades l,departamentos d, provincias p, paises pa
						WHERE	l.cod_loc	= RIGHT(ps.clavelocalidad,2)
						AND		d.cod_dpto	= LEFT(ps.clavelocalidad,3)
						AND		l.id_dpto	= d.id_dpto
						AND		p.id_prov	= d.id_prov
						AND		p.id_pais	= pa.id_pais),
					personas.pais),
		fecha_nac	=
			IFNULL(
				fechanacimiento,personas.fecha_nac),
		ocupacion	=
			(SELECT descripocupacion
				FROM ocupacion_sicap os
				WHERE os.codocupacion=ps.codocupacion),
		nivel_academico =
			(SELECT descripniveleduc 
				FROM niveleducacion_sicap ne
				WHERE ne.codniveleduc=ps.codniveleduc),
		estado_civil =
			descripestciv,
		asociado =
			IF (seguro='S' AND obra='S',(SELECT desc_asociado
											FROM asociado_hmi a
											WHERE a.id_asociado=4),
				IF (seguro='N' AND obra='N',(SELECT desc_asociado
												FROM asociado_hmi a
												WHERE a.id_asociado=5),
					IF (seguro='S' AND obra='N',(SELECT desc_asociado
														FROM asociado_hmi a
														WHERE a.id_asociado=3),(SELECT desc_asociado
														FROM asociado_hmi a
														WHERE a.id_asociado=1))
					)
				),
		fallecido =	IF (LEFT(ps.codestadoreg,1)='F',TRUE,FALSE),
		fecha_ultima_cond =	NULL,
		id_origen_info =	2	;
	
/* habilita los indices para la tabla personas*/	
ALTER TABLE personas ENABLE KEYS;


/* Deshabilita los indices de historias clinicas de personas*/
ALTER TABLE hc_personas DISABLE KEYS;

/* inserta las historias clinicas de los pacientes del sicap */
INSERT INTO hc_personas
	SELECT	
		0,
		(SELECT id_efector
			FROM efectores e
			WHERE e.claveestd = hs.codestablecimiento) 
		,
		(SELECT 
			id_persona
		FROM 
			personas p, 
			paciente_sicap ps
		WHERE	ps.codtipdocumento	= p.tipo_doc
		AND		ps.nrodocumento		= p.nro_doc
		AND		ps.numeropaciente	= hs.numeropaciente
		LIMIT 0,1
		),
		NULL,					/* id_sistema_propietario		*/
		hs.numeropaciente,     	/* numero_paciente_sicap		*/
		hs.numerogrupofamiliar,	/* numero_grupo_familiar_sicap	*/
		hs.historiafamiliar,   	/* historia_familiar_sicap		*/
		hs.historiapersonal,   	/* historia_personal_sicap		*/
		NULL,					/* his_cli_internacion_hmi		*/
		NULL,					/* his_cli_ce_hmi				*/
		NULL,					/* his_cli_sihos				*/
		NULL,					/* his_cli_sistema_propietario	*/
		NULL					/* nr0_hc_diagnose				*/
			
	FROM 
		historiasclinicas_sicap hs, 
		paciente_sicap ps2
	
	WHERE	
		ps2.numeropaciente = hs.numeropaciente
	AND	es_documento(
			ps2.codtipdocumento,
			ps2.nrodocumento,
			ps2.fechanacimiento) = 1
	AND	(ps2.clasedocumento='P' OR ps2.clasedocumento='')
	AND	LEFT(ps2.codestadoreg,1)<>'B'
	
	ON DUPLICATE KEY UPDATE 
	
		numero_paciente_sicap 		= 	hs.numeropaciente,
		numero_grupo_familiar_sicap = 	hs.numerogrupofamiliar,
		historia_familiar_sicap 	= 	hs.historiafamiliar,
		historia_personal_sicap 	= 	hs.historiapersonal;
		
/* habilita los indices en historia clinicas de personas */
ALTER TABLE hc_personas ENABLE KEYS;
