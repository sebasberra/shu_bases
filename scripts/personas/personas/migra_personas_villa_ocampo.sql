/* ------------------------------------------------------------------------------------------------------------ */
/* SAMCO Villa Ocampo - carga las personas del SAMCO Villa Ocampo (utiliza la misma estructura que Reconquista) */
/* ------------------------------------------------------------------------------------------------------------ */

/* inserta en "origen_info" */
INSERT IGNORE INTO origen_info(id_origen_info, origen_info) VALUES (17,"SAMCO VILLA OCAMPO");

/* inserta en "sistemas_propietarios" */
INSERT IGNORE INTO sistemas_propietarios
		(id_sistema_propietario, nom_corto, nom_largo, observacion) 
	VALUES 
		(10,
		'SAMCO VILLA OCAMPO',
		'SAMCO VILLA OCAMPO',
		'Migración de los pacientes del sistema de Villa Ocampo 24/10/2012');
	
/* marca en la tabla de migracion del hospital reconquista las personas NO fallecidas que ya esten en */
/* la tabla personas y SI esten fallecidas */
UPDATE personas p, archivos_villa_ocampo ar
	SET ar.marca_borrado=TRUE
	WHERE	p.nro_doc = ar.arc_nro_do
	AND		p.fallecido IS TRUE
	AND		RIGHT(ar.arc_nombre,6)<>'-OBITO'
	AND		ar.arc_tipo_d = p.tipo_doc;
			
/* antes de borrar, guarda las historias clinicas de las personas */
/* con marca de borrado */
INSERT INTO hc_personas
	SELECT	0,
			8,
			(SELECT id_persona
				FROM personas p
				WHERE	ar.arc_tipo_d	= p.tipo_doc
				AND		ar.arc_nro_do	= p.nro_doc
			),
			10,				/* id_sistema_propietario		*/
			NULL,			/* numero_paciente_sicap		*/
			NULL,			/* numero_grupo_familiar_sicap	*/
			NULL,			/* historia_familiar_sicap		*/
			NULL,			/* historia_personal_sicap		*/
			NULL,			/* his_cli_internacion_hmi		*/
			NULL,			/* his_cli_ce_hmi				*/
			NULL,			/* his_cli_sihos				*/
			ar.arc_nro_hi,	/* his_cli_sistema_propietario	*/
			NULL			/* nr0_hc_diagnose				*/
	FROM archivos_villa_ocampo ar
		
	WHERE 	
			ar.marca_borrado=TRUE
	AND		es_documento(ar.arc_tipo_d, ar.arc_nro_do, ar.arc_fec_na) = 1
	
	ON DUPLICATE KEY UPDATE
		
		his_cli_sistema_propietario = ar.arc_nro_hi;

/* elimina de la tabla de hmi cruda los que tienen marca de borrado */	
DELETE FROM archivos_villa_ocampo
	WHERE	marca_borrado=TRUE;			
								
/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;

INSERT INTO personas
	SELECT 0,
			IF (RIGHT(ar.arc_ciudad,2)='99' AND RIGHT(ar.arc_depto,3)='999',
				NULL,
				(SELECT id_localidad 
					FROM localidades l 
						WHERE	l.cod_loc	= RIGHT(ar.arc_ciudad,2)
						AND		l.cod_dpto	= RIGHT(ar.arc_depto,3))
			),
			ar.arc_tipo_d,
			ar.arc_nro_do,
			IF(	RIGHT(arc_nombre,6)='-OBITO',
				str_separa_ape(LEFT(ar.arc_nombre,LENGTH(ar.arc_nombre)-6),TRUE),
				str_separa_ape(ar.arc_nombre,TRUE)
			),
			IF(	RIGHT(arc_nombre,6)='-OBITO',
				str_separa_ape(LEFT(ar.arc_nombre,LENGTH(ar.arc_nombre)-6),FALSE),
				str_separa_ape(ar.arc_nombre,FALSE)
			),
			CASE ar.arc_sexo
				WHEN 'M' THEN 'M'
				WHEN 'F' THEN 'F'
				ELSE 'I'
        	END,
			ar.arc_domi,
			NULL,
			NULL,
			NULL,
			NULL,
			ar.arc_te,
			NULL,
			(SELECT Bar_nombre
				FROM	barrios_villa_ocampo br
				WHERE	br.Bar_codigo = ar.arc_barrio
			),
			IF (RIGHT(ar.arc_ciudad,2)='99' AND RIGHT(ar.arc_depto,3)='999',
				NULL,
				(SELECT nom_loc 
					FROM localidades l 
						WHERE	l.cod_loc	= RIGHT(ar.arc_ciudad,2)
						AND		l.cod_dpto	= RIGHT(ar.arc_depto,3))
			),
			IF (RIGHT(ar.arc_ciudad,2)='99' AND RIGHT(ar.arc_depto,3)='999',
				NULL,
				(SELECT nom_dpto 
					FROM localidades l, departamentos d 
						WHERE	l.cod_loc	= RIGHT(ar.arc_ciudad,2)
						AND		l.cod_dpto	= RIGHT(ar.arc_depto,3)
						AND		l.id_dpto	= d.id_dpto)
			),
			IF (RIGHT(ar.arc_ciudad,2)='99' AND RIGHT(ar.arc_depto,3)='999',
				NULL,
				(SELECT nom_prov 
					FROM localidades l, departamentos d, provincias p 
						WHERE	l.cod_loc	= RIGHT(ar.arc_ciudad,2)
						AND		l.cod_dpto	= RIGHT(ar.arc_depto,3)
						AND		l.id_dpto	= d.id_dpto
						AND		p.id_prov	= d.id_prov)
			),
			IF (RIGHT(ar.arc_ciudad,2)='99' AND RIGHT(ar.arc_depto,3)='999',
				NULL,
				(SELECT nom_pais 
					FROM localidades l, departamentos d, provincias p, paises pa 
						WHERE	l.cod_loc	= RIGHT(ar.arc_ciudad,2)
						AND		l.cod_dpto	= RIGHT(ar.arc_depto,3)
						AND		l.id_dpto	= d.id_dpto
						AND		p.id_prov	= d.id_prov
						AND		p.id_pais	= pa.id_pais)
			),
			ar.arc_fec_na,
			ar.arc_ocup_h,
			ar.arc_tip_ma,
			IF(ar.arc_doc_ma IS NULL,NULL,ar.arc_doc_ma),
			IF(ar.arc_niv_in='0',
				NULL,
				(SELECT desc_instruccion
					FROM instruccion_hmi 
					WHERE	id_instruccion	=	CONVERT (ar.arc_niv_in,UNSIGNED)
				)
			),
			NULL,
			(SELECT sl.desc_sit_lab 
				FROM situacion_laboral_hmi sl
				WHERE	sl.id_sit_lab = ar.arc_sit_la),
			(SELECT aso.desc_asociado
				FROM asociado_hmi aso
				WHERE aso.id_asociado = ar.arc_asoc_a),
			IF(RIGHT(arc_nombre,6)='-OBITO',TRUE,FALSE),
			IF(	ar.arc_entreg=0,
				NULL,
				DATE_ADD('1800-12-28',INTERVAL ar.arc_entreg DAY)
			),
			17,
			FALSE
			
	FROM archivos_villa_ocampo ar
	WHERE
		es_documento(ar.arc_tipo_d, ar.arc_nro_do, ar.arc_fec_na) = 1
			
	ON DUPLICATE KEY UPDATE
		
		id_localidad = 
			IF (RIGHT(ar.arc_ciudad,2)='99' AND RIGHT(ar.arc_depto,3)='999',
				NULL,
				(SELECT id_localidad 
					FROM localidades l 
						WHERE	l.cod_loc	= RIGHT(ar.arc_ciudad,2)
						AND		l.cod_dpto	= RIGHT(ar.arc_depto,3))
			),
		
		apellido =
			IF(	RIGHT(arc_nombre,6)='-OBITO',
				str_separa_ape(LEFT(ar.arc_nombre,LENGTH(ar.arc_nombre)-6),TRUE),
				str_separa_ape(ar.arc_nombre,TRUE)
			),
			
		nombre =
			IF(	RIGHT(arc_nombre,6)='-OBITO',
				str_separa_ape(LEFT(ar.arc_nombre,LENGTH(ar.arc_nombre)-6),FALSE),
				str_separa_ape(ar.arc_nombre,FALSE)
			),
			
		sexo =
			CASE ar.arc_sexo
				WHEN 'M' THEN 'M'
				WHEN 'F' THEN 'F'
				ELSE 'I'
        	END,
        	
        dom_calle =	ar.arc_domi,
        
		telefono_dom = ar.arc_te,
		
		barrio =
			(SELECT Bar_nombre
				FROM	barrios_villa_ocampo br
				WHERE	br.Bar_codigo = ar.arc_barrio
			),
			
		localidad =	
			IF (RIGHT(ar.arc_ciudad,2)='99' AND RIGHT(ar.arc_depto,3)='999',
				NULL,
				(SELECT nom_loc 
					FROM localidades l 
						WHERE	l.cod_loc	= RIGHT(ar.arc_ciudad,2)
						AND		l.cod_dpto	= RIGHT(ar.arc_depto,3))
			),
			
		departamento =
			IF (RIGHT(ar.arc_ciudad,2)='99' AND RIGHT(ar.arc_depto,3)='999',
				NULL,
				(SELECT nom_dpto 
					FROM localidades l, departamentos d 
						WHERE	l.cod_loc	= RIGHT(ar.arc_ciudad,2)
						AND		l.cod_dpto	= RIGHT(ar.arc_depto,3)
						AND		l.id_dpto	= d.id_dpto)
			),
		
		provincia =
			IF (RIGHT(ar.arc_ciudad,2)='99' AND RIGHT(ar.arc_depto,3)='999',
				NULL,
				(SELECT nom_prov 
					FROM localidades l, departamentos d, provincias p 
						WHERE	l.cod_loc	= RIGHT(ar.arc_ciudad,2)
						AND		l.cod_dpto	= RIGHT(ar.arc_depto,3)
						AND		l.id_dpto	= d.id_dpto
						AND		p.id_prov	= d.id_prov)
			),
					
		pais =
			IF (RIGHT(ar.arc_ciudad,2)='99' AND RIGHT(ar.arc_depto,3)='999',
				NULL,
				(SELECT nom_pais 
					FROM localidades l, departamentos d, provincias p, paises pa 
						WHERE	l.cod_loc	= RIGHT(ar.arc_ciudad,2)
						AND		l.cod_dpto	= RIGHT(ar.arc_depto,3)
						AND		l.id_dpto	= d.id_dpto
						AND		p.id_prov	= d.id_prov
						AND		p.id_pais	= pa.id_pais)
			),
					
		fecha_nac =	ar.arc_fec_na,
			
		ocupacion =	ar.arc_ocup_h,
		
		tipo_doc_madre = IF (ar.arc_tip_ma IS NOT NULL,ar.arc_tip_ma,personas.tipo_doc_madre),
		
		nro_doc_madre =	IF(ar.arc_doc_ma IS NULL,NULL,ar.arc_doc_ma),
		
		nivel_academico =
			IF(ar.arc_niv_in='0',
				NULL,
				(SELECT desc_instruccion
					FROM instruccion_hmi 
					WHERE	id_instruccion	=	CONVERT (ar.arc_niv_in,UNSIGNED)
				)
			),
			
		situacion_laboral =
			(SELECT sl.desc_sit_lab 
				FROM situacion_laboral_hmi sl
				WHERE	sl.id_sit_lab = ar.arc_sit_la),
				
		asociado =
			(SELECT aso.desc_asociado
				FROM asociado_hmi aso
				WHERE aso.id_asociado = ar.arc_asoc_a),
				
		fallecido = IF(RIGHT(arc_nombre,6)='-OBITO',TRUE,FALSE),
		
		fecha_ultima_cond =	
			IF(	ar.arc_entreg=0,
				NULL,
				DATE_ADD('1800-12-28',INTERVAL ar.arc_entreg DAY)
			),
			
		id_origen_info = 17
	;	
	
/* habilita los indices para la tabla personas */	
ALTER TABLE personas ENABLE KEYS;


/* Deshabilita los indices de historias clinicas de personas */
ALTER TABLE hc_personas DISABLE KEYS;


/* inserta las historias clinicas de los pacientes del sihos */ 
INSERT INTO hc_personas
	SELECT	0,
			8,
			(SELECT id_persona
				FROM personas p
				WHERE	ar.arc_tipo_d	= p.tipo_doc
				AND		ar.arc_nro_do	= p.nro_doc
			),
			10,		/* id_sistema_propietario		*/
			NULL,	/* numero_paciente_sicap		*/
			NULL,	/* numero_grupo_familiar_sicap	*/
			NULL,	/* historia_familiar_sicap		*/
			NULL,	/* historia_personal_sicap		*/
			NULL,	/* his_cli_internacion_hmi		*/
			NULL,	/* his_cli_ce_hmi				*/
			NULL,	/* his_cli_sihos				*/
			ar.arc_nro_hi,	/* his_cli_sistema_propietario	*/
			NULL	/* nr0_hc_diagnose				*/
	FROM archivos_villa_ocampo ar
	WHERE	
		es_documento(ar.arc_tipo_d, ar.arc_nro_do, ar.arc_fec_na) = 1
	ON DUPLICATE KEY UPDATE 
		his_cli_sistema_propietario = ar.arc_nro_hi;
		
/* habilita los indices en historia clinicas de personas */
ALTER TABLE hc_personas ENABLE KEYS;