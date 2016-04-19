/* ---------------------------------------------------------- */	
/* PADRON ELECTORAL - carga las personas del padron electoral */
/* ---------------------------------------------------------- */

/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;

INSERT IGNORE INTO personas
	SELECT 0,
			(SELECT id_localidad
				FROM localidades l
				WHERE l.nom_loc=pe.nom_loc
				LIMIT 0,1),
			IF(ISNULL(str_separa_ocup_dir_tipodoc(pe.ocup_dir_tipodoc,'t')),
				"DNR",
				str_separa_ocup_dir_tipodoc(pe.ocup_dir_tipodoc,'t')
				),
			pe.nro_doc,
			str_separa_ape(pe.ape_nom,true),
			str_separa_ape(pe.ape_nom,false),
			pe.sexo,
			str_separa_ocup_dir_tipodoc(pe.ocup_dir_tipodoc,'d'),
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			pe.nom_loc,
			pe.nom_dpto,
			"SANTA FE",
			"ARGENTINA",
			NULL,
			str_separa_ocup_dir_tipodoc(pe.ocup_dir_tipodoc,'o'),
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			false,
			NULL,
			4
			
	FROM padron_electoral pe;
	
/* habilita los indices para la tabla personas*/	
ALTER TABLE personas ENABLE KEYS;
