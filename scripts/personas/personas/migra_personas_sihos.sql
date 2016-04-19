/* ------------------------------------ */
/* SiHos - carga las personas del Sihos */
/* ------------------------------------ */

/* marca en la tabla de migracion del sihos las personas NO fallecidas que ya esten en */
/* la tabla personas y SI esten fallecidas */
UPDATE personas p, ihegresos_sihos ihe
	SET ihe.marca_borrado=TRUE
	WHERE	p.nro_doc = ihe.IHEGR_NRODOCUM 
	AND		p.fallecido IS TRUE
	AND		ihe.IHEGR_EGRPOR<>'5'
	AND		(	(p.tipo_doc = 'DNR' AND ihe.IHEGR_TIPODOCUM=9)
			OR	(p.tipo_doc = 'DNI' AND ihe.IHEGR_TIPODOCUM=1)
			OR	(p.tipo_doc = 'LC'	AND ihe.IHEGR_TIPODOCUM=2)
			OR	(p.tipo_doc = 'LE'	AND ihe.IHEGR_TIPODOCUM=3)
			OR	(p.tipo_doc = 'CI'	AND ihe.IHEGR_TIPODOCUM=4)
			OR	(p.tipo_doc = 'OTR'	AND ihe.IHEGR_TIPODOCUM=5)
			);
			
/* antes de borrar, guarda las historias clinicas de las personas */
/* con marca de borrado */
INSERT INTO hc_personas
	SELECT	0,
			(SELECT id_efector
				FROM efectores e
				WHERE e.claveestd = CONCAT(ihe.IHEGR_CODDPTO,ihe.IHEGR_CODEST) 
			),
			(SELECT id_persona
				FROM personas p
				WHERE	(CASE ihe.IHEGR_TIPODOCUM
							WHEN '9' THEN 'DNR'
							WHEN '1' THEN 'DNI'
							WHEN '2' THEN 'LC'
							WHEN '3' THEN 'LE'
							WHEN '4' THEN 'CI'
							WHEN '5' THEN 'OTR'
							ELSE 'DNR'
						END)				= p.tipo_doc
				AND		ihe.IHEGR_NRODOCUM	= p.nro_doc
			),
			NULL, /* id_sistema_propietario */
			NULL, /* numero_paciente_sicap	*/
			NULL, /* numero_grupo_familiar_sicap */
			NULL, /* historia_familiar_sicap */
			NULL, /* historia_personal_sicap */
			NULL, /* his_cli_internacion_hmi */
			NULL, /* his_cli_ce_hmi			*/
			ihe.IHEGR_NROHISCLI,
			NULL, /* his_cli_sistema_propietario */
			NULL  /* nr0_hc_diagnose		*/
			
	FROM 
			ihegresos_sihos ihe
	
	WHERE 	
			ihe.marca_borrado=TRUE
	
	ON DUPLICATE KEY UPDATE
	
		his_cli_sihos = ihe.IHEGR_NROHISCLI;

/* elimina de la tabla de hmi cruda los que tienen marca de borrado */	
DELETE FROM ihegresos_sihos
	WHERE	marca_borrado=TRUE;
	
						
/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;

INSERT INTO personas
	SELECT 
		
		/* id_persona */
		0,
		
		/* id_localidad */
		IF (
			ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
			NULL,
			(SELECT 
				l.id_localidad 
			FROM 
				localidades l 
			WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
			AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB
			)
		),
		
		/* tipo_doc */
		(CASE ihe.IHEGR_TIPODOCUM
			WHEN '1' THEN 'DNI'
			WHEN '2' THEN 'LC'
			WHEN '3' THEN 'LE'
			WHEN '4' THEN 'CI'
			WHEN '5' THEN 'OTR'
			WHEN '9' THEN 'DNR'
			ELSE 'DNR'
		END),
		
		/* nro_doc */
		ihe.IHEGR_NRODOCUM,
		
		/* apellido */
		ihe.IHEGR_APELLIDO,
		
		/* nombre */
		ihe.IHEGR_NOMBRE,
		
		/* sexo */
		(CASE ihe.IHEGR_SEXO
			WHEN '1' THEN 'M'
			WHEN '2' THEN 'F'
			ELSE 'I'
    	END),
    	
    	/* dom_calle */
		ihe.IHEGR_DIRECCION,
		
		/* dom_nro */
		ihe.IHEGR_DIRNRO,
		
		/* dom_dpto */
		ihe.IHEGR_DEP,
		
		/* dom_piso */
		ihe.IHEGR_PISO,
		
		/* dom_mza_monobloc */
		NULL,
		
		/* telefono_dom */
		ihe.IHEGR_TELEFONO,
		
		/* telefono_cel */
		NULL,
		
		/* barrio */
		ihe.IHEGR_BARRIO,
		
		/* localidad */
		IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
			NULL,
			(SELECT nom_loc 
				FROM localidades l 
					WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
					AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB)
		),
		
		/* departamento */
		IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
			NULL,
			(SELECT nom_dpto 
				FROM localidades l, departamentos d 
					WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
					AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB
					AND		l.id_dpto	= d.id_dpto)
		),
		
		/* provincia */
		IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
			NULL,
			(SELECT nom_prov 
				FROM localidades l, departamentos d, provincias p 
					WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
					AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB
					AND		l.id_dpto	= d.id_dpto
					AND		p.id_prov	= d.id_prov)
		),
		
		/* pais */
		IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
			NULL,
			(SELECT nom_pais 
				FROM localidades l, departamentos d, provincias p, paises pa 
					WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
					AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB
					AND		l.id_dpto	= d.id_dpto
					AND		p.id_prov	= d.id_prov
					AND		p.id_pais	= pa.id_pais)
		),
		
		/* fecha_nac */
		IF(TRIM(ihe.IHEGR_FECHANAC)='',NULL,
			CONCAT(
				RIGHT(ihe.IHEGR_FECHANAC,4),
				'-',
				LEFT(RIGHT(ihe.IHEGR_FECHANAC,7),2),
				'-',
				LEFT(ihe.IHEGR_FECHANAC,2)
				)
		),
		
		/* ocupacion */
		NULL,
		
		/* tipo_doc_madre */
		(CASE ihe.IHEGR_TIPODOCUMMADRE
			WHEN ''  THEN NULL
			WHEN '1' THEN 'DNI'
			WHEN '2' THEN 'LC'
			WHEN '3' THEN 'LE'
			WHEN '4' THEN 'CI'
			WHEN '5' THEN 'OTR'
			WHEN '9' THEN 'DNR'
			ELSE 'DNR'
		END),
		
		/* nro_doc_madre */
		IF (ihe.IHEGR_NRODOCUMMADRE='',NULL,ihe.IHEGR_NRODOCUMMADRE),
		
		/* nivel_academico */
		(SELECT desc_instruccion 
			FROM instruccion_hmi
			WHERE id_instruccion = 
				(CASE ihe.IHEGR_SUPUNIV
					WHEN '1'	THEN	'06'
					WHEN '2'	THEN	'07'
					WHEN '0'	THEN	
						(CASE	ihe.IHEGR_SISTEDUREF
							WHEN	'1'		THEN	'11'
							WHEN	'2'		THEN	'12'
							WHEN	'3'		THEN	'13'
							WHEN	'4'		THEN	'14'
							WHEN	'5'		THEN	'15'
							WHEN	'6'		THEN	'16'
							WHEN	'0'		THEN	
								(CASE	ihe.IHEGR_SISTEDUNOREF
									WHEN	'1'	THEN	'02'
									WHEN	'2'	THEN	'03'
									WHEN	'3'	THEN	'04'
									WHEN	'4'	THEN	'05'
									WHEN	'0'	THEN	
										(CASE ihe.IHEGR_INSTRUCCION
											WHEN	'1'	THEN	'01'
											WHEN	'2'	THEN	'00'
											WHEN	'9'	THEN	'99'
										END)
								END)
						END)
				END)
			), 
		
		/* estado_civil */
		NULL,
		
		/* situacion_laboral */
		(SELECT 
			sl.desc_sit_lab 
		FROM 
			situacion_laboral_hmi sl
		WHERE	
			sl.id_sit_lab = ihe.IHEGR_SITLABORAL
		),
			
		/* asociado */
		(SELECT aso.desc_asociado
			FROM asociado_hmi aso
			WHERE aso.id_asociado = ihe.IHEGR_OBRSOCIAL),
			
		/* fallecido */
		(CASE ihe.IHEGR_EGRPOR
			WHEN	'5'	THEN	TRUE
			ELSE	FALSE
		END),
		
		/* fecha_ultima_cond */
		ihe.IHEGR_FECHAEGRESO,
		
		/* id_origen_info */
		6,
		
		/* baja */
		FALSE
		
FROM ihegresos_sihos ihe
WHERE	ihegr_nrodocum<>''
AND		ihegr_nrodocum IS NOT NULL
AND		es_documento(
			ihe.IHEGR_TIPODOCUM,
			ihe.IHEGR_NRODOCUM,
			IF(TRIM(ihe.IHEGR_FECHANAC)='',
				NULL,
				CONCAT(
					RIGHT(ihe.IHEGR_FECHANAC,4),
							'-',
							LEFT(RIGHT(ihe.IHEGR_FECHANAC,7),2),
							'-',
							LEFT(ihe.IHEGR_FECHANAC,2)
					)
			)
		) = 1

ON DUPLICATE KEY UPDATE

	id_localidad = 
		IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
			id_localidad,
			(SELECT id_localidad 
				FROM localidades l 
					WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
					AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB
			)
		),
	
	apellido = ihe.IHEGR_APELLIDO,
	
	nombre = ihe.IHEGR_NOMBRE,
	
	sexo =
		(CASE ihe.IHEGR_SEXO
			WHEN '1' THEN 'M'
			WHEN '2' THEN 'F'
			ELSE 'I'
    	END),
    	
    dom_calle =	IFNULL(ihe.IHEGR_DIRECCION,personas.dom_calle),
    
    dom_nro = IFNULL(ihe.IHEGR_DIRNRO,personas.dom_nro),
    
    dom_dpto = IFNULL(ihe.IHEGR_DEP,personas.dom_dpto),
    
    dom_piso = IFNULL(ihe.IHEGR_PISO,personas.dom_piso),
    
	telefono_dom = IFNULL(ihe.IHEGR_TELEFONO,personas.telefono_dom),
		
	barrio = IFNULL(ihe.IHEGR_BARRIO,personas.barrio),
	
	localidad =
		IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
			localidad,
			(SELECT nom_loc 
				FROM localidades l 
					WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
					AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB
			)
		),
		
	departamento =
		IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
			departamento,
			(SELECT nom_dpto 
				FROM localidades l, departamentos d 
					WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
					AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB
					AND		l.id_dpto	= d.id_dpto
			)
		),
				
	provincia =
		IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
			provincia,
			(SELECT nom_prov 
				FROM localidades l, departamentos d, provincias p 
					WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
					AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB
					AND		l.id_dpto	= d.id_dpto
					AND		p.id_prov	= d.id_prov
			)
		),
				
	pais =
		IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
			pais,
			(SELECT nom_pais 
				FROM localidades l, departamentos d, provincias p, paises pa 
					WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
					AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB
					AND		l.id_dpto	= d.id_dpto
					AND		p.id_prov	= d.id_prov
					AND		p.id_pais	= pa.id_pais
			)
		),
				
	fecha_nac =
		IF(TRIM(ihe.IHEGR_FECHANAC=''),personas.fecha_nac,
			CONCAT(
				RIGHT(ihe.IHEGR_FECHANAC,4),
				'-',
				LEFT(RIGHT(ihe.IHEGR_FECHANAC,7),2),
				'-',
				LEFT(ihe.IHEGR_FECHANAC,2)
			)
		),
		
	tipo_doc_madre =
		(CASE ihe.IHEGR_TIPODOCUMMADRE
			WHEN ''  THEN personas.tipo_doc_madre
			WHEN '1' THEN 'DNI'
			WHEN '2' THEN 'LC'
			WHEN '3' THEN 'LE'
			WHEN '4' THEN 'CI'
			WHEN '5' THEN 'OTR'
			WHEN '9' THEN 'DNR'
			ELSE 'DNR'
		END),
		
	nro_doc_madre =	IF (ihe.IHEGR_NRODOCUMMADRE='',personas.nro_doc_madre,ihe.IHEGR_NRODOCUMMADRE),
	
	nivel_academico =
		(SELECT desc_instruccion 
			FROM instruccion_hmi
			WHERE id_instruccion = 
				(CASE ihe.IHEGR_SUPUNIV
					WHEN '1'	THEN	'06'
					WHEN '2'	THEN	'07'
					WHEN '0'	THEN	(CASE	ihe.IHEGR_SISTEDUREF
											WHEN	'1'		THEN	'11'
											WHEN	'2'		THEN	'12'
											WHEN	'3'		THEN	'13'
											WHEN	'4'		THEN	'14'
											WHEN	'5'		THEN	'15'
											WHEN	'6'		THEN	'16'
											WHEN	'0'		THEN	(CASE	ihe.IHEGR_SISTEDUNOREF
																		WHEN	'1'	THEN	'02'
																		WHEN	'2'	THEN	'03'
																		WHEN	'3'	THEN	'04'
																		WHEN	'4'	THEN	'05'
																		WHEN	'0'	THEN	(CASE ihe.IHEGR_INSTRUCCION
																								WHEN	'1'	THEN	'01'
																								WHEN	'2'	THEN	'00'
																								WHEN	'9'	THEN	'99'
																							END)
																	END)
										END)
				END)
			),
	
	situacion_laboral =
		IFNULL(
			(SELECT 
				sl.desc_sit_lab 
			FROM 
				situacion_laboral_hmi sl
			WHERE	
				sl.id_sit_lab = ihe.IHEGR_SITLABORAL),
			personas.situacion_laboral),
			
	asociado =
		IFNULL(
			(SELECT 
				aso.desc_asociado
			FROM 
				asociado_hmi aso
			WHERE 
				aso.id_asociado = ihe.IHEGR_OBRSOCIAL),
			personas.asociado),
			
	fallecido =
		(CASE ihe.IHEGR_EGRPOR
			WHEN	'5'	THEN	TRUE
			ELSE	FALSE
		END),
		
	fecha_ultima_cond =	ihe.IHEGR_FECHAEGRESO,
	
	id_origen_info = 6	;	
	
/* habilita los indices para la tabla personas */	
ALTER TABLE personas ENABLE KEYS;





/* deshabilita los indices de la tabla personas_sihos_docs_inconsistentes */
ALTER TABLE personas_sihos_docs_inconsistentes DISABLE KEYS;

INSERT IGNORE INTO personas_sihos_docs_inconsistentes
	SELECT 	
			0,
			(SELECT id_efector
				FROM efectores e
				WHERE e.claveestd = CONCAT(ihe.IHEGR_CODDPTO,ihe.IHEGR_CODEST) 
			),
			ihe.IHEGR_NROHISCLI,
			IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
				NULL,
				(SELECT id_localidad 
					FROM localidades l 
						WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
						AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB)
			),
			CASE ihe.IHEGR_TIPODOCUM
				WHEN '1' THEN 'DNI'
				WHEN '2' THEN 'LC'
				WHEN '3' THEN 'LE'
				WHEN '4' THEN 'CI'
				WHEN '5' THEN 'OTR'
				WHEN '9' THEN 'DNR'
				ELSE 'DNR'
			END,
			ihe.IHEGR_NRODOCUM,
			ihe.IHEGR_APELLIDO,
			ihe.IHEGR_NOMBRE,
			CASE ihe.IHEGR_SEXO
				WHEN '1' THEN 'M'
				WHEN '2' THEN 'F'
				ELSE 'D'
        	END,
			ihe.IHEGR_DIRECCION,
			ihe.IHEGR_DIRNRO,
			ihe.IHEGR_DEP,
			ihe.IHEGR_PISO,
			NULL,
			ihe.IHEGR_TELEFONO,
			NULL,
			ihe.IHEGR_BARRIO,
			IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
				NULL,
				(SELECT nom_loc 
					FROM localidades l 
						WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
						AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB)
			),
			IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
				NULL,
				(SELECT nom_dpto 
					FROM localidades l, departamentos d 
						WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
						AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB
						AND		l.id_dpto	= d.id_dpto)
			),
			IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
				NULL,
				(SELECT nom_prov 
					FROM localidades l, departamentos d, provincias p 
						WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
						AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB
						AND		l.id_dpto	= d.id_dpto
						AND		p.id_prov	= d.id_prov)
			),
			IF (ihe.IHEGR_LOCRESHAB='99' AND ihe.IHEGR_DPTORESHAB='999',
				NULL,
				(SELECT nom_pais 
					FROM localidades l, departamentos d, provincias p, paises pa 
						WHERE	l.cod_loc	= ihe.IHEGR_LOCRESHAB
						AND		l.cod_dpto	= ihe.IHEGR_DPTORESHAB
						AND		l.id_dpto	= d.id_dpto
						AND		p.id_prov	= d.id_prov
						AND		p.id_pais	= pa.id_pais)
			),
			IF(TRIM(ihe.IHEGR_FECHANAC)='',
					NULL,
					CONCAT(
						RIGHT(ihe.IHEGR_FECHANAC,4),
								'-',
								LEFT(RIGHT(ihe.IHEGR_FECHANAC,7),2),
								'-',
								LEFT(ihe.IHEGR_FECHANAC,2)
					)
			),
			NULL,
			CASE ihe.IHEGR_TIPODOCUMMADRE
				WHEN ''  THEN NULL
				WHEN '1' THEN 'DNI'
				WHEN '2' THEN 'LC'
				WHEN '3' THEN 'LE'
				WHEN '4' THEN 'CI'
				WHEN '5' THEN 'OTR'
				WHEN '9' THEN 'DNR'
				ELSE 'DNR'
			END,
			IF (ihe.IHEGR_NRODOCUMMADRE='',NULL,ihe.IHEGR_NRODOCUMMADRE),
			(SELECT desc_instruccion 
				FROM instruccion_hmi
				WHERE id_instruccion = 
					(CASE ihe.IHEGR_SUPUNIV
						WHEN '1'	THEN	'06'
						WHEN '2'	THEN	'07'
						WHEN '0'	THEN	(CASE	ihe.IHEGR_SISTEDUREF
												WHEN	'1'		THEN	'11'
												WHEN	'2'		THEN	'12'
												WHEN	'3'		THEN	'13'
												WHEN	'4'		THEN	'14'
												WHEN	'5'		THEN	'15'
												WHEN	'6'		THEN	'16'
												WHEN	'0'		THEN	(CASE	ihe.IHEGR_SISTEDUNOREF
																			WHEN	'1'	THEN	'02'
																			WHEN	'2'	THEN	'03'
																			WHEN	'3'	THEN	'04'
																			WHEN	'4'	THEN	'05'
																			WHEN	'0'	THEN	(CASE ihe.IHEGR_INSTRUCCION
																									WHEN	'1'	THEN	'01'
																									WHEN	'2'	THEN	'00'
																									WHEN	'9'	THEN	'99'
																								END)
																		END)
											END)
					END)
				), 
			NULL,
			(SELECT sl.desc_sit_lab 
				FROM situacion_laboral_hmi sl
				WHERE	sl.id_sit_lab = ihe.IHEGR_SITLABORAL),
			(SELECT aso.desc_asociado
				FROM asociado_hmi aso
				WHERE aso.id_asociado = ihe.IHEGR_OBRSOCIAL),
			(CASE ihe.IHEGR_EGRPOR
				WHEN	'5'	THEN	TRUE
				ELSE	FALSE
			END),
			ihe.IHEGR_FECHAEGRESO,
			6,
			FALSE
			
	FROM ihegresos_sihos ihe
	WHERE	ihegr_nrodocum<>''
	AND		ihegr_nrodocum IS NOT NULL
	AND		es_documento(
				ihe.IHEGR_TIPODOCUM,
				ihe.IHEGR_NRODOCUM,
				IF(TRIM(ihe.IHEGR_FECHANAC)='',
					NULL,
					CONCAT(
						RIGHT(ihe.IHEGR_FECHANAC,4),
								'-',
								LEFT(RIGHT(ihe.IHEGR_FECHANAC,7),2),
								'-',
								LEFT(ihe.IHEGR_FECHANAC,2)
						)
				)
			) = 0;
	
	
	
/* habilita los indices para la tabla personas_sihos_docs_inconsistentes */	
ALTER TABLE personas_sihos_docs_inconsistentes ENABLE KEYS;







/* crea una tabla auxiliar con numeros de historias clinicas	*/
/* NOTA: debido a que el sihos permite repetir el nro de		*/
/* historia clinica, se van a tomar los numeros no repetidos,	*/
/* considerando el primer numero encontrado de un par repetido	*/
/* para una persona ya existente en la tabla personas 			*/
DROP TABLE IF EXISTS hc_auxiliar_sihos;

CREATE TABLE hc_auxiliar_sihos (

	id_efector		INTEGER		UNSIGNED 	NOT NULL,
	id_persona		INTEGER		UNSIGNED 	NOT NULL,
	ihegr_nrohiscli	INTEGER		UNSIGNED 	NOT NULL,
	marca_borrado	BOOLEAN					NOT NULL DEFAULT FALSE,
	PRIMARY KEY (id_efector,ihegr_nrohiscli)		
)ENGINE=MyISAM;

/* inserta las historias clinicas de los pacientes del sihos */ 
INSERT IGNORE INTO hc_auxiliar_sihos
	SELECT	
			(SELECT id_efector
				FROM efectores e
				WHERE e.claveestd = CONCAT(ihe.IHEGR_CODDPTO,ihe.IHEGR_CODEST) 
			),
			(SELECT id_persona
				FROM personas p
				WHERE	(CASE ihe.IHEGR_TIPODOCUM
							WHEN '9' THEN 'DNR'
							WHEN '1' THEN 'DNI'
							WHEN '2' THEN 'LC'
							WHEN '3' THEN 'LE'
							WHEN '4' THEN 'CI'
							WHEN '5' THEN 'OTR'
							ELSE 'DNR'
						END)				= p.tipo_doc
				AND		ihe.IHEGR_NRODOCUM	= p.nro_doc
			),
			ihe.IHEGR_NROHISCLI,
			FALSE
			
	FROM ihegresos_sihos ihe
	WHERE 
			ihe.IHEGR_NROHISCLI <> ''
	AND		es_documento(
				ihe.IHEGR_TIPODOCUM,
				ihe.IHEGR_NRODOCUM,
				IF(TRIM(ihe.IHEGR_FECHANAC)='',
					NULL,
					CONCAT(
						RIGHT(ihe.IHEGR_FECHANAC,4),
								'-',
								LEFT(RIGHT(ihe.IHEGR_FECHANAC,7),2),
								'-',
								LEFT(ihe.IHEGR_FECHANAC,2)
						)
				)
			) = 1;
	
/* eliminar los registros de la tabla auxiliar de historias clinicas del sihos */
/* que ya tengan un numero de historia clinica del sihos en ese efector */
UPDATE hc_auxiliar_sihos hcs, hc_personas hc
	SET		hcs.marca_borrado = TRUE
	WHERE 	hcs.id_efector = hc.id_efector
	AND		hcs.ihegr_nrohiscli = hc.his_cli_sihos;
		
DELETE FROM hc_auxiliar_sihos WHERE marca_borrado IS TRUE;

/* Deshabilita los indices de historias clinicas de personas */
ALTER TABLE hc_personas DISABLE KEYS;

/* inserta las historias clinicas de los pacientes del sihos */ 
INSERT INTO hc_personas
	SELECT	0,
			hcs.id_efector,
			hcs.id_persona,
			NULL, /* id_sistema_propietario */
			NULL, /* numero_paciente_sicap	*/
			NULL, /* numero_grupo_familiar_sicap */
			NULL, /* historia_familiar_sicap */
			NULL, /* historia_personal_sicap */
			NULL, /* his_cli_internacion_hmi */
			NULL, /* his_cli_ce_hmi			*/
			hcs.ihegr_nrohiscli,
			NULL, /* his_cli_sistema_propietario */
			NULL  /* nr0_hc_diagnose		*/
			
	FROM hc_auxiliar_sihos hcs
	ON DUPLICATE KEY UPDATE 
		his_cli_sihos = hcs.ihegr_nrohiscli;
		
/* habilita los indices en historia clinicas de personas */
ALTER TABLE hc_personas ENABLE KEYS;