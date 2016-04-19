/* -------------------------------------------------------- */
/* HMI - carga las personas sin numero de documento del hmi */
/* -------------------------------------------------------- */

/* CAMBIAR el id_efector !!!! */



/* migra las personas que no tienen numero de documento 				*/
/* para el HMI los codigos de tipo de documento son:					*/
/*																		*/
/* ptipdoc = 8		->		hist. clinica de consultorio externo		*/
/* ptipdoc = 9 		->		hist. clinica de internacion				*/
INSERT INTO personas
	SELECT 0,
			(SELECT id_localidad 
				FROM localidades l,departamentos d 
					WHERE	l.cod_loc	= dg.localidad
					AND		d.cod_dpto	= dg.departamento
					AND		l.id_dpto	= d.id_dpto),
			CASE ptipdoc
				WHEN '8' THEN 'CEX'
				WHEN '9' THEN 'INT'
				ELSE 'DNR'
			END,
			nrodoc,
			str_separa_ape(apenompac,true),
			str_separa_ape(apenompac,false),
			CASE sexo
				WHEN '0' THEN 'D'
				WHEN '1' THEN 'M'
				WHEN '2' THEN 'F'
				ELSE 'D'
        	END,
			calle,
			domnro,
			IF (domdep='',NULL,domdep),
			NULL,
			NULL,
			TRIM(CONCAT(carac_td,' ',nro_td)),
			TRIM(CONCAT(carac_tc,' ',pre_tc,' ',nro_tc)),
			barrio,
			(SELECT nom_loc 
				FROM localidades l,departamentos d 
					WHERE	l.cod_loc	= dg.localidad
					AND		d.cod_dpto	= dg.departamento
					AND		l.id_dpto	= d.id_dpto),
			(SELECT nom_dpto 
				FROM departamentos d 
					WHERE	d.cod_dpto	= dg.departamento),
			(SELECT nom_prov 
				FROM provincias p 
					WHERE	p.cod_prov	= dg.provincia),
			(SELECT nom_pais 
				FROM paises p 
					WHERE	p.cod_pais	= dg.pais),
			concat(dg.fnanio,'-',dg.fnmes,'-',dg.fndia),
			dg.ocup_hab,
			CASE dg.tipo_mad
				WHEN '0' THEN 'DNR'
				WHEN '1' THEN 'DNI'
				WHEN '2' THEN 'LC'
				WHEN '3' THEN 'LE'
				WHEN '4' THEN 'CI'
				WHEN '5' THEN 'OTR'
				WHEN '8' THEN 'OTR'
				WHEN '9' THEN 'OTR'
				WHEN NULL THEN NULL
				ELSE 'DNR'
			END,
			dg.nrodoc_mad,
			(SELECT desc_instruccion 
				FROM instruccion_hmi i
				WHERE i.id_instruccion=dg.instruc),
			NULL,
			(SELECT desc_sit_lab
				FROM situacion_laboral_hmi s
				WHERE s.id_sit_lab=dg.sit_lab),
			(SELECT desc_asociado
				FROM asociado_hmi a
				WHERE a.id_asociado=dg.asociado),
			IF (dg.condicion=2,true,false),
			concat(dg.fcanio,'-',dg.fcmes,'-',dg.fcdia),
			1
			
	FROM 	dg_pacientes_hmi dg
	
	WHERE 	dg.ptipdoc='8' 
	OR 		dg.ptipdoc='9';


/* ------------------------------------------ */	
/* HMI - carga las historias clinicas del hmi */
/* ------------------------------------------ */

/* Hospital Cullen		->	id_efector = 71		*/
/* Hospital Iturraspe	->	id_efector = 72		*/
/* Inst. Vera Candiotti ->	id_efector = 74		*/
/* Hospital Alassia		->	id_efector = 121	*/
/* Hospital Eva Peron   ->  id_efector = 167	*/
/* Hospital Centenario	->	id_efector = 183	*/
/* Hospital Provincial	->	id_efector = 184	*/

INSERT INTO hc_personas
	SELECT	0,
			72,
			(SELECT id_persona
				FROM personas p
				WHERE	(CASE dg.ptipdoc
							WHEN '8' THEN 'CEX'
							WHEN '9' THEN 'INT'
							ELSE 'DNR'
						END)		= p.tipo_doc
				AND		dg.nrodoc	= p.nro_doc),
			NULL,
			NULL,
			NULL,
			NULL,
			IF (CAST(dg.s1hiscli AS UNSIGNED)=0,
				NULL,CAST(dg.s1hiscli AS UNSIGNED)),
			IF (CAST(dg.s3hisclice AS UNSIGNED)=0,
				NULL,CAST(dg.s3hisclice AS UNSIGNED))
	FROM 	dg_pacientes_hmi dg
	
	WHERE 	dg.ptipdoc='8' 
	OR 		dg.ptipdoc='9';

