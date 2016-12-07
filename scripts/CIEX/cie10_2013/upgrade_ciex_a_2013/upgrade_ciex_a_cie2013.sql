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

	descripcion = 'SINDROME RESPIRATORIO AGUDO GRAVE [SRAG]'

WHERE 

	id_ciex_3 = 2041;
	
	
/* U06 */
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE 

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
	'2016-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* capitulo XXII (U00-U99) */

/* 01-01-2010 al 01-01-2016 */
INSERT IGNORE 

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
	'2015-12-31'

);


/* 01-01-2016 al presente */
INSERT IGNORE 

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
	'2016-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);



/* U82 */
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE 

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
	'2016-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);	
	

/* X34.3 */
INSERT IGNORE 

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
	'2016-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);	


/* X34.4 */
INSERT IGNORE 

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
	'2016-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* X34.5 */
INSERT IGNORE 

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
	'2016-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* X34.6 */
INSERT IGNORE 

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
	'2016-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* X34.7 */
INSERT IGNORE 

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
	'2016-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* R65 */
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE 

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
	'2016-01-01',
	
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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE 

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
	'2016-01-01',
	
	/* fecha_vigencia_hasta */
	NULL

);


/* O96.0 */
INSERT IGNORE

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
INSERT IGNORE

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
INSERT IGNORE

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


/* O62.2 */
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
INSERT IGNORE 

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
