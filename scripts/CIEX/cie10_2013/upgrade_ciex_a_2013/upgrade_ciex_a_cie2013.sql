DROP TEMPORARY TABLE IF EXISTS ciex_3_2013;

CREATE TEMPORARY TABLE ciex_3_2013(
	cod_3dig	CHAR(3) NOT NULL,
	descripcion	VARCHAR(255) NOT NULL
)ENGINE=MyISAM;

LOAD DATA LOCAL INFILE "ciex_3_2013.csv" 
	INTO TABLE ciex_3_2013
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n';
	
CREATE TEMPORARY TABLE ciex_4_2013(
	cod_3dig	CHAR(3) NOT NULL,
	cod_4dig	CHAR(1) NOT NULL,
	descripcion	VARCHAR(255) NOT NULL
)ENGINE=MyISAM;

LOAD DATA LOCAL INFILE "ciex_4_2013.csv" 
	INTO TABLE ciex_4_2013
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n';
	


/* --------- */
/* 3 digitos */
/* --------- */

/* U04 */
UPDATE
	
	ciex_3
	
SET

	descripcion = 'SINDROME RESPIRATORIO AGUDO GRAVE [SRAG]',
	desc_red = 'SINDROME RESPIRATORIO AGUDO GRAVE [SRAG]'

WHERE 

	id_ciex_3 = 2041;
	
	
/* U06 */
INSERT

	ciex_3
	
VALUES (
	
	/* id_ciex_3 */
	2046,
	
	/* cod_3dig */
	'U06',
	
	/* descripcion */
	'USO EMERGENTE DE U06',
	
	/* desc_red */
	'USO EMERGENTE DE U06'
	);
	
/* U07 */
INSERT

	ciex_3
	
VALUES (
	
	/* id_ciex_3 */
	2047,
	
	/* cod_3dig */
	'U07',
	
	/* descripcion */
	'USO EMERGENTE DE U07',
	
	/* desc_red */
	'USO EMERGENTE DE U07'
	);


/* ------------- */	
/* capitulo	XXII */
/* ------------- */


/* grupo (U00-U49) */
UPDATE 

	ciex_titulos
	
SET

	id_ciex_3_hasta = 2047,
	cod_3dig_hasta = 'U07',
	descripcion = 'ASIGNACION PROVISORIA DE NUEVAS AFECCIONES DE ETIOLOGIA INCIERTA O DE USO EMERGENTE (U00-U49)',
	desc_red = 'ASIGNACION PROVISORIA DE NUEVAS AFECCIONES DE ETIO'

WHERE

	id_ciex_titulo = 293;

/* U06.0 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12472,
	
	/* id_ciex_3 */
	2046,
	
	/* cod_3dig */
	'U06',
	
	/* cod_4dig */
	'0',
	
	/* descripcion */
	'USO EMERGENTE DE U06.0',
	
	/* desc_red */
	'USO EMERGENTE DE U06.0',
	
	/* informa_c2 */
	'0'
);


/* U06.1 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12473,
	
	/* id_ciex_3 */
	2046,
	
	/* cod_3dig */
	'U06',
	
	/* cod_4dig */
	'1',
	
	/* descripcion */
	'USO EMERGENTE DE U06.1',
	
	/* desc_red */
	'USO EMERGENTE DE U06.1',
	
	/* informa_c2 */
	'0'
);


/* U06.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12474,
	
	/* id_ciex_3 */
	2046,
	
	/* cod_3dig */
	'U06',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'USO EMERGENTE DE U06.2',
	
	/* desc_red */
	'USO EMERGENTE DE U06.2',
	
	/* informa_c2 */
	'0'
);


/* U06.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12475,
	
	/* id_ciex_3 */
	2046,
	
	/* cod_3dig */
	'U06',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'USO EMERGENTE DE U06.3',
	
	/* desc_red */
	'USO EMERGENTE DE U06.3',
	
	/* informa_c2 */
	'0'
);


/* U06.4 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12476,
	
	/* id_ciex_3 */
	2046,
	
	/* cod_3dig */
	'U06',
	
	/* cod_4dig */
	'4',
	
	/* descripcion */
	'USO EMERGENTE DE U06.4',
	
	/* desc_red */
	'USO EMERGENTE DE U06.4',
	
	/* informa_c2 */
	'0'
);


/* U06.5 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12477,
	
	/* id_ciex_3 */
	2046,
	
	/* cod_3dig */
	'U06',
	
	/* cod_4dig */
	'5',
	
	/* descripcion */
	'USO EMERGENTE DE U06.5',
	
	/* desc_red */
	'USO EMERGENTE DE U06.5',
	
	/* informa_c2 */
	'0'
);


/* U06.6 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12478,
	
	/* id_ciex_3 */
	2046,
	
	/* cod_3dig */
	'U06',
	
	/* cod_4dig */
	'6',
	
	/* descripcion */
	'USO EMERGENTE DE U06.6',
	
	/* desc_red */
	'USO EMERGENTE DE U06.6',
	
	/* informa_c2 */
	'0'
);


/* U06.7 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12479,
	
	/* id_ciex_3 */
	2046,
	
	/* cod_3dig */
	'U06',
	
	/* cod_4dig */
	'7',
	
	/* descripcion */
	'USO EMERGENTE DE U06.7',
	
	/* desc_red */
	'USO EMERGENTE DE U06.7',
	
	/* informa_c2 */
	'0'
);


/* U06.8 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12480,
	
	/* id_ciex_3 */
	2046,
	
	/* cod_3dig */
	'U06',
	
	/* cod_4dig */
	'8',
	
	/* descripcion */
	'USO EMERGENTE DE U06.8',
	
	/* desc_red */
	'USO EMERGENTE DE U06.8',
	
	/* informa_c2 */
	'0'
);


/* U06.9 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12481,
	
	/* id_ciex_3 */
	2046,
	
	/* cod_3dig */
	'U06',
	
	/* cod_4dig */
	'9',
	
	/* descripcion */
	'USO EMERGENTE DE U06.9',
	
	/* desc_red */
	'USO EMERGENTE DE U06.9',
	
	/* informa_c2 */
	'0'
);


/* U07.0 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12482,
	
	/* id_ciex_3 */
	2047,
	
	/* cod_3dig */
	'U07',
	
	/* cod_4dig */
	'0',
	
	/* descripcion */
	'USO EMERGENTE DE U07.0',
	
	/* desc_red */
	'USO EMERGENTE DE U07.0',
	
	/* informa_c2 */
	'0'
);


/* U07.1 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12483,
	
	/* id_ciex_3 */
	2047,
	
	/* cod_3dig */
	'U07',
	
	/* cod_4dig */
	'1',
	
	/* descripcion */
	'USO EMERGENTE DE U07.1',
	
	/* desc_red */
	'USO EMERGENTE DE U07.1',
	
	/* informa_c2 */
	'0'
);


/* U07.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12484,
	
	/* id_ciex_3 */
	2047,
	
	/* cod_3dig */
	'U07',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'USO EMERGENTE DE U07.2',
	
	/* desc_red */
	'USO EMERGENTE DE U07.2',
	
	/* informa_c2 */
	'0'
);


/* U07.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12485,
	
	/* id_ciex_3 */
	2047,
	
	/* cod_3dig */
	'U07',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'USO EMERGENTE DE U07.3',
	
	/* desc_red */
	'USO EMERGENTE DE U07.3',
	
	/* informa_c2 */
	'0'
);


/* U07.4 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12486,
	
	/* id_ciex_3 */
	2047,
	
	/* cod_3dig */
	'U07',
	
	/* cod_4dig */
	'4',
	
	/* descripcion */
	'USO EMERGENTE DE U07.4',
	
	/* desc_red */
	'USO EMERGENTE DE U07.4',
	
	/* informa_c2 */
	'0'
);


/* U07.5 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12487,
	
	/* id_ciex_3 */
	2047,
	
	/* cod_3dig */
	'U07',
	
	/* cod_4dig */
	'5',
	
	/* descripcion */
	'USO EMERGENTE DE U07.5',
	
	/* desc_red */
	'USO EMERGENTE DE U07.5',
	
	/* informa_c2 */
	'0'
);


/* U07.6 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12488,
	
	/* id_ciex_3 */
	2047,
	
	/* cod_3dig */
	'U07',
	
	/* cod_4dig */
	'6',
	
	/* descripcion */
	'USO EMERGENTE DE U07.6',
	
	/* desc_red */
	'USO EMERGENTE DE U07.6',
	
	/* informa_c2 */
	'0'
);


/* U07.7 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12489,
	
	/* id_ciex_3 */
	2047,
	
	/* cod_3dig */
	'U07',
	
	/* cod_4dig */
	'7',
	
	/* descripcion */
	'USO EMERGENTE DE U07.7',
	
	/* desc_red */
	'USO EMERGENTE DE U07.7',
	
	/* informa_c2 */
	'0'
);


/* U07.8 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12490,
	
	/* id_ciex_3 */
	2047,
	
	/* cod_3dig */
	'U07',
	
	/* cod_4dig */
	'8',
	
	/* descripcion */
	'USO EMERGENTE DE U07.8',
	
	/* desc_red */
	'USO EMERGENTE DE U07.8',
	
	/* informa_c2 */
	'0'
);


/* U07.9 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12491,
	
	/* id_ciex_3 */
	2047,
	
	/* cod_3dig */
	'U07',
	
	/* cod_4dig */
	'9',
	
	/* descripcion */
	'USO EMERGENTE DE U07.9',
	
	/* desc_red */
	'USO EMERGENTE DE U07.9',
	
	/* informa_c2 */
	'0'
);


/* baja grupo (U80-U82) */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	651,
	
	/* id_ciex_4 */
	NULL,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	294,
	
	/* cod_3dig */
	NULL,
	
	/* cod_4dig */
	NULL,
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* capitulo XXII (U00-U99) */

/* 01-01-2010 al 01-01-2016 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	652,
	
	/* id_ciex_4 */
	NULL,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	292,
	
	/* cod_3dig */
	NULL,
	
	/* cod_4dig */
	NULL,
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* 01-01-2016 al presente */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	653,
	
	/* id_ciex_4 */
	NULL,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	292,
	
	/* cod_3dig */
	NULL,
	
	/* cod_4dig */
	NULL,
	
	/* sexo */
	0,
	
	/* frecuencia */
	0,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);



/* U82 */
INSERT

	ciex_3
	
VALUES (
	
	/* id_ciex_3 */
	2048,
	
	/* cod_3dig */
	'U82',
	
	/* descripcion */
	'RESISTENCIA A ANTIBIOTICOS BELACTAMICOS',
	
	/* desc_red */
	'RESISTENCIA A ANTIBIOTICOS BELACTAMICOS'
	);
	
	
/* U83 */
INSERT

	ciex_3
	
VALUES (
	
	/* id_ciex_3 */
	2049,
	
	/* cod_3dig */
	'U83',
	
	/* descripcion */
	'RESISTENCIA A OTROS ANTIBIOTICOS',
	
	/* desc_red */
	'RESISTENCIA A OTROS ANTIBIOTICOS'
	);
	

/* U84 */
INSERT

	ciex_3
	
VALUES (
	
	/* id_ciex_3 */
	2050,
	
	/* cod_3dig */
	'U84',
	
	/* descripcion */
	'RESISTENCIA A OTRAS DROGAS ANTIMICROBIANAS',
	
	/* desc_red */
	'RESISTENCIA A OTRAS DROGAS ANTIMICROBIANAS'
	);
	
	
/* U85 */
INSERT

	ciex_3
	
VALUES (
	
	/* id_ciex_3 */
	2051,
	
	/* cod_3dig */
	'U85',
	
	/* descripcion */
	'RESISTENCIA A DROGAS ANTINEOPLASICAS',
	
	/* desc_red */
	'RESISTENCIA A DROGAS ANTINEOPLASICAS'
	);


/* elimina grupo U80 - U89 */
DELETE FROM

	ciex_titulos 
	
WHERE

	id_ciex_titulo = 294;


/* --------	*/
/*			*/
/* Capitulo */
/*			*/
/* U50-U99 	*/
/*			*/
/* --------	*/
	
INSERT INTO 

	ciex_titulos
	
VALUES (

	/* id_ciex_titulo */
	295,
	
	/* id_ciex_3_desde */
	2048,
	
	/* id_ciex_3_hasta */
	2051,
	
	/* capitulo */
	'22',
	
	/* grupo */
	'02',
	
	/* subgrupo */
	'00',
	
	/* cod_3dig_desde */
	'U82',
	
	/* cod_3dig_hasta */
	'U85'
	
	/* descripcion */
	'CODIGOS PARA INVESTIGACIONES Y SUBCLASIFICACIONES ALTERNATIVAS (U50-U99)',
	
	/* desc_red */
	'CODIGOS PARA INVESTIGACIONES Y SUBCLASIFICACIONES'
		
);


/* --------	*/
/*			*/
/* Capitulo */
/*			*/
/* U82-U85 	*/
/*			*/
/* --------	*/

INSERT INTO 

	ciex_titulos
	
VALUES (

	/* id_ciex_titulo */
	296,
	
	/* id_ciex_3_desde */
	2048,
	
	/* id_ciex_3_hasta */
	2051,
	
	/* capitulo */
	'22',
	
	/* grupo */
	'02',
	
	/* subgrupo */
	'01',
	
	/* cod_3dig_desde */
	'U82',
	
	/* cod_3dig_hasta */
	'U85'
	
	/* descripcion */
	'RESISTENCIA A DROGAS ANTIMICROBIANAS Y ANTINEOPLASICAS',
	
	/* desc_red */
	'RESISTENCIA A DROGAS ANTIMICROBIANAS Y ANTINEOPLAS'
		
);


/* U82.0 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12492,
	
	/* id_ciex_3 */
	2048,
	
	/* cod_3dig */
	'U82',
	
	/* cod_4dig */
	'0',
	
	/* descripcion */
	'RESISTENCIA A PENICILINA',
	
	/* desc_red */
	'RESISTENCIA A PENICILINA',
	
	/* informa_c2 */
	'0'
);


/* U82.1 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12493,
	
	/* id_ciex_3 */
	2048,
	
	/* cod_3dig */
	'U82',
	
	/* cod_4dig */
	'1',
	
	/* descripcion */
	'RESISTENCIA A METICILINA',
	
	/* desc_red */
	'RESISTENCIA A METICILINA',
	
	/* informa_c2 */
	'0'
);


/* U82.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12494,
	
	/* id_ciex_3 */
	2048,
	
	/* cod_3dig */
	'U82',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'RESISTENCIA A BETALACTAMASA DE ESPECTRO EXTENDIDO (BLEE)',
	
	/* desc_red */
	'RESISTENCIA A BETALACTAMASA DE ESPECTRO EXTENDIDO',
	
	/* informa_c2 */
	'0'
);


/* U82.8 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12495,
	
	/* id_ciex_3 */
	2048,
	
	/* cod_3dig */
	'U82',
	
	/* cod_4dig */
	'8',
	
	/* descripcion */
	'RESISTENCIA A OTROS ANTIBIÓTICOS BETALACTAMICOS',
	
	/* desc_red */
	'RESISTENCIA A OTROS ANTIBIÓTICOS BETALACTAMICOS',
	
	/* informa_c2 */
	'0'
);


/* U82.9 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12496,
	
	/* id_ciex_3 */
	2048,
	
	/* cod_3dig */
	'U82',
	
	/* cod_4dig */
	'9',
	
	/* descripcion */
	'RESISTENCIA A ANTIBIÓTICOS BETALACTAMICOS, NO ESPECIFICADOS',
	
	/* desc_red */
	'RESISTENCIA A ANTIBIÓTICOS BETALACTAMICOS, NO ESPE',
	
	/* informa_c2 */
	'0'
);


/* U83.0 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12497,
	
	/* id_ciex_3 */
	2049,
	
	/* cod_3dig */
	'U83',
	
	/* cod_4dig */
	'0',
	
	/* descripcion */
	'RESISTENCIA A VANCOMICINA',
	
	/* desc_red */
	'RESISTENCIA A VANCOMICINA',
	
	/* informa_c2 */
	'0'
);


/* U83.1 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12498,
	
	/* id_ciex_3 */
	2049,
	
	/* cod_3dig */
	'U83',
	
	/* cod_4dig */
	'1',
	
	/* descripcion */
	'RESISTENCIA A OTROS ANTIBIOTICOS SIMILARES A VANCOMICINA',
	
	/* desc_red */
	'RESISTENCIA A OTROS ANTIBIOTICOS SIMILARES A VANCO',
	
	/* informa_c2 */
	'0'
);


/* U83.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12499,
	
	/* id_ciex_3 */
	2049,
	
	/* cod_3dig */
	'U83',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'RESISTENCIA A QUINOLONAS',
	
	/* desc_red */
	'RESISTENCIA A QUINOLONAS',
	
	/* informa_c2 */
	'0'
);


/* U83.7 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12500,
	
	/* id_ciex_3 */
	2049,
	
	/* cod_3dig */
	'U83',
	
	/* cod_4dig */
	'7',
	
	/* descripcion */
	'RESISTENCIA A MULTIPLES ANTIBIOTICOS',
	
	/* desc_red */
	'RESISTENCIA A MULTIPLES ANTIBIOTICOS',
	
	/* informa_c2 */
	'0'
);


/* U83.8 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12501,
	
	/* id_ciex_3 */
	2049,
	
	/* cod_3dig */
	'U83',
	
	/* cod_4dig */
	'8',
	
	/* descripcion */
	'RESISTENCIA A OTROS ANTIBIOTICOS UNICOS ESPECIFICADOS',
	
	/* desc_red */
	'RESISTENCIA A OTROS ANTIBIOTICOS UNICOS ESPECIFICA',
	
	/* informa_c2 */
	'0'
);


/* U83.9 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12502,
	
	/* id_ciex_3 */
	2049,
	
	/* cod_3dig */
	'U83',
	
	/* cod_4dig */
	'9',
	
	/* descripcion */
	'RESISTENCIA A ANTIBIOTICOS NO ESPECIFICADOS',
	
	/* desc_red */
	'RESISTENCIA A ANTIBIOTICOS NO ESPECIFICADOS',
	
	/* informa_c2 */
	'0'
);


/* U84.0 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12503,
	
	/* id_ciex_3 */
	2050,
	
	/* cod_3dig */
	'U84',
	
	/* cod_4dig */
	'0',
	
	/* descripcion */
	'RESISTENCIA A DROGAS ANTIPARASITARIAS',
	
	/* desc_red */
	'RESISTENCIA A DROGAS ANTIPARASITARIAS',
	
	/* informa_c2 */
	'0'
);


/* U84.1 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12504,
	
	/* id_ciex_3 */
	2050,
	
	/* cod_3dig */
	'U84',
	
	/* cod_4dig */
	'1',
	
	/* descripcion */
	'RESISTENCIA A DROGAS ANTIMICOTICAS',
	
	/* desc_red */
	'RESISTENCIA A DROGAS ANTIMICOTICAS',
	
	/* informa_c2 */
	'0'
);


/* U84.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12505,
	
	/* id_ciex_3 */
	2050,
	
	/* cod_3dig */
	'U84',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'RESISTENCIA A DROGAS ANTIVIRALES',
	
	/* desc_red */
	'RESISTENCIA A DROGAS ANTIVIRALES',
	
	/* informa_c2 */
	'0'
);


/* U84.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12506,
	
	/* id_ciex_3 */
	2050,
	
	/* cod_3dig */
	'U84',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'RESISTENCIA A DROGAS ANTITUBERCULOSAS',
	
	/* desc_red */
	'RESISTENCIA A DROGAS ANTITUBERCULOSAS',
	
	/* informa_c2 */
	'0'
);


/* U84.7 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12507,
	
	/* id_ciex_3 */
	2050,
	
	/* cod_3dig */
	'U84',
	
	/* cod_4dig */
	'7',
	
	/* descripcion */
	'RESISTENCIA A MULTIPLES DROGAS ANTIMICROBIANAS',
	
	/* desc_red */
	'RESISTENCIA A MULTIPLES DROGAS ANTIMICROBIANAS',
	
	/* informa_c2 */
	'0'
);


/* U84.8 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12508,
	
	/* id_ciex_3 */
	2050,
	
	/* cod_3dig */
	'U84',
	
	/* cod_4dig */
	'8',
	
	/* descripcion */
	'RESISTENCIA A OTRAS DROGAS ANTIMICROBIANAS ESPECIFICADAS',
	
	/* desc_red */
	'RESISTENCIA A OTRAS DROGAS ANTIMICROBIANAS ESPECIF',
	
	/* informa_c2 */
	'0'
);



/* U84.9 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12509,
	
	/* id_ciex_3 */
	2050,
	
	/* cod_3dig */
	'U84',
	
	/* cod_4dig */
	'9',
	
	/* descripcion */
	'RESISTENCIA A DROGAS ANTIMICROBIANAS NO ESPECIFICADAS',
	
	/* desc_red */
	'RESISTENCIA A DROGAS ANTIMICROBIANAS NO ESPECIFICA',
	
	/* informa_c2 */
	'0'
);


/* U85.X */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12510,
	
	/* id_ciex_3 */
	2051,
	
	/* cod_3dig */
	'U85',
	
	/* cod_4dig */
	'X',
	
	/* descripcion */
	'RESISTENCIA A DROGAS ANTINEOPLASICAS',
	
	/* desc_red */
	'RESISTENCIA A DROGAS ANTINEOPLASICAS',
	
	/* informa_c2 */
	'0'
);


/* Z45.0 */
UPDATE

	ciex_4
	
SET

	descripcion = 'ASISTENCIA Y AJUSTE DE DISPOSITIVOS CARDIACOS',
	desc_red = 'ASISTENCIA Y AJUSTE DE DISPOSITIVOS CARDIACOS'
	
WHERE

	id_ciex_4 = 12081;
	

/* Z51.3 */
UPDATE

	ciex_4
	
SET

	descripcion = 'TRANFUSION DE SANGRE, (SIN DIAGNOSTICOS INFORMADO)',
	desc_red = 'TRANFUSION DE SANGRE, (SIN DIAGNOSTICOS INFORMADO)'
	
WHERE	
	
	id_ciex_4 = 12119;


/* Z74.0 */
UPDATE

	ciex_4
	
SET

	descripcion = 'NECESIDAD DE ASISTENCIA DEBIDA A MOVILIDAD REDUCIDA',
	desc_red = 'NECESIDAD DE ASISTENCIA DEBIDA A MOVILIDAD REDUCID'
	
WHERE	
	
	id_ciex_4 = 12275;
	

/* Z95.0 */
UPDATE

	ciex_4
	
SET

	descripcion = 'PRESENCIA DE DISPOSITIVOS CARDIACOS ELECTRONICOS',
	desc_red = 'PRESENCIA DE DISPOSITIVOS CARDIACOS ELECTRONICOS'
	
WHERE	
	
	id_ciex_4 = 12426;
	
	
/* Z91.1 FIX */
UPDATE

	ciex_4
	
SET

	descripcion = 'HISTORIA PERSONAL DE USO (PRESENTE) DE ANTICOAGULANTES POR LARGO TIEMPO',
	desc_red = 'HISTORIA PERSONAL DE USO (PRESENTE) DE ANTICOAGULA'
	
WHERE	
	
	id_ciex_4 = 12400;
	
	
/* Z99.4 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12511,
	
	/* id_ciex_3 */
	1956,
	
	/* cod_3dig */
	'Z99',
	
	/* cod_4dig */
	'4',
	
	/* descripcion */
	'DEPENDENCIA DE CORAZON ARTIFICIAL',
	
	/* desc_red */
	'DEPENDENCIA DE CORAZON ARTIFICIAL',
	
	/* informa_c2 */
	'0'
);

/* Y07 */
UPDATE 
	
	ciex_3
	
SET

	descripcion = "OTROS MALTRATOS",
	desc_red = "OTROS MALTRATOS"
	
WHERE

	id_ciex_3 = 1789;
	

/* T82.8 */
UPDATE

	ciex_4
	
SET

	descripcion = "OTRAS COMPLICACIONES ESPECIFICADAS DE DISPOSITIVOS PROTESICOS, IMPLANTES E INJERTOS CARDIOVASCULARES",
	desc_red = "OTRAS COMPLICACIONES ESPECIFICADAS DE DISPOSITIVOS"
	
WHERE

	id_ciex_4 = 8395;
	
	
/* S46.0 */
UPDATE

	ciex_4
	
WHERE

	descripcion = "TRAUMATISMO DEL MUSCULO(S) Y TENDON(ES) DEL MANGUITO ROTATORIO DEL HOMBRO",
	desc_red = "TRAUMATISMO DEL MUSCULO(S) Y TENDON(ES) DEL MANGUI"
	
WHERE

	id_ciex_4 = 7523;
	
	
/* R95.0 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12512,
	
	/* id_ciex_3 */
	1301,
	
	/* cod_3dig */
	'R95',
	
	/* cod_4dig */
	'0',
	
	/* descripcion */
	'SINDROME DE LA MUERTE SUBITA INFANTIL, CON MENCION DE AUTOPSIA',
	
	/* desc_red */
	'SINDROME DE LA MUERTE SUBITA INFANTIL, CON MENCION',
	
	/* informa_c2 */
	'0'
);


/* R95.9 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12513,
	
	/* id_ciex_3 */
	1301,
	
	/* cod_3dig */
	'R95',
	
	/* cod_4dig */
	'0',
	
	/* descripcion */
	'SINDROME DE LA MUERTE SUBITA INFANTIL, SIN MENCION DE AUTOPSIA',
	
	/* desc_red */
	'SINDROME DE LA MUERTE SUBITA INFANTIL, SIN MENCION',
	
	/* informa_c2 */
	'0'
);


/* X34.0 */
UPDATE

	ciex_4
	
SET

	descripcion = "VICTIMA DE MOVIMIENTOS CATACLISMICOS DE LA TIERRA CAUSADOS POR TERREMOTO",
	desc_red = "VICTIMA DE MOVIMIENTOS CATACLISMICOS DE LA TIERRA"
	
WHERE

	id_ciex_4 = 10494;
	
	
/* X34.1 */
UPDATE

	ciex_4
	
SET

	descripcion = "VICTIMA DE TSUNAMI",
	desc_red = "VICTIMA DE TSUNAMI"
	
WHERE

	id_ciex_4 = 10495;
	
	
/* X34.8 */
UPDATE

	ciex_4
	
SET

	descripcion = "VICTIMA DE OTROS EFECTOS DE TERREMOTO ESPECIFICADOS",
	desc_red = "VICTIMA DE OTROS EFECTOS DE TERREMOTO ESPECIFICADO"
	
WHERE

	id_ciex_4 = 10502;
	
	
/* X34.9 */
UPDATE

	ciex_4
	
SET

	descripcion = "VICTIMA DE EFECTOS DE TERREMOTO NO ESPECIFICADOS",
	desc_red = "VICTIMA DE OTROS EFECTOS DE TERREMOTO NO ESPECIFIC"
	
WHERE

	id_ciex_4 = 10503;
	
	
/* X34.2 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	654,
	
	/* id_ciex_4 */
	10496,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'X34',
	
	/* cod_4dig */
	'2',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);	
	

/* X34.3 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	655,
	
	/* id_ciex_4 */
	10497,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'X34',
	
	/* cod_4dig */
	'3',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);	


/* X34.4 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	656,
	
	/* id_ciex_4 */
	10498,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'X34',
	
	/* cod_4dig */
	'4',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* X34.5 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	657,
	
	/* id_ciex_4 */
	10499,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'X34',
	
	/* cod_4dig */
	'5',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* X34.6 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	658,
	
	/* id_ciex_4 */
	10500,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'X34',
	
	/* cod_4dig */
	'6',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* X34.7 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	659,
	
	/* id_ciex_4 */
	10501,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'X34',
	
	/* cod_4dig */
	'7',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* R65 */
INSERT

	ciex_3
	
VALUES (
	
	/* id_ciex_3 */
	2052,
	
	/* cod_3dig */
	'R65',
	
	/* descripcion */
	'SINDROME DE RESPUESTA INFLAMATORIA SISTEMICA',
	
	/* desc_red */
	'SINDROME DE RESPUESTA INFLAMATORIA SISTEMICA'
	);
	
	
/* R65.0 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12514,
	
	/* id_ciex_3 */
	2052,
	
	/* cod_3dig */
	'R65',
	
	/* cod_4dig */
	'0',
	
	/* descripcion */
	'SINDROME DE RESPUESTA INFLAMATORIA SISTEMICA DE ORIGEN INFECCIOSO, SIN FALLA ORGANICA',
	
	/* desc_red */
	'SINDROME DE RESPUESTA INFLAMATORIA SISTEMICA DE OR',
	
	/* informa_c2 */
	'0'
);


/* R65.1 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12515,
	
	/* id_ciex_3 */
	2052,
	
	/* cod_3dig */
	'R65',
	
	/* cod_4dig */
	'1',
	
	/* descripcion */
	'SINDROME DE RESPUESTA INFLAMATORIA SISTEMICA DE ORIGEN INFECCIOSO, CON FALLA ORGANICA',
	
	/* desc_red */
	'SINDROME DE RESPUESTA INFLAMATORIA SISTEMICA DE OR',
	
	/* informa_c2 */
	'0'
);


/* R65.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12516,
	
	/* id_ciex_3 */
	2052,
	
	/* cod_3dig */
	'R65',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'SINDROME DE RESPUESTA INFLAMATORIA SISTEMICA DE ORIGEN NO INFECCIOSO, SIN FALLA ORGANICA',
	
	/* desc_red */
	'SINDROME DE RESPUESTA INFLAMATORIA SISTEMICA DE OR',
	
	/* informa_c2 */
	'0'
);


/* R65.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12517,
	
	/* id_ciex_3 */
	2052,
	
	/* cod_3dig */
	'R65',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'SINDROME DE RESPUESTA INFLAMATORIA SISTEMICA DE ORIGEN NO INFECCIOSO, CON FALLA ORGANICA',
	
	/* desc_red */
	'SINDROME DE RESPUESTA INFLAMATORIA SISTEMICA DE OR',
	
	/* informa_c2 */
	'0'
);


/* R65.9 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12518,
	
	/* id_ciex_3 */
	2052,
	
	/* cod_3dig */
	'R65',
	
	/* cod_4dig */
	'9',
	
	/* descripcion */
	'SINDROME DE RESPUESTA INFLAMATORIA SISTEMICA, NO ESPECIFICADO',
	
	/* desc_red */
	'SINDROME DE RESPUESTA INFLAMATORIA SISTEMICA, NO E',
	
	/* informa_c2 */
	'0'
);


/* R63.6 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12519,
	
	/* id_ciex_3 */
	1273,
	
	/* cod_3dig */
	'R63',
	
	/* cod_4dig */
	'6',
	
	/* descripcion */
	'INGESTA INSUFICIENTE DE ALIMENTOS Y AGUA DEBIDA A DESCUIDO PERSONAL',
	
	/* desc_red */
	'INGESTA INSUFICIENTE DE ALIMENTOS Y AGUA DEBIDA A',
	
	/* informa_c2 */
	'0'
);


/* R57.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12520,
	
	/* id_ciex_3 */
	1267,
	
	/* cod_3dig */
	'R57',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'CHOQUE SEPTICO',
	
	/* desc_red */
	'CHOQUE SEPTICO',
	
	/* informa_c2 */
	'0'
);


/* R26.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12521,
	
	/* id_ciex_3 */
	1239,
	
	/* cod_3dig */
	'R26',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'INMOVILIDAD',
	
	/* desc_red */
	'INMOVILIDAD',
	
	/* informa_c2 */
	'0'
);


/* P75 */
UPDATE

	ciex_3
	
SET

	descripcion = "ILEO MECONIAL EN LA FIBROSIS QUISTICA (E84.1)",
	desc_red = "ILEO MECONIAL EN LA FIBROSIS QUISTICA (E84.1)"
	
WHERE

	id_ciex_3 = 2040;

/* P75.X */
UPDATE

	ciex_4
	
SET

	descripcion = "ILEO MECONIAL EN LA FIBROSIS QUISTICA (E84.1)",
	desc_red = "ILEO MECONIAL EN LA FIBROSIS QUISTICA (E84.1)"
	
WHERE

	id_ciex_4 =	6203;


/* O98.7 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12522,
	
	/* id_ciex_3 */
	1068,
	
	/* cod_3dig */
	'O98',
	
	/* cod_4dig */
	'7',
	
	/* descripcion */
	'ENFERMEDAD POR INMUNODEFICIENCIA HUMANA [VIH] QUE COMPLICA EL EMBARAZO, EL PARTO Y EL PUERPERIO',
	
	/* desc_red */
	'ENFERMEDAD POR INMUNODEFICIENCIA HUMANA [VIH] QUE',
	
	/* informa_c2 */
	'0'
);


/* O97.X */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	660,
	
	/* id_ciex_4 */
	5909,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'O97',
	
	/* cod_4dig */
	'X',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* O97 */
UPDATE

	ciex_3
	
SET

	descripcion = "MUERTE POR SECUELAS DE CAUSA OBSTETRICAS",
	desc_red = "MUERTE POR SECUELAS DE CAUSA OBSTETRICAS"
	
WHERE

	id_ciex_3 = 1067;
	
	
/* O97.0 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12523,
	
	/* id_ciex_3 */
	1067,
	
	/* cod_3dig */
	'O97',
	
	/* cod_4dig */
	'0',
	
	/* descripcion */
	'MUERTE POR SECUELA DE CAUSA OBSTETRICA DIRECTA',
	
	/* desc_red */
	'MUERTE POR SECUELA DE CAUSA OBSTETRICA DIRECTA',
	
	/* informa_c2 */
	'0'
);


/* O97.1 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12524,
	
	/* id_ciex_3 */
	1067,
	
	/* cod_3dig */
	'O97',
	
	/* cod_4dig */
	'1',
	
	/* descripcion */
	'MUERTE POR SECUELA DE CAUSA OBSTETRICA INDIRECTA',
	
	/* desc_red */
	'MUERTE POR SECUELA DE CAUSA OBSTETRICA INDIRECTA',
	
	/* informa_c2 */
	'0'
);


/* O97.9 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12525,
	
	/* id_ciex_3 */
	1067,
	
	/* cod_3dig */
	'O97',
	
	/* cod_4dig */
	'9',
	
	/* descripcion */
	'MUERTE POR SECUELA DE CAUSA OBSTETRICA NO ESPECIFICADA',
	
	/* desc_red */
	'MUERTE POR SECUELA DE CAUSA OBSTETRICA NO ESPECIFI',
	
	/* informa_c2 */
	'0'
);


/* O96 */
UPDATE

	ciex_3
	
SET

	descripcion = "MUERTE MATERNA DEBIDA A CUALQUIER CAUSA OBSTETRICA QUE OCURRE DESPUES DE 42 DIAS PERO ANTES DE UN AÑO DEL PARTO",
	desc_red = "MUERTE MATERNA DEBIDA A CUALQUIER CAUSA OBSTETRICA"
	
WHERE

	id_ciex_3 = 1066;
	

/* O96.X */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	661,
	
	/* id_ciex_4 */
	5908,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'O96',
	
	/* cod_4dig */
	'X',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* O96.0 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12526,
	
	/* id_ciex_3 */
	1066,
	
	/* cod_3dig */
	'O96',
	
	/* cod_4dig */
	'0',
	
	/* descripcion */
	'MUERTE POR CAUSA OBSTETRICA DIRECTA QUE OCURRE DESPUES DE 42 DIAS PERO ANTES DE UN AÑO DEL PARTO',
	
	/* desc_red */
	'MUERTE POR CAUSA OBSTETRICA DIRECTA QUE OCURRE DES',
	
	/* informa_c2 */
	'0'
);


/* O96.1 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12527,
	
	/* id_ciex_3 */
	1066,
	
	/* cod_3dig */
	'O96',
	
	/* cod_4dig */
	'1',
	
	/* descripcion */
	'MUERTE POR CAUSA OBSTETRICA INDIRECTA QUE OCURRE DESPUES DE 42 DIAS PERO ANTES DE UN AÑO DEL PARTO',
	
	/* desc_red */
	'MUERTE POR CAUSA OBSTETRICA INDIRECTA QUE OCURRE D',
	
	/* informa_c2 */
	'0'
);


/* O96.9 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12528,
	
	/* id_ciex_3 */
	1066,
	
	/* cod_3dig */
	'O96',
	
	/* cod_4dig */
	'9',
	
	/* descripcion */
	'MUERTE POR CAUSA OBSTETRICA NO ESPECIFICADA, QUE OCURRE DESPUES DE 42 DIAS PERO ANTES DE UN AÑO DEL PARTO',
	
	/* desc_red */
	'MUERTE POR CAUSA OBSTETRICA NO ESPECIFICADA, QUE O',
	
	/* informa_c2 */
	'0'
);

/* O87 */
UPDATE
	
	ciex_3
	
SET

	descripcion = "COMPLICACIONES VENOSAS Y HEMORROIDES EN EL PUERPERIO",
	desc_red = "COMPLICACIONES VENOSAS Y HEMORROIDES EN EL PUERPER"
	
WHERE

	id_ciex_3 = 1058;
	

/* O71.4 */
UPDATE
	
	ciex_4
	
SET

	descripcion = "DESGARRO VAGINAL OBSTETRICO ALTO",
	desc_red = "DESGARRO VAGINAL OBSTETRICO ALTO"
	
WHERE

	id_ciex_4 = 5801;


/* O69.2 */
UPDATE
	
	ciex_4
	
SET

	descripcion = "TRABAJO DE PARTO Y PARTO COMPLICADOS POR OTROS ENREDOS DEL CORDON UMBILICAL CON COMPRESION",
	desc_red = "TRABAJO DE PARTO Y PARTO COMPLICADOS POR OTROS ENR"
	
WHERE

	id_ciex_4 = 5786;

/* O60 */
UPDATE
	
	ciex_3
	
SET

	descripcion = "TRABAJO DE PARTO PREMATURO Y PARTO",
	desc_red = "TRABAJO DE PARTO PREMATURO Y PARTO"
	
WHERE

	id_ciex_3 = 1035;
	
	
/* O60.X */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	662,
	
	/* id_ciex_4 */
	5735,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'O60',
	
	/* cod_4dig */
	'X',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2006-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* O60.1 */
UPDATE
	
	ciex_4
	
SET

	descripcion = "TRABAJO DE PARTO PREMATURO ESPONTANEO CON PARTO PREMATURO",
	desc_red = "TRABAJO DE PARTO PREMATURO ESPONTANEO CON PARTO PR"
	
WHERE

	id_ciex_4 = 5733;


/* O60.2 */
UPDATE
	
	ciex_4
	
SET

	descripcion = "TRABAJO DE PARTO PREMATURO ESPONTANEO CON PARTO A TERMINO",
	desc_red = "TRABAJO DE PARTO PREMATURO ESPONTANEO CON PARTO A"
	
WHERE

	id_ciex_4 = 5734;
	
	
/* O60.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12529,
	
	/* id_ciex_3 */
	1035,
	
	/* cod_3dig */
	'O60',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'PARTO PREMATURO SIN TRABAJO DE PARTO ESPONTANEO',
	
	/* desc_red */
	'PARTO PREMATURO SIN TRABAJO DE PARTO ESPONTANEO',
	
	/* informa_c2 */
	'0'
);


/* O43.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12530,
	
	/* id_ciex_3 */
	1029,
	
	/* cod_3dig */
	'O43',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'PLACENTA ANORMALMENTE ADHERIDA',
	
	/* desc_red */
	'PLACENTA ANORMALMENTE ADHERIDA',
	
	/* informa_c2 */
	'0'
);


/* O22 */
UPDATE

	ciex_3
	
SET

	descripcion = "COMPLICACIONES VENOSAS Y HEMORROIDES EN EL EMBARAZO",
	desc_red = "COMPLICACIONES VENOSAS Y HEMORROIDES EN EL EMBARAZ"
	
WHERE

	id_ciex_3 = 1012;
	

/* O14 */
UPDATE

	ciex_3
	
SET

	descripcion = "PREECLAMPSIA",
	desc_red = "PREECLAMPSIA"
	
WHERE

	id_ciex_3 = 1007;
	
	
/* O14.0 */
UPDATE

	ciex_4
	
SET

	descripcion = "PREECLAMPSIA LEVE A MODERADA",
	desc_red = "PREECLAMPSIA LEVE A MODERADA"
	
WHERE

	id_ciex_4 = 5584;


/* O14.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12531,
	
	/* id_ciex_3 */
	1007,
	
	/* cod_3dig */
	'O14',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'SINDROME HELLP',
	
	/* desc_red */
	'SINDROME HELLP',
	
	/* informa_c2 */
	'0'
);


/* O13 */
UPDATE

	ciex_3
	
SET

	descripcion = "HIPERTENSION GESTACIONAL (INDUCIDA POR EL EMBARAZO)",
	desc_red = "HIPERTENSION GESTACIONAL (INDUCIDA POR EL EMBARAZO"
	
WHERE

	id_ciex_3 = 1006;
	
	
/* O11 */
UPDATE

	ciex_3
	
SET

	descripcion = "PREECLAMPSIA SUPERPUESTA EN HIPERTENSION CRONICA",
	desc_red = "PREECLAMPSIA SUPERPUESTA EN HIPERTENSION CRONICA"
	
WHERE

	id_ciex_3 = 1004;


/* N42.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12532,
	
	/* id_ciex_3 */
	954,
	
	/* cod_3dig */
	'N42',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'DISPLASIA DE LA PROSTATA',
	
	/* desc_red */
	'DISPLASIA DE LA PROSTATA',
	
	/* informa_c2 */
	'0'
);


/* N18 */
UPDATE

	ciex_3
	
SET

	descripcion = "ENFERMEDAD RENAL CRONICA",
	desc_red = "ENFERMEDAD RENAL CRONICA"
	
WHERE

	id_ciex_3 = 936;
	
	
/* N18.9 */
UPDATE

	ciex_4
	
SET

	descripcion = "ENFERMEDAD RENAL CRONICA, NO ESPECIFICADA",
	desc_red = "ENFERMEDAD RENAL CRONICA, NO ESPECIFICADA"
	
WHERE

	id_ciex_4 = 5193;
	
	
/* N18.0 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	663,
	
	/* id_ciex_4 */
	5191,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'N18',
	
	/* cod_4dig */
	'0',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);

/* N18.1 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12533,
	
	/* id_ciex_3 */
	936,
	
	/* cod_3dig */
	'N18',
	
	/* cod_4dig */
	'1',
	
	/* descripcion */
	'ENFERMEDAD RENAL CRONICA, ETAPA 1',
	
	/* desc_red */
	'ENFERMEDAD RENAL CRONICA, ETAPA 1',
	
	/* informa_c2 */
	'0'
);


/* N18.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12534,
	
	/* id_ciex_3 */
	936,
	
	/* cod_3dig */
	'N18',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'ENFERMEDAD RENAL CRONICA, ETAPA 2',
	
	/* desc_red */
	'ENFERMEDAD RENAL CRONICA, ETAPA 2',
	
	/* informa_c2 */
	'0'
);


/* N18.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12535,
	
	/* id_ciex_3 */
	936,
	
	/* cod_3dig */
	'N18',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'ENFERMEDAD RENAL CRONICA, ETAPA 3',
	
	/* desc_red */
	'ENFERMEDAD RENAL CRONICA, ETAPA 3',
	
	/* informa_c2 */
	'0'
);


/* N18.4 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12536,
	
	/* id_ciex_3 */
	936,
	
	/* cod_3dig */
	'N18',
	
	/* cod_4dig */
	'4',
	
	/* descripcion */
	'ENFERMEDAD RENAL CRONICA, ETAPA 4',
	
	/* desc_red */
	'ENFERMEDAD RENAL CRONICA, ETAPA 4',
	
	/* informa_c2 */
	'0'
);


/* N18.5 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12537,
	
	/* id_ciex_3 */
	936,
	
	/* cod_3dig */
	'N18',
	
	/* cod_4dig */
	'5',
	
	/* descripcion */
	'ENFERMEDAD RENAL CRONICA, ETAPA 5',
	
	/* desc_red */
	'ENFERMEDAD RENAL CRONICA, ETAPA 5',
	
	/* informa_c2 */
	'0'
);


/* N18.8 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	664,
	
	/* id_ciex_4 */
	5192,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'N18',
	
	/* cod_4dig */
	'8',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* M10.3 */
UPDATE

	ciex_4
	
SET

	descripcion = "GOTA DEBIDA A ALTERACION DE LA FUNCION RENAL",
	desc_red = "GOTA DEBIDA A ALTERACION DE LA FUNCION RENAL"
	
WHERE

	id_ciex_4 = 4578;
	

/* L91.0 */
UPDATE

	ciex_4
	
SET

	descripcion = "CICATRIZ HIPERTROFICA",
	desc_red = "CICATRIZ HIPERTROFICA"
	
WHERE

	id_ciex_4 = 4484;


/* L89 */
UPDATE

	ciex_3
	
SET

	descripcion = "ULCERA DE DECUBITO Y POR AREA DE PRESION",
	desc_red = "ULCERA DE DECUBITO Y POR AREA DE PRESION"
	
WHERE

	id_ciex_3 = 845;


/* L89.X */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	665,
	
	/* id_ciex_4 */
	4474,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'L89',
	
	/* cod_4dig */
	'X',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* L89.0 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12538,
	
	/* id_ciex_3 */
	845,
	
	/* cod_3dig */
	'L89',
	
	/* cod_4dig */
	'0',
	
	/* descripcion */
	'ULCERA DE DECUBITO Y POR AREA DE PRESION, ETAPA I',
	
	/* desc_red */
	'ULCERA DE DECUBITO Y POR AREA DE PRESION, ETAPA I',
	
	/* informa_c2 */
	'0'
);


/* L89.1 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12539,
	
	/* id_ciex_3 */
	845,
	
	/* cod_3dig */
	'L89',
	
	/* cod_4dig */
	'1',
	
	/* descripcion */
	'ULCERA DE DECUBITO, ETAPA II',
	
	/* desc_red */
	'ULCERA DE DECUBITO, ETAPA II',
	
	/* informa_c2 */
	'0'
);


/* L89.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12540,
	
	/* id_ciex_3 */
	845,
	
	/* cod_3dig */
	'L89',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'ULCERA DE DECUBITO, ETAPA III',
	
	/* desc_red */
	'ULCERA DE DECUBITO, ETAPA III',
	
	/* informa_c2 */
	'0'
);


/* L89.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12541,
	
	/* id_ciex_3 */
	845,
	
	/* cod_3dig */
	'L89',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'ULCERA DE DECUBITO, ETAPA IV',
	
	/* desc_red */
	'ULCERA DE DECUBITO, ETAPA IV',
	
	/* informa_c2 */
	'0'
);


/* L89.9 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12542,
	
	/* id_ciex_3 */
	845,
	
	/* cod_3dig */
	'L89',
	
	/* cod_4dig */
	'9',
	
	/* descripcion */
	'ULCERA DE DECUBITO Y POR AREA DE PRESION, NO ESPECIFICADA',
	
	/* desc_red */
	'ULCERA DE DECUBITO Y POR AREA DE PRESION, NO ESPEC',
	
	/* informa_c2 */
	'0'
);


/* L41.2 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	666,
	
	/* id_ciex_4 */
	4303,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'L41',
	
	/* cod_4dig */
	'2',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* K64 */
INSERT

	ciex_3
	
VALUES (
	
	/* id_ciex_3 */
	2053,
	
	/* cod_3dig */
	'K64',
	
	/* descripcion */
	'HEMORROIDES Y TROMBOSIS VENOSA PERIANAL',
	
	/* desc_red */
	'HEMORROIDES Y TROMBOSIS VENOSA PERIANAL'
	);


/* K64 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	667,
	
	/* id_ciex_4 */
	NULL,
	
	/* id_ciex_3 */
	2053,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K64',
	
	/* cod_4dig */
	NULL,
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* K64.0 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12543,
	
	/* id_ciex_3 */
	2053,
	
	/* cod_3dig */
	'K64',
	
	/* cod_4dig */
	'0',
	
	/* descripcion */
	'HEMORROIDES DE PRIMER GRADO',
	
	/* desc_red */
	'HEMORROIDES DE PRIMER GRADO',
	
	/* informa_c2 */
	'0'
);


/* K64.1 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12544,
	
	/* id_ciex_3 */
	2053,
	
	/* cod_3dig */
	'K64',
	
	/* cod_4dig */
	'1',
	
	/* descripcion */
	'HEMORROIDES DE SEGUNDO GRADO',
	
	/* desc_red */
	'HEMORROIDES DE SEGUNDO GRADO',
	
	/* informa_c2 */
	'0'
);


/* K64.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12545,
	
	/* id_ciex_3 */
	2053,
	
	/* cod_3dig */
	'K64',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'HEMORROIDES DE TERCER GRADO',
	
	/* desc_red */
	'HEMORROIDES DE TERCER GRADO',
	
	/* informa_c2 */
	'0'
);


/* K64.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12546,
	
	/* id_ciex_3 */
	2053,
	
	/* cod_3dig */
	'K64',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'HEMORROIDES DE CUARTO GRADO',
	
	/* desc_red */
	'HEMORROIDES DE CUARTO GRADO',
	
	/* informa_c2 */
	'0'
);


/* K64.4 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12547,
	
	/* id_ciex_3 */
	2053,
	
	/* cod_3dig */
	'K64',
	
	/* cod_4dig */
	'4',
	
	/* descripcion */
	'MARCAS RESIDUALES EN LA PIEL, DE HEMORROIDES',
	
	/* desc_red */
	'MARCAS RESIDUALES EN LA PIEL, DE HEMORROIDES',
	
	/* informa_c2 */
	'0'
);


/* K64.5 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12548,
	
	/* id_ciex_3 */
	2053,
	
	/* cod_3dig */
	'K64',
	
	/* cod_4dig */
	'5',
	
	/* descripcion */
	'TROMBOSIS VENOSA PERIANAL',
	
	/* desc_red */
	'TROMBOSIS VENOSA PERIANAL',
	
	/* informa_c2 */
	'0'
);


/* K64.8 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12549,
	
	/* id_ciex_3 */
	2053,
	
	/* cod_3dig */
	'K64',
	
	/* cod_4dig */
	'8',
	
	/* descripcion */
	'OTRAS HEMORROIDES ESPECIFICADAS',
	
	/* desc_red */
	'OTRAS HEMORROIDES ESPECIFICADAS',
	
	/* informa_c2 */
	'0'
);


/* K64.9 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12550,
	
	/* id_ciex_3 */
	2053,
	
	/* cod_3dig */
	'K64',
	
	/* cod_4dig */
	'9',
	
	/* descripcion */
	'HEMORROIDES, SIN OTRA ESPECIFICACION',
	
	/* desc_red */
	'HEMORROIDES, SIN OTRA ESPECIFICACION',
	
	/* informa_c2 */
	'0'
);


/* K55-K64 */
UPDATE

	ciex_titulos
	
SET

	id_ciex_3_hasta = 2053,
	cod_3dig_hasta = 'K64'
	
WHERE

	id_ciex_titulo = 128;
	
	
/* K52.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12551,
	
	/* id_ciex_3 */
	760,
	
	/* cod_3dig */
	'K52',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'COLITIS DE ETIOLOGIA INDETERMINADO',
	
	/* desc_red */
	'COLITIS DE ETIOLOGIA INDETERMINADO',
	
	/* informa_c2 */
	'0'
);


/* K52.3 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	668,
	
	/* id_ciex_4 */
	12551,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K52',
	
	/* cod_4dig */
	'3',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);

/* K51.0 */
UPDATE

	ciex_4
	
SET

	descripcion = 'PANCOLITIS ULCERATIVA (CRONICA)',
	desc_red = 'PANCOLITIS ULCERATIVA (CRONICA)'

WHERE

	id_ciex_4 = 3986;
	

/* K51.1 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	669,
	
	/* id_ciex_4 */
	3987,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K51',
	
	/* cod_4dig */
	'1',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* K51.4 */
UPDATE

	ciex_4
	
SET

	descripcion = 'POLIPOS INFLAMATORIOS',
	desc_red = 'POLIPOS INFLAMATORIOS'

WHERE

	id_ciex_4 = 3990;


/* K51.5 */
UPDATE

	ciex_4
	
SET

	descripcion = 'COLITIS DEL LADO IZQUIERDO',
	desc_red = 'COLITIS DEL LADO IZQUIERDO'

WHERE

	id_ciex_4 = 3991;
	

/* K43.9 */
UPDATE

	ciex_4
	
SET

	descripcion = 'OTRAS HERNIAS VENTRALES Y LAS NO ESPECIFICADAS SIN OBSTRUCCION O GANGRENA',
	desc_red = 'OTRAS HERNIAS VENTRALES Y LAS NO ESPECIFICADAS SIN'

WHERE

	id_ciex_4 = 3972;


/* K43.7 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12552,
	
	/* id_ciex_3 */
	754,
	
	/* cod_3dig */
	'K43',
	
	/* cod_4dig */
	'7',
	
	/* descripcion */
	'OTRAS HERNIAS VENTRALES Y LAS NO ESPECIFICADAS CON GANGRENA',
	
	/* desc_red */
	'OTRAS HERNIAS VENTRALES Y LAS NO ESPECIFICADAS CON',
	
	/* informa_c2 */
	'0'
);


/* K43.7 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	670,
	
	/* id_ciex_4 */
	12552,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K43',
	
	/* cod_4dig */
	'7',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* K43.1 */
UPDATE

	ciex_4
	
SET

	descripcion = 'HERNIA INCISIONAL CON GANGRENA',
	desc_red = 'HERNIA INCISIONAL CON GANGRENA'

WHERE

	id_ciex_4 = 3971;


/* K43.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12553,
	
	/* id_ciex_3 */
	754,
	
	/* cod_3dig */
	'K43',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'HERNIA INCISIONAL SIN OBSTRUCCION O GANGRENA',
	
	/* desc_red */
	'HERNIA INCISIONAL SIN OBSTRUCCION O GANGRENA',
	
	/* informa_c2 */
	'0'
);


/* K43.2 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	671,
	
	/* id_ciex_4 */
	12553,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K43',
	
	/* cod_4dig */
	'2',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* K43.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12554,
	
	/* id_ciex_3 */
	754,
	
	/* cod_3dig */
	'K43',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'HERNIA PARAESTOMAL CON OBSTRUCCION, SIN GANGRENA',
	
	/* desc_red */
	'HERNIA PARAESTOMAL CON OBSTRUCCION, SIN GANGRENA',
	
	/* informa_c2 */
	'0'
);


/* K43.3 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	672,
	
	/* id_ciex_4 */
	12554,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K43',
	
	/* cod_4dig */
	'3',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* K43.4 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12555,
	
	/* id_ciex_3 */
	754,
	
	/* cod_3dig */
	'K43',
	
	/* cod_4dig */
	'4',
	
	/* descripcion */
	'HERNIA PARAESTOMAL CON GANGRENA',
	
	/* desc_red */
	'HERNIA PARAESTOMAL CON GANGRENA',
	
	/* informa_c2 */
	'0'
);


/* K43.4 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	673,
	
	/* id_ciex_4 */
	12555,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K43',
	
	/* cod_4dig */
	'4',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* K43.5 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12556,
	
	/* id_ciex_3 */
	754,
	
	/* cod_3dig */
	'K43',
	
	/* cod_4dig */
	'5',
	
	/* descripcion */
	'HERNIA PARAESTOMAL SIN OBSTRUCCION O GANGRENA',
	
	/* desc_red */
	'HERNIA PARAESTOMAL SIN OBSTRUCCION O GANGRENA',
	
	/* informa_c2 */
	'0'
);


/* K43.5 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	674,
	
	/* id_ciex_4 */
	12556,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K43',
	
	/* cod_4dig */
	'5',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* K43.6 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12557,
	
	/* id_ciex_3 */
	754,
	
	/* cod_3dig */
	'K43',
	
	/* cod_4dig */
	'6',
	
	/* descripcion */
	'OTRAS HERNIAS VENTRALES Y LAS NOS ESPECIFICADAS CON OBSTRUCCION, SIN GANGRENA',
	
	/* desc_red */
	'OTRAS HERNIAS VENTRALES Y LAS NOS ESPECIFICADAS CO',
	
	/* informa_c2 */
	'0'
);


/* K43.6 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	675,
	
	/* id_ciex_4 */
	12557,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K43',
	
	/* cod_4dig */
	'6',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* K43.0 */
UPDATE

	ciex_4
	
SET

	descripcion = 'HERNIA INCISIONAL CON OBSTRUCCION, SIN GANGRENA',
	desc_red = 'HERNIA INCISIONAL CON OBSTRUCCION, SIN GANGRENA'

WHERE

	id_ciex_4 = 3970;
	

/* K35.0 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	676,
	
	/* id_ciex_4 */
	3944,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K35',
	
	/* cod_4dig */
	'0',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);	
	

/* K35.1 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	677,
	
	/* id_ciex_4 */
	3945,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K35',
	
	/* cod_4dig */
	'1',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* K35.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12558,
	
	/* id_ciex_3 */
	747,
	
	/* cod_3dig */
	'K35',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'APENDICITIS AGUDA CON PERITONITIS GENERALIZADA',
	
	/* desc_red */
	'APENDICITIS AGUDA CON PERITONITIS GENERALIZADA',
	
	/* informa_c2 */
	'0'
);


/* K35.2 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	678,
	
	/* id_ciex_4 */
	12558,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K35',
	
	/* cod_4dig */
	'2',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* K35.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12559,
	
	/* id_ciex_3 */
	747,
	
	/* cod_3dig */
	'K35',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'APENDICITIS AGUDA CON PERITONITIS LOCALIZADA',
	
	/* desc_red */
	'APENDICITIS AGUDA CON PERITONITIS LOCALIZADA',
	
	/* informa_c2 */
	'0'
);


/* K35.3 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	679,
	
	/* id_ciex_4 */
	12559,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K35',
	
	/* cod_4dig */
	'3',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* K35.8 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12560,
	
	/* id_ciex_3 */
	747,
	
	/* cod_3dig */
	'K35',
	
	/* cod_4dig */
	'8',
	
	/* descripcion */
	'OTRAS APENDICITIS AGUDAS, Y LAS NO ESPECIFICADAS',
	
	/* desc_red */
	'OTRAS APENDICITIS AGUDAS, Y LAS NO ESPECIFICADAS',
	
	/* informa_c2 */
	'0'
);


/* K35.8 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	680,
	
	/* id_ciex_4 */
	12560,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K35',
	
	/* cod_4dig */
	'8',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* K35.9 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	681,
	
	/* id_ciex_4 */
	3946,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K35',
	
	/* cod_4dig */
	'9',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* K30 */
UPDATE
	
	ciex_3
	
SET

	descripcion = 'DISPEPSIA FUNCIONAL',
	desc_red = 'DISPEPSIA FUNCIONAL'

WHERE 

	id_ciex_3 = 745;


/* K12.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12561,
	
	/* id_ciex_3 */
	734,
	
	/* cod_3dig */
	'K12',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'MUCOSITIS ORAL (ULCERATIVA)',
	
	/* desc_red */
	'MUCOSITIS ORAL (ULCERATIVA)',
	
	/* informa_c2 */
	'0'
);


/* K12.3 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	682,
	
	/* id_ciex_4 */
	12561,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K12',
	
	/* cod_4dig */
	'3',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* K09.1 */
UPDATE

	ciex_4
	
SET

	descripcion = 'QUISTES DE LAS FISURAS DE LA REGION ORAL (NO ODONTOGENICOS)',
	desc_red = 'QUISTES DE LAS FISURAS DE LA REGION ORAL (NO ODONT'

WHERE

	id_ciex_4 = 3832;


/* K02.5 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12562,
	
	/* id_ciex_3 */
	724,
	
	/* cod_3dig */
	'K02',
	
	/* cod_4dig */
	'5',
	
	/* descripcion */
	'CARIES CON EXPOSICION PULṔAR',
	
	/* desc_red */
	'CARIES CON EXPOSICION PULṔAR',
	
	/* informa_c2 */
	'0'
);


/* K02.5 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	683,
	
	/* id_ciex_4 */
	12562,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'K02',
	
	/* cod_4dig */
	'5',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* J21.1 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12563,
	
	/* id_ciex_3 */
	678,
	
	/* cod_3dig */
	'J21',
	
	/* cod_4dig */
	'1',
	
	/* descripcion */
	'BRONQUIOLITIS AGUDA DEBIDA A METANEUMOVIRUS HUMANO',
	
	/* desc_red */
	'BRONQUIOLITIS AGUDA DEBIDA A METANEUMOVIRUS HUMANO',
	
	/* informa_c2 */
	'0'
);


/* K21.1 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	684,
	
	/* id_ciex_4 */
	12563,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'J21',
	
	/* cod_4dig */
	'1',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* J12.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12564,
	
	/* id_ciex_3 */
	671,
	
	/* cod_3dig */
	'J12',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'NEUMONIA DEBIDA A METANEUMOVIRUS HUMANO',
	
	/* desc_red */
	'NEUMONIA DEBIDA A METANEUMOVIRUS HUMANO',
	
	/* informa_c2 */
	'0'
);


/* K12.3 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	685,
	
	/* id_ciex_4 */
	12564,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'J12',
	
	/* cod_4dig */
	'3',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* J09 */
UPDATE

	ciex_3
	
SET

	descripcion = 'INFLUENZA DEBIDA A CIERTOS VIRUS DE LA INFLUENZA IDENTIFICADOS',
	desc_red = 'INFLUENZA DEBIDA A CIERTOS VIRUS DE LA INFLUENZA I'
	
WHERE

	id_ciex_3 = 668;
	
	
/* I98.2* */
UPDATE

	ciex_4
	
SET

	descripcion = 'VARICES ESOFAGICAS SIN HEMORRAGIA EN ENFERMEDADES CLASIFICADAS EN OTRA PARTE',
	desc_red = 'VARICES ESOFAGICAS SIN HEMORRAGIA EN ENFERMEDADES'
	
WHERE

	id_ciex_4 = 3530;


/* I98.3* */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12565,
	
	/* id_ciex_3 */
	2004,
	
	/* cod_3dig */
	'I98',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'VARICES ESOFAGICAS CON HEMORRAGIA EN ENFERMEDADES CLASIFICADAS EN OTRA PARTE',
	
	/* desc_red */
	'VARICES ESOFAGICAS CON HEMORRAGIA EN ENFERMEDADES',
	
	/* informa_c2 */
	'0'
);


/* I87.0 */
UPDATE

	ciex_4
	
SET

	descripcion = 'SINDROME POSTROMBOTICO',
	desc_red = 'SINDROME POSTROMBOTICO'
	
WHERE

	id_ciex_4 = 3505;

/* I84 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	686,
	
	/* id_ciex_4 */
	NULL,
	
	/* id_ciex_3 */
	652,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'I84',
	
	/* cod_4dig */
	NULL,
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* I72.6 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12566,
	
	/* id_ciex_3 */
	643,
	
	/* cod_3dig */
	'I72',
	
	/* cod_4dig */
	'6',
	
	/* descripcion */
	'ANEURISMA Y DISECCION DE ARTERIA VERTEBRAL',
	
	/* desc_red */
	'ANEURISMA Y DISECCION DE ARTERIA VERTEBRAL',
	
	/* informa_c2 */
	'0'
);


/* I72.6 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	687,
	
	/* id_ciex_4 */
	12566,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'I72',
	
	/* cod_4dig */
	'6',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* I72 */
UPDATE

	ciex_3
	
SET

	descripcion = 'OTROS ANEURISMAS Y ANEURISMAS DISECANTES',
	desc_red = 'OTROS ANEURISMAS Y ANEURISMAS DISECANTES'
	
WHERE

	id_ciex_3 = 643;
	
	
/* I72.0 */
UPDATE

	ciex_4
	
SET

	descripcion = 'ANEURISMA Y DISECCION DE LA ARTERIA CAROTIDA',
	desc_red = 'ANEURISMA Y DISECCION DE LA ARTERIA CAROTIDA'
	
WHERE

	id_ciex_4 = 3434;


/* I72.1 */
UPDATE

	ciex_4
	
SET

	descripcion = 'ANEURISMA Y DISECCION DE ARTERIA DEL MIEMBRO SUPERIOR',
	desc_red = 'ANEURISMA Y DISECCION DE ARTERIA DEL MIEMBRO SUPER'
	
WHERE

	id_ciex_4 = 3435;
	
	
/* I72.2 */
UPDATE

	ciex_4
	
SET

	descripcion = 'ANEURISMA Y DISECCION DE ARTERIA RENAL',
	desc_red = 'ANEURISMA Y DISECCION DE ARTERIA DEL RENAL'
	
WHERE

	id_ciex_4 = 3436;
	
	
/* I72.3 */
UPDATE

	ciex_4
	
SET

	descripcion = 'ANEURISMA Y DISECCION DE ARTERIA ILIACA',
	desc_red = 'ANEURISMA Y DISECCION DE ARTERIA ILIACA'
	
WHERE

	id_ciex_4 = 3437;
	
	
/* I72.4 */
UPDATE

	ciex_4
	
SET

	descripcion = 'ANEURISMA Y DISECCION DE ARTERIA DEL MIEMBRO INFERIOR',
	desc_red = 'ANEURISMA Y DISECCION DE ARTERIA DEL MI'
	
WHERE

	id_ciex_4 = 3438;


/* I72.5 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12567,
	
	/* id_ciex_3 */
	643,
	
	/* cod_3dig */
	'I72',
	
	/* cod_4dig */
	'5',
	
	/* descripcion */
	'ANEURISMA Y DISECCION DE OTRAS ARTERIAS PRECEREBRALES',
	
	/* desc_red */
	'ANEURISMA Y DISECCION DE OTRAS ARTERIAS PRECEREBRA',
	
	/* informa_c2 */
	'0'
);


/* I72.5 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	688,
	
	/* id_ciex_4 */
	12567,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'I72',
	
	/* cod_4dig */
	'5',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* I72.8 */
UPDATE

	ciex_4
	
SET

	descripcion = 'ANEURISMA Y DISECCION DE OTRAS ARTERIAS ESPECIFICADAS',
	desc_red = 'ANEURISMA Y DISECCION DE OTRAS ARTERIAS ESPECIFICA'
	
WHERE

	id_ciex_4 = 3439;
	
	
/* I72.9 */
UPDATE

	ciex_4
	
SET

	descripcion = 'ANEURISMA Y DISECCION DE SITIO NO ESPECIFICADO',
	desc_red = 'ANEURISMA Y DISECCION DE SITIO NO ESPECIFICADO'
	
WHERE

	id_ciex_4 = 3440;


/* I48.X */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	689,
	
	/* id_ciex_4 */
	3330,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'I48',
	
	/* cod_4dig */
	'X',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* I48.0 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12568,
	
	/* id_ciex_3 */
	628,
	
	/* cod_3dig */
	'I48',
	
	/* cod_4dig */
	'0',
	
	/* descripcion */
	'FIBRILACION AURICULAR PAROXISTICA',
	
	/* desc_red */
	'FIBRILACION AURICULAR PAROXISTICA',
	
	/* informa_c2 */
	'0'
);


/* I48.0 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	690,
	
	/* id_ciex_4 */
	12568,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'I48',
	
	/* cod_4dig */
	'0',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* I48.1 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12569,
	
	/* id_ciex_3 */
	628,
	
	/* cod_3dig */
	'I48',
	
	/* cod_4dig */
	'1',
	
	/* descripcion */
	'FIBRILACION AURICULAR PERSISTENTE',
	
	/* desc_red */
	'FIBRILACION AURICULAR PERSISTENTE',
	
	/* informa_c2 */
	'0'
);


/* I48.1 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	691,
	
	/* id_ciex_4 */
	12569,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'I48',
	
	/* cod_4dig */
	'1',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* I48.2 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12570,
	
	/* id_ciex_3 */
	628,
	
	/* cod_3dig */
	'I48',
	
	/* cod_4dig */
	'2',
	
	/* descripcion */
	'FIBRILACION AURICULAR CRONICA',
	
	/* desc_red */
	'FIBRILACION AURICULAR CRONICA',
	
	/* informa_c2 */
	'0'
);


/* I48.2 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	692,
	
	/* id_ciex_4 */
	12570,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'I48',
	
	/* cod_4dig */
	'2',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* I48.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12571,
	
	/* id_ciex_3 */
	628,
	
	/* cod_3dig */
	'I48',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'ALETEO AURICULAR TIPICO',
	
	/* desc_red */
	'ALETEO AURICULAR TIPICO',
	
	/* informa_c2 */
	'0'
);


/* I48.3 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	693,
	
	/* id_ciex_4 */
	12571,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'I48',
	
	/* cod_4dig */
	'3',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* I48.4 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12572,
	
	/* id_ciex_3 */
	628,
	
	/* cod_3dig */
	'I48',
	
	/* cod_4dig */
	'4',
	
	/* descripcion */
	'ALETEO AURICULAR ATIPICO',
	
	/* desc_red */
	'ALETEO AURICULAR ATIPICO',
	
	/* informa_c2 */
	'0'
);


/* I48.4 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	694,
	
	/* id_ciex_4 */
	12572,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'I48',
	
	/* cod_4dig */
	'4',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* I48.9 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12573,
	
	/* id_ciex_3 */
	628,
	
	/* cod_3dig */
	'I48',
	
	/* cod_4dig */
	'9',
	
	/* descripcion */
	'FIBRILACION Y ALETEO AURICULAR, NO ESPECIFICADO',
	
	/* desc_red */
	'FIBRILACION Y ALETEO AURICULAR, NO ESPECIFICADO',
	
	/* informa_c2 */
	'0'
);


/* I48.9 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	695,
	
	/* id_ciex_4 */
	12573,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'I48',
	
	/* cod_4dig */
	'9',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* H59.0 */
UPDATE

	ciex_4
	
SET
	
	descripcion = 'QUERATOPATIA (BULLOSA AFAQUICA) CONSECUTIVA A CIRUGIA DE CATARATA',
	desc_red = 'QUERATOPATIA (BULLOSA AFAQUICA) CONSECUTIVA A CIRU'
	
WHERE

	id_ciex_4 = 3033;
	

/* H54.5 */
UPDATE

	ciex_4
	
SET
	
	descripcion = 'DEFICIENCIA VISUAL SEVERA, MONOCULAR',
	desc_red = 'DEFICIENCIA VISUAL SEVERA, MONOCULAR'
	
WHERE

	id_ciex_4 = 3022;	


/* H54.6 */
UPDATE

	ciex_4
	
SET
	
	descripcion = 'DEFICIENCIA VISUAL MODERADA, MONOCULAR',
	desc_red = 'DEFICIENCIA VISUAL MODERADA, MONOCULAR'
	
WHERE

	id_ciex_4 = 3023;
	
	
/* H54.7 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	696,
	
	/* id_ciex_4 */
	3024,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'H54',
	
	/* cod_4dig */
	'7',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* H54.9 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12574,
	
	/* id_ciex_3 */
	569,
	
	/* cod_3dig */
	'H54',
	
	/* cod_4dig */
	'9',
	
	/* descripcion */
	'DEFICIENCIA VISUAL NO ESPECIFICADAD (BINOCULAR)',
	
	/* desc_red */
	'DEFICIENCIA VISUAL NO ESPECIFICADAD (BINOCULAR)',
	
	/* informa_c2 */
	'0'
);


/* H54.9 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	697,
	
	/* id_ciex_4 */
	12574,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'H54',
	
	/* cod_4dig */
	'9',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* H54 */
UPDATE

	ciex_3
	
SET
	
	descripcion = 'CEGUERA Y DEFICIENCIA VISUAL (BINOCULAR O MONOCULAR)',
	desc_red = 'CEGUERA Y DEFICIENCIA VISUAL (BINOCULAR'
	
WHERE

	id_ciex_3 = 569;
	
	
/* H54.0 */
UPDATE

	ciex_4
	
SET
	
	descripcion = 'CEGUERA BINOCULAR',
	desc_red = 'CEGUERA BINOCULAR'
	
WHERE

	id_ciex_4 = 3017;
	
	
/* H54.1 */
UPDATE

	ciex_4
	
SET
	
	descripcion = 'DEFICIENCIA VISUAL SEVERA, BINOCULAR',
	desc_red = 'DEFICIENCIA VISUAL SEVERA, BINOCULAR'
	
WHERE

	id_ciex_4 = 3018;
	
	
/* H54.2 */
UPDATE

	ciex_4
	
SET
	
	descripcion = 'DEFICIENCIA VISUAL MODERADA, BINOCULAR',
	desc_red = 'DEFICIENCIA VISUAL MODERADA, BINOCULAR'
	
WHERE

	id_ciex_4 = 3019;
	
	
/* H54.3 */
UPDATE

	ciex_4
	
SET
	
	descripcion = 'DEFICIENCIA VISUAL LEVE O AUSENTE, BINOCULAR',
	desc_red = 'DEFICIENCIA VISUAL LEVE O AUSENTE, BINOCULAR'
	
WHERE

	id_ciex_4 = 3020;
	
	
/* H54.3 */
UPDATE

	ciex_4
	
SET
	
	descripcion = 'CEGUERA MONOCULAR',
	desc_red = 'CEGUERA MONOCULAR'
	
WHERE

	id_ciex_4 = 3021;


/* G73.1* */
UPDATE

	ciex_4
	
SET
	
	descripcion = 'SINDROME DE EATON-LAMBERT (C00-D48(+))',
	desc_red = 'CEGUERA MONOCULAR'
	
WHERE

	id_ciex_4 = 2697;


/* G21.4 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12575,
	
	/* id_ciex_3 */
	497,
	
	/* cod_3dig */
	'G21',
	
	/* cod_4dig */
	'4',
	
	/* descripcion */
	'PARKINSONISMO VASCULAR',
	
	/* desc_red */
	'PARKINSONISMO VASCULAR',
	
	/* informa_c2 */
	'0'
);


/* G14 */
INSERT

	ciex_3
	
VALUES (
	
	/* id_ciex_3 */
	2054,
	
	/* cod_3dig */
	'G14',
	
	/* descripcion */
	'SINDROME POSTPOLIO',
	
	/* desc_red */
	'SINDROME POSTPOLIO'
	);


/* G14 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	668,
	
	/* id_ciex_4 */
	NULL,
	
	/* id_ciex_3 */
	2054,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'G14',
	
	/* cod_4dig */
	NULL,
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* G14.X */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12576,
	
	/* id_ciex_3 */
	2054,
	
	/* cod_3dig */
	'G14',
	
	/* cod_4dig */
	'X',
	
	/* descripcion */
	'SINDROME POSTPOLIO',
	
	/* desc_red */
	'SINDROME POSTPOLIO',
	
	/* informa_c2 */
	'0'
);


/* capitulo VI-02 [G10-G14] */
UPDATE

	ciex_titulos
	
SET

	id_ciex_3_hasta = 2054,
	cod_3dig_hasta = 'G14'
	
WHERE

	id_ciex_titulo = 73;
	
	
/* E88.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12577,
	
	/* id_ciex_3 */
	409,
	
	/* cod_3dig */
	'E88',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'SINDROME DE LISIS TUMORAL',
	
	/* desc_red */
	'SINDROME DE LISIS TUMORAL',
	
	/* informa_c2 */
	'0'
);


/* E88.3 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	669,
	
	/* id_ciex_4 */
	12577,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'E88',
	
	/* cod_4dig */
	'3',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* E83.3 */
UPDATE

	ciex_4
	
SET

	descripcion = 'TRASTORNOS DEL METABOLISMO DEL FOSFORO Y FOSFATASA',
	desc_red = 'TRASTORNOS DEL METABOLISMO DEL FOSFORO Y FOSFATASA'
	
WHERE

	id_ciex_4 = 1994;
	
	
/* D89.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12578,
	
	/* id_ciex_3 */
	339,
	
	/* cod_3dig */
	'D89',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'SINDROME DE RECONSTRUCCION INMUNE',
	
	/* desc_red */
	'SINDROME DE RECONSTRUCCION INMUNE',
	
	/* informa_c2 */
	'0'
);


/* D89.3 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	670,
	
	/* id_ciex_4 */
	12578,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'D89',
	
	/* cod_4dig */
	'3',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* D75.2 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	671,
	
	/* id_ciex_4 */
	1626,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'D75',
	
	/* cod_4dig */
	'2',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* D76 */
UPDATE

	ciex_3
	
SET

	descripcion = 'OTRAS ENFERMEDADES ESPECIFICADAS CON PARTICIPACION DEL TEJIDO LINFORRECTICULAR Y DEL TEJIDO RETICULOHISTIOCITICO',
	desc_red = 'OTRAS ENFERMEDADES ESPECIFICADAS CON PARTICIPACION'
	
WHERE

	id_ciex_3 = 332;


/* D76.0 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	672,
	
	/* id_ciex_4 */
	1629,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'D76',
	
	/* cod_4dig */
	'0',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* D68.5 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12579,
	
	/* id_ciex_3 */
	324,
	
	/* cod_3dig */
	'D68',
	
	/* cod_4dig */
	'5',
	
	/* descripcion */
	'TROMBOFILIA PRIMARIA',
	
	/* desc_red */
	'TROMBOFILIA PRIMARIA',
	
	/* informa_c2 */
	'0'
);


/* D68.5 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	673,
	
	/* id_ciex_4 */
	12579,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'D68',
	
	/* cod_4dig */
	'5',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* D68.6 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12580,
	
	/* id_ciex_3 */
	324,
	
	/* cod_3dig */
	'D68',
	
	/* cod_4dig */
	'6',
	
	/* descripcion */
	'OTRA TROMBOFILIA',
	
	/* desc_red */
	'OTRA TROMBOFILIA',
	
	/* informa_c2 */
	'0'
);


/* D68.5 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	674,
	
	/* id_ciex_4 */
	12580,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'D68',
	
	/* cod_4dig */
	'6',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* D47.2 */
UPDATE

	ciex_4
	
SET

	descripcion = 'GAMMOPATIA MONOCLONAL DE SIGNIFICADO INCIERTO [GMSI]',
	desc_red ='GAMMOPATIA MONOCLONAL DE SIGNIFICADO INCIERTO [GMS'
	
WHERE

	id_ciex_4 = 1504;
	
	
/* D47.4 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12581,
	
	/* id_ciex_3 */
	306,
	
	/* cod_3dig */
	'D47',
	
	/* cod_4dig */
	'4',
	
	/* descripcion */
	'OSTEOMIELOFIBROSIS',
	
	/* desc_red */
	'OSTEOMIELOFIBROSIS',
	
	/* informa_c2 */
	'0'
);


/* D47.4 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	675,
	
	/* id_ciex_4 */
	12581,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'D47',
	
	/* cod_4dig */
	'4',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* D47.5 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12582,
	
	/* id_ciex_3 */
	306,
	
	/* cod_3dig */
	'D47',
	
	/* cod_4dig */
	'5',
	
	/* descripcion */
	'LEUCEMIA EOSINOFILICA CRONICA [SINDROME HIPEREOSINOFILICO]',
	
	/* desc_red */
	'LEUCEMIA EOSINOFILICA CRONICA [SINDROME HIPEREOSIN',
	
	/* informa_c2 */
	'0'
);


/* D47.5 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	676,
	
	/* id_ciex_4 */
	12582,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'D47',
	
	/* cod_4dig */
	'5',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* D46.1 */
UPDATE

	ciex_4
	
SET

	descripcion = 'ANEMIA REFRACTARIA CON SIDEROBLASTOS EN FORMA DE ANILLO',
	desc_red ='ANEMIA REFRACTARIA CON SIDEROBLASTOS EN FORMA DE A'
	
WHERE

	id_ciex_4 = 1496;


/* D46.3 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	677,
	
	/* id_ciex_4 */
	1498,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'D46',
	
	/* cod_4dig */
	'3',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2017-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* D46.5 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12583,
	
	/* id_ciex_3 */
	305,
	
	/* cod_3dig */
	'D46',
	
	/* cod_4dig */
	'5',
	
	/* descripcion */
	'ANEMIA REFRACTARIA CON DISPLASIA MULTILINAJE',
	
	/* desc_red */
	'ANEMIA REFRACTARIA CON DISPLASIA MULTILINAJE',
	
	/* informa_c2 */
	'0'
);


/* D46.5 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	678,
	
	/* id_ciex_4 */
	12583,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'D46',
	
	/* cod_4dig */
	'5',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* D46.6 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12584,
	
	/* id_ciex_3 */
	305,
	
	/* cod_3dig */
	'D46',
	
	/* cod_4dig */
	'6',
	
	/* descripcion */
	'SINDROME MIELODISPLASICO CON ANORMALIDAD CROMOSOMICA AISLADA DEL (5Q)',
	
	/* desc_red */
	'SINDROME MIELODISPLASICO CON ANORMALIDAD CROMOSOMI',
	
	/* informa_c2 */
	'0'
);


/* D46.6 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	679,
	
	/* id_ciex_4 */
	12584,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'D46',
	
	/* cod_4dig */
	'6',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	'2016-12-31'

);


/* C81 */
UPDATE

	ciex_3
	
SET

	descripcion = 'LINFOMA DE HODGKIN',
	desc_red = 'LINFOMA DE HODGKIN'
	
WHERE

	id_ciex_3 = 246;


/* C81.0 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA DE HODGKIN NODULAR CON PREDOMINIO LINFOCITICO',
	desc_red = 'LINFOMA DE HODGKIN NODULAR CON PREDOMINIO LINFOCIT'
	
WHERE

	id_ciex_4 = 1149;
	
	
/* C81.1 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA DE HODGKIN (CLASICO) CON ESCLEROSIS NODULAR',
	desc_red = 'LINFOMA DE HODGKIN (CLASICO) CON ESCLEROSIS NODULA'
	
WHERE

	id_ciex_4 = 1150;
	

/* C81.2 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA DE HODGKIN (CLASICO) CON CELULARIDAD MIXTA',
	desc_red = 'LINFOMA DE HODGKIN (CLASICO) CON CELULARIDAD MIXTA'
	
WHERE

	id_ciex_4 = 1151;
	
		
/* C81.3 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA DE HODGKIN (CLASICO) CON DEPLECION LINFOCITICA',
	desc_red = 'LINFOMA DE HODGKIN (CLASICO) CON DEPLECION LINFOCITI'
	
WHERE

	id_ciex_4 = 1152;
	

/* C81.4 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12585,
	
	/* id_ciex_3 */
	246,
	
	/* cod_3dig */
	'C81',
	
	/* cod_4dig */
	'4',
	
	/* descripcion */
	'LINFOMA DE HODGKIN (CLASICO) RICO EN LINFOCITOS',
	
	/* desc_red */
	'LINFOMA DE HODGKIN (CLASICO) RICO EN LINFOCITOS',
	
	/* informa_c2 */
	'0'
);
	

/* C81.7 */
UPDATE

	ciex_4
	
SET

	descripcion = 'OTROS LINFOMAS DE HODGKIN (CLASICOS)',
	desc_red = 'OTROS LINFOMAS DE HODGKIN (CLASICOS)'
	
WHERE

	id_ciex_4 = 1153;
	

/* C81.9 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA DE HODGKIN, NO ESPECIFICADO',
	desc_red = 'LINFOMA DE HODGKIN, NO ESPECIFICADO'
	
WHERE

	id_ciex_4 = 1154;
	

/* C82 */
UPDATE

	ciex_3
	
SET

	descripcion = 'LINFOMA FOLICULAR',
	desc_red = 'LINFOMA FOLICULAR'
	
WHERE

	id_ciex_3 = 247;
	
	
/* C82.0 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA FOLICULAR GRADO I',
	desc_red = 'LINFOMA FOLICULAR GRADO I'
	
WHERE

	id_ciex_4 = 1155;
		

/* C82.1 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA FOLICULAR GRADO II',
	desc_red = 'LINFOMA FOLICULAR GRADO II'
	
WHERE

	id_ciex_4 = 1156;


/* C82.2 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA FOLICULAR GRADO III, NO ESPECIFICADO',
	desc_red = 'LINFOMA FOLICULAR GRADO III, NO ESPECIFICADO'
	
WHERE

	id_ciex_4 = 1157;


/* C82.3 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12586,
	
	/* id_ciex_3 */
	247,
	
	/* cod_3dig */
	'C82',
	
	/* cod_4dig */
	'3',
	
	/* descripcion */
	'LINFOMA FOLICULAR GRADO IIIA',
	
	/* desc_red */
	'LINFOMA FOLICULAR GRADO IIIA',
	
	/* informa_c2 */
	'0'
);


/* C82.4 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12587,
	
	/* id_ciex_3 */
	247,
	
	/* cod_3dig */
	'C82',
	
	/* cod_4dig */
	'4',
	
	/* descripcion */
	'LINFOMA FOLICULAR GRADO IIIB',
	
	/* desc_red */
	'LINFOMA FOLICULAR GRADO IIIB',
	
	/* informa_c2 */
	'0'
);


/* C82.5 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12588,
	
	/* id_ciex_3 */
	247,
	
	/* cod_3dig */
	'C82',
	
	/* cod_4dig */
	'5',
	
	/* descripcion */
	'LINFOMA CENTRO FOLICULAR DIFUSO',
	
	/* desc_red */
	'LINFOMA CENTRO FOLICULAR DIFUSO',
	
	/* informa_c2 */
	'0'
);


/* C82.6 */
INSERT

	ciex_4
	
VALUES (

	/* id_ciex_4 */
	12589,
	
	/* id_ciex_3 */
	247,
	
	/* cod_3dig */
	'C82',
	
	/* cod_4dig */
	'6',
	
	/* descripcion */
	'LINFOMA CENTRO FOLICULAR CUTANEO',
	
	/* desc_red */
	'LINFOMA CENTRO FOLICULAR CUTANEO',
	
	/* informa_c2 */
	'0'
);


/* C82.7 */
UPDATE

	ciex_4
	
SET

	descripcion = 'OTROS TIPOS ESPECIFICADOS DE LINFOMA FOLICULAR',
	desc_red = 'OTROS TIPOS ESPECIFICADOS DE LINFOMA FOLICULAR'
	
WHERE

	id_ciex_4 = 1158;
	
	
/* C82.9 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA FOLICULAR, SIN OTRA ESPECIFICACION',
	desc_red = 'LINFOMA FOLICULAR, SIN OTRA ESPECIFICACION'
	
WHERE

	id_ciex_4 = 1159;
	
		
/* C83 */
UPDATE

	ciex_3
	
SET

	descripcion = 'LINFOMA NO FOLICULAR',
	desc_red = 'LINFOMA NO FOLICULAR'
	
WHERE

	id_ciex_3 = 248;		
		
		
/* C83.0 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA DE CELULAS B PEQUEÑAS',
	desc_red = 'LINFOMA DE CELULAS B PEQUEÑAS'
	
WHERE

	id_ciex_4 = 1160;
	

/* C83.1 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA DE CELULAS DEL MANTO',
	desc_red = 'LINFOMA DE CELULAS DEL MANTO'
	
WHERE

	id_ciex_4 = 1161;
	

/* C83.2 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	680,
	
	/* id_ciex_4 */
	1162,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'C83',
	
	/* cod_4dig */
	'2',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);

	
/* C83.3 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA DE CELULAS B GRANDES (DIFUSO)',
	desc_red = 'LINFOMA DE CELULAS B GRANDES (DIFUSO)'
	
WHERE

	id_ciex_4 = 1163;
	
	
/* C83.4 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	681,
	
	/* id_ciex_4 */
	1164,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'C83',
	
	/* cod_4dig */
	'4',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);	
		

/* C83.5 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA LINFOBLASTICO (DIFUSO)',
	desc_red = 'LINFOMA DE CELULAS B GRANDES (DIFUSO)'
	
WHERE

	id_ciex_4 = 1165;
	
	
/* C83.6 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	682,
	
	/* id_ciex_4 */
	1166,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'C83',
	
	/* cod_4dig */
	'6',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* C83.7 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA DE BURKITT',
	desc_red = 'LINFOMA DE BURKITT'
	
WHERE

	id_ciex_4 = 1167;
	
	
/* C83.8 */
UPDATE

	ciex_4
	
SET

	descripcion = 'OTROS TIPOS ESPECIFICADOS DE LINFOMA NO FOLICULAR',
	desc_red = 'OTROS TIPOS ESPECIFICADOS DE LINFOMA NO FOLICULAR'
	
WHERE

	id_ciex_4 = 1168;
	

/* C83.9 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA NO FOLICULAR (DIFUSO), SIN OTRA ESPECIFICACION',
	desc_red = 'LINFOMA NO FOLICULAR (DIFUSO), SIN OTRA ESPECIFICA'
	
WHERE

	id_ciex_4 = 1169;
	

/* C84 */
UPDATE

	ciex_3
	
SET

	descripcion = 'LINFOMA DE CELULAR T/NK MADURAS',
	desc_red = 'LINFOMA DE CELULAR T/NK MADURAS'
	
WHERE

	id_ciex_3 = 249;
	

/* C84.2 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	683,
	
	/* id_ciex_4 */
	1172,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'C84',
	
	/* cod_4dig */
	'2',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* C84.3 */
INSERT 

	ciex_restricciones
	
VALUES

	/* id_ciex_restriccion */
	684,
	
	/* id_ciex_4 */
	1173,
	
	/* id_ciex_3 */
	NULL,
	
	/* id_ciex_titulo */
	NULL,
	
	/* cod_3dig */
	'C84',
	
	/* cod_4dig */
	'3',
	
	/* sexo */
	0,
	
	/* frecuencia */
	2,
	
	/* tipoedad_min */
	9,
	
	/* edad_min */
	0,
	
	/* tipoedad_max */
	0,
	
	/* edad_max */
	99,
	
	/* restriccion_edad */
	0,
	
	/* obstetricia */
	9,
	
	/* defuncion */
	9,
	
	/* causa_externa */
	0,
	   
	/* fecha_vigencia_desde */
	'2010-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);



/* C84.0 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA NO FOLICULAR (DIFUSO), SIN OTRA ESPECIFICACION',
	desc_red = 'LINFOMA NO FOLICULAR (DIFUSO), SIN OTRA ESPECIFICA'
	
WHERE

	id_ciex_4 = 1169;
	
											
/* C91.5 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LEUCEMIA/LINFOMA DE CELULAS T ADULTAS [HTLV-1-ASOCIADO]',
	desc_red = 'LEUCEMIA/LINFOMA DE CELULAS T ADULTAS [HTLV-1-ASOC'
	
WHERE

	id_ciex_4 = 1194;
	
	
/* C88.9 */
UPDATE

	ciex_4
	
SET

	descripcion = 'LINFOMA NO FOLICULAR (DIFUSO), SIN OTRA ESPECIFICACION',
	desc_red = 'LINFOMA NO FOLICULAR (DIFUSO), SIN OTRA ESPECIFICA'
	
WHERE

	id_ciex_4 = 1169;
	
	

	
	
		
