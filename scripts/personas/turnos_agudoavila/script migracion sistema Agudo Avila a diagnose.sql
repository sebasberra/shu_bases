
INSERT INTO diagnose.paciente (ape_y_nom,st_nombre,domicilio,
				tipo_doc,nro_doc,nr0_hc,
				ocupacion,chk_busca,
				fecha_nac,telefono,
				localidad,in_idlocalidad,sexo,
				calle,nro_dom,dom_piso,dom_dep,
				nom_madre,madre_tipodoc,madre_documento,
				iup, archivo, cobertura, estado, nom_padre, Estado_Civil,
				Nom_Conyugue, lugar_nac, obs, dt_created, st_puesto)
				
 SELECT  TRIM(p.apellido) AS apy_y_nom,
	TRIM(CONCAT(p.nombre1, " ", p.nombre2)) AS st_nombre,
	TRIM(p.calle) AS domicilio, /*esto no se si quedara bien, no va a seguir el criterio de calles*/
	(SELECT IF(td.tipo_doc = 0, 'OTR', td.des_abreviada)
		FROM test.tparam_tipo_documento td 
		WHERE td.tipo_doc = p.tipo_doc ) AS tipo_doc,
	p.nro_doc AS nro_doc, /*IF(p.tipo_doc = 0, 0, p.nro_doc) AS nro_doc,	/*los pacientes de los que no se sabe el dni tienen un dni falso */
	IF(p.nro_historia = 0, p.nro_doc, p.nro_historia) AS nr0_hc, /*la HC de los que no tienen historia clinica sera el dni falso*/
	/*Allow_Pac_Indo*/
	'' AS ocupacion,
	0 AS chk_busca, /*0= SIN especificar, 1=Trabaja o de licencia, 2=Busca, 3=NO busca */
	p.fecha_nacimiento AS fecha_nac,
	(IFNULL((SELECT tgcw.telefono
		FROM test.tgral_pacientes_contactos tgcw
		WHERE  tgcw.tipo_doc = p.tipo_doc
		AND tgcw.nro_doc = p.nro_doc
		AND tgcw.contador = 1), '' )) AS telefono, /*ver modo de trasladar este dato*/
	(SELECT c.ciudad FROM test.tparam_codigos_postales c WHERE c.cod_postal=p.cod_postal) AS localidad,
	IF(p.cod_postal=2000,366,NULL) AS in_idlocalidad, /*in_idlocalidad*/	
	(CASE p.masc_fem
			WHEN 0 THEN 'F'
			WHEN 1  THEN 'M'
			ELSE  'I'
		END) AS sexo,
	/*Idbarrio*/
	/*centro_de_*/
	/*o_social*/
	/*condicion_os*/
	'1' AS calle,    /*este no se usa??--> si esta el null no carga la numeracion*/
	p.numero AS nro_dom,
	/*ver lo del bis còmo se guarda en esta tabla en datosAgudo esta como bis 0 o 1*/
	'0' AS dom_piso,
	'0' AS dom_dep, 
	'' AS nom_madre,
	'' AS madre_tipodoc,
	0 AS madre_documento,  /*
	condicion
	fecha_cond
	nro_hc_int
	nro_hc_onc
	nro_hc_gin */
	0 AS iup,
	bis AS archivo, /*1 bis 0 no bis*/
	/*cd_med_ref*/
	(CASE TRIM(p.obra_social)
		WHEN '' THEN 'Sin Cobertura'
		WHEN 'NO' THEN 'Sin Cobertura'
		WHEN 'no' THEN 'Sin Cobertura'
		WHEN 'no tiene' THEN 'Sin Cobertura'
		WHEN 'NINGUNA' THEN 'Sin Cobertura'
		WHEN 'profe' THEN 'Plan o seguro Publico'
		WHEN 'PTE. DE CHASSET,M' THEN 'Sin Cobertura'
		WHEN 'DRA. LILIANAPASQUINELLI' THEN 'Sin Cobertura'
		WHEN 'pocho bernardo' THEN 'Sin Cobertura'
		ELSE 'Sin Cobertura'
	END) AS cobertura, 
	/*os
	Nivel_Academico*/
	'' AS estado,
	'' AS nom_padre,
	'' AS Estado_Civil,
	 /*
	in_idestadocivil*/
	'' AS Nom_Conyugue,
	'' AS lugar_nac,
	CONCAT( 
		IFNULL((SELECT GROUP_CONCAT('tel ',TRIM(tgc.contacto), ': ',TRIM(tgc.telefono),'\n' )
			FROM test.tgral_pacientes_contactos tgc
			WHERE tgc.nro_doc = p.nro_doc
			AND tgc.tipo_doc = p.tipo_doc
			GROUP BY tgc.nro_doc, tgc.tipo_doc),'' ),
		IF( TRIM(p.calle)='', '', CONCAT('domicilio: ',p.calle,' ',p.numero,IF(p.bis,' bis',''),'\n')) ,
		IF( TRIM(p.agregado_domicilio)='', '', CONCAT('observaciones anteriores: "',p.agregado_domicilio,'"\n')) ,
		IF(p.tipo_doc = 0,CONCAT('nro doc anterior a la migracion: ', p.nro_doc,'\n'),''),
		IF(p.cod_postal<>2000,CONCAT('localidad: ', c.ciudad,'\n'),''), 
		(CASE p.obra_social
			WHEN '' THEN ''
			WHEN 'NO' THEN ''
			WHEN 'no' THEN ''
			WHEN 'no tiene' THEN ''
			WHEN 'NINGUNA' THEN ''		
			WHEN 'PTE. DE CHASSET,M' THEN 'Sin Cobertura'
			WHEN 'DRA. LILIANAPASQUINELLI' THEN 'Sin Cobertura'
			WHEN 'pocho bernardo' THEN 'Sin Cobertura'
			WHEN 'profe' THEN 'PROFE'
		ELSE CONCAT('obra social: ',p.obra_social,'\n') END)
		)
		AS obs,
	/*in_Active
	st_operador_baja
	st_puesto_baja
	in_Ficha
	in_HCpresente
	in_obito
	in_corregido*/
	CURRENT_TIMESTAMP AS dt_created,
	/*st_operador*/
	'migracion' AS st_puesto
	
FROM test.tgral_pacientes p, test.tparam_codigos_postales c
WHERE 	p.cod_postal = c.cod_postal
AND NOT (nro_historia = 0)
AND NOT (p.nro_doc = 20305638 AND tipo_doc = 0)
AND NOT (p.nro_doc = 30406904 AND tipo_doc = 0)
AND NOT (p.nro_doc = 35703131 AND tipo_doc = 0)
AND NOT (p.nro_doc = 4488276 AND tipo_doc = 1)
AND NOT (p.nro_doc = 3684953 AND tipo_doc = 1)
AND NOT (p.nro_doc = 7841791 AND tipo_doc = 1)
AND NOT (p.nro_doc = 8599792 AND tipo_doc = 1)

