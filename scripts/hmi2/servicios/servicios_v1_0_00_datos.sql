		/* ============================================= */
		/* ==============  migracion SIPES ============= */
		/* ============================================= */



/* tablas auxiliares para migracion sipes */
DROP TABLE IF EXISTS establecimientos_sipes;
DROP TABLE IF EXISTS servicios_sipes;
DROP TABLE IF EXISTS servicios_estadistica_sipes;
DROP TABLE IF EXISTS servicios_establecimientos_sipes_int_auxiliar;
DROP TABLE IF EXISTS servicios_salas_auxiliar;
DROP TABLE IF EXISTS servicios_establecimientos_sipes_int;
DROP TABLE IF EXISTS servicios_establecimientos_sipes_ce;



/* ----------------------- */
/* establecimientos SIPES  */
/* ----------------------- */

CREATE TABLE establecimientos_sipes(
	codigo					CHAR(9)				NOT NULL,
	descripcion				VARCHAR(66)			NOT NULL,
	desc_resumida			VARCHAR(30)			NOT NULL,
	localidad				CHAR(2)				NOT NULL,
	dep_administrativa		CHAR(1)				NOT NULL,
	zona					CHAR(1)				NOT NULL,
	internacion				CHAR(1)				NOT NULL,
	direccion				VARCHAR(46)         NOT NULL,
	codigo_postal			CHAR(4)             NOT NULL,
	telefono				VARCHAR(20)         NOT NULL,
	fax						VARCHAR(20)         NOT NULL,
	tipificacion			CHAR(2)             NOT NULL,
	dotacion_camas			CHAR(2)             NOT NULL,
	nivel_complejidad		CHAR(2)             NOT NULL,
	fecha_apertura			CHAR(8)             NOT NULL,
	marca_informante		CHAR(1)             NOT NULL,
	nodo					CHAR(1)             NOT NULL
)ENGINE=MyISAM;

LOAD DATA LOCAL INFILE './sipes/ESTAB.EXC' 
	INTO TABLE establecimientos_sipes
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n';	


	

/* ------------------------- */
/* servicios nucleares SIPES */
/* ------------------------- */

/* crea la tabla auxiliar para migrar los servicios nucleares de nacion */
CREATE TABLE servicios_sipes(
	cod_servicio		CHAR(3)				NOT NULL,
	nom_servicio		VARCHAR(255)		NOT NULL,
	diag_especial		CHAR(1)				NOT NULL	COMMENT 'I: diagnostico por imagenes',
	tipo_servicio		TINYINT				NOT NULL	COMMENT '1:final; 2:internacion; 3:gral'
)ENGINE=MyISAM;

LOAD DATA LOCAL INFILE './sipes/TSERVIC3.EXC' 
	INTO TABLE servicios_sipes
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n';
	

		
/* ========= */
/* servicios */
/* ========= */

/* carga la tabla de servicios con informacion obtenida del sipes */

INSERT INTO servicios
	
	SELECT	
	
		/* id_servicio */
		0,
		/* cod_servicio */
		ssip.cod_servicio,
		
		/* nom_servicio */
		TRIM(ssip.nom_servicio),
		
		/* nom_red_servicio */
		LEFT(TRIM(ssip.nom_servicio),30),
		
		/* diagn_especiales */
		IF(ssip.diag_especial='',NULL,ssip.diag_especial),
		
		/* medico */
		0,
		
		/* tipo_servicio */
		ssip.tipo_servicio
	
	FROM	
	
		servicios_sipes ssip;
	
	
	
/* ----------------- */
/* servicios 5 SIPES */	
/* ----------------- */

/* crea la tabla auxiliar para migrar los servicios de estadistiva */
CREATE TABLE servicios_estadistica_sipes(
	cod_servicio		CHAR(3)				NOT NULL,
	sector				CHAR(1)				NOT NULL,
	subsector			CHAR(1)				NOT NULL,
	nom_servicio		VARCHAR(255)		NOT NULL,
	diag_especial		CHAR(1)				NOT NULL	COMMENT 'I: diagnostico por imagenes',
	tipo_servicio		TINYINT				NOT NULL	COMMENT '1:final; 2:internacion; 3:gral'
)ENGINE=MyISAM;
	
LOAD DATA LOCAL INFILE './sipes/TSERVIC5.EXC' 
	INTO TABLE servicios_estadistica_sipes
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n';
	
	

		
/* ===================== */
/* servicios_estadistica */
/* ===================== */

/* carga la tabla de "servicios_estadistica" que se usara en el hmi2 */
INSERT INTO servicios_estadistica
	SELECT	
		
		/* id_servicio_estadistica */
		0,
		
		/* id_servicio */
		(SELECT id_servicio
			FROM servicios s
			WHERE ses.cod_servicio = s.cod_servicio),
		
		/* cod_servicio */
		ses.cod_servicio,
		
		/* sector */
		ses.sector,
		
		/* subsector */
		ses.subsector,
		
		/* nom_servicio_estadistica */
		TRIM(ses.nom_servicio),
		
		/* nom_red_servicio_estadistica */
		LEFT(TRIM(ses.nom_servicio),30)
		

	FROM servicios_estadistica_sipes ses
		
	ON DUPLICATE KEY UPDATE
	
		/* id_servicio */
		id_servicio = (SELECT ss.id_servicio
				FROM servicios ss
				WHERE ses.cod_servicio = ss.cod_servicio),
				
		/* nom_servicio_estadistica */
		nom_servicio_estadistica = TRIM(ses.nom_servicio),
		
		/* nom_red_servicio_estadistica */
		nom_red_servicio_estadistica = LEFT(TRIM(ses.nom_servicio),30);
		
		
/* Actualiza el campo "medico" de la tabla "servicios" con los servicios de internacion */

UPDATE
	servicios s,
	servicios_estadistica_sipes ses
SET
	s.medico = 1
WHERE
	s.cod_servicio = ses.cod_servicio
AND ses.subsector = '4';
		
		
	
/* actualiza la descripcion del servicio 421 1 4 que tenia un error de */
/* ortografia */
UPDATE 
	servicios_estadistica
SET
	nom_servicio_estadistica='PSIQUIATRIA INFANTIL',
	nom_red_servicio_estadistica='PSIQUIATRIA INFANTIL'
WHERE
	cod_servicio='421'
AND sector='1'
AND subsector='4';		

		

/* ------------------------------ */
/* servicios de internacion SIPES */
/* ------------------------------ */
		
/* crea tabla auxiliar para migrar los servicios de internacion traidos del sipes */
CREATE TABLE servicios_establecimientos_sipes_int_auxiliar(
	cod_estab_depto		CHAR(3)		NOT NULL,
	estab_nro			CHAR(5)		NOT NULL,
	estab_tipo			CHAR(1)		NOT NULL,		
	area_cod_servicio	CHAR(3)		NOT NULL,
	area_sector			CHAR(1)		NOT NULL,
	area_subsector		CHAR(1)		NOT NULL,
	cod_servicio		CHAR(3)		NOT NULL,
	cerrado_cronico		CHAR(1)		NOT NULL,
	fecha_apertura		CHAR(10)	NOT NULL,
	fecha_cierre		CHAR(10)	NOT NULL,
	cant_camas			CHAR(2)		NOT NULL,
	bco_sangre			CHAR(1)		NOT NULL,
	tipo_servicio		CHAR(1)		NOT NULL
)ENGINE=MyISAM;

LOAD DATA LOCAL INFILE './sipes/TESTASER.EXC' 
	INTO TABLE servicios_establecimientos_sipes_int_auxiliar
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n';

CREATE TABLE servicios_salas_auxiliar(
	nro_servicio_sala	INTEGER		NOT NULL AUTO_INCREMENT,
	cod_estab_depto		CHAR(3)		NOT NULL,
	estab_nro			CHAR(5)		NOT NULL,
	estab_tipo			CHAR(1)		NOT NULL,		
	area_cod_servicio	CHAR(3)		NOT NULL,
	area_sector			CHAR(1)		NOT NULL,
	area_subsector		CHAR(1)		NOT NULL,
	cod_servicio		CHAR(3)		NOT NULL,
	cerrado_cronico		CHAR(1)		NOT NULL,
	fecha_apertura		CHAR(10)	NOT NULL,
	fecha_cierre		CHAR(10)	NOT NULL,
	cant_camas			CHAR(2)		NOT NULL,
	bco_sangre			CHAR(1)		NOT NULL,
	tipo_servicio		CHAR(1)		NOT NULL,
PRIMARY KEY (cod_estab_depto,estab_nro,estab_tipo,area_cod_servicio,area_sector,area_subsector,nro_servicio_sala)
)ENGINE=MyISAM;

INSERT INTO
	
	servicios_salas_auxiliar
	
	SELECT
	
		0,
		sea.cod_estab_depto,	 
		sea.estab_nro,	      
		sea.estab_tipo,			     
		sea.area_cod_servicio,
		sea.area_sector,	    
		sea.area_subsector,		  
		sea.cod_servicio,		    
		sea.cerrado_cronico,
		sea.fecha_apertura,	  
		sea.fecha_cierre,		    
		sea.cant_camas,		     
		sea.bco_sangre,			     
		sea.tipo_servicio
	
	FROM
	
		servicios_establecimientos_sipes_int_auxiliar sea
	
	WHERE
		
		sea.cod_servicio <> '000';
		
		
		
CREATE TABLE servicios_establecimientos_sipes_int(
	nro_sala			INTEGER		NOT NULL AUTO_INCREMENT,
	nro_servicio_sala	INTEGER		NOT NULL DEFAULT 0,
	cod_estab_depto		CHAR(3)		NOT NULL,
	estab_nro			CHAR(5)		NOT NULL,
	estab_tipo			CHAR(1)		NOT NULL,		
	area_cod_servicio	CHAR(3)		NOT NULL,
	area_sector			CHAR(1)		NOT NULL,
	area_subsector		CHAR(1)		NOT NULL,
	cod_servicio		CHAR(3)		NOT NULL,
	cerrado_cronico		CHAR(1)		NOT NULL,
	fecha_apertura		CHAR(10)	NOT NULL,
	fecha_cierre		CHAR(10)	NOT NULL,
	cant_camas			CHAR(2)		NOT NULL,
	bco_sangre			CHAR(1)		NOT NULL,
	tipo_servicio		CHAR(1)		NOT NULL,
PRIMARY KEY (cod_estab_depto,estab_nro,estab_tipo,cod_servicio,nro_sala)
)ENGINE=MyISAM;


INSERT INTO
	
	servicios_establecimientos_sipes_int
	
	SELECT
	
		0,
		0,
		sea.cod_estab_depto,	 
		sea.estab_nro,	      
		sea.estab_tipo,			     
		sea.area_cod_servicio,
		sea.area_sector,	    
		sea.area_subsector,		  
		sea.cod_servicio,		    
		sea.cerrado_cronico,
		sea.fecha_apertura,	  
		sea.fecha_cierre,		    
		sea.cant_camas,		     
		sea.bco_sangre,			     
		sea.tipo_servicio
	
	FROM
	
		servicios_establecimientos_sipes_int_auxiliar sea;
		
/* modifica el formato de la fecha de apertura y fecha de cierre */
UPDATE 
	servicios_establecimientos_sipes_int
SET
	fecha_apertura = CONCAT(RIGHT(fecha_apertura,4),'-',LEFT(RIGHT(fecha_apertura,7),2),'-',LEFT(fecha_apertura,2)),
	fecha_cierre = CONCAT(RIGHT(fecha_cierre,4),'-',LEFT(RIGHT(fecha_cierre,7),2),'-',LEFT(fecha_cierre,2));
	

/* carga los numeros de servicios salas */
UPDATE
	servicios_establecimientos_sipes_int si, servicios_salas_auxiliar ssa
	
SET

	si.nro_servicio_sala = ssa.nro_servicio_sala

WHERE

	si.cod_estab_depto		= ssa.cod_estab_depto	 
AND	si.estab_nro			= ssa.estab_nro		   	      
AND	si.estab_tipo			= ssa.estab_tipo	  			     
AND	si.area_cod_servicio	= ssa.area_cod_servicio
AND	si.area_sector			= ssa.area_sector	  	    
AND	si.area_subsector		= ssa.area_subsector 		  
AND	si.cod_servicio			= ssa.cod_servicio;
	

		
/* -------------------------------------- */
/* servicios de consultorio externo SIPES */
/* -------------------------------------- */	
	
/* crea tabla auxiliar para migrar los servicios de consultorio externos traidos del sipes */
CREATE TABLE servicios_establecimientos_sipes_ce(
	cod_estab_depto		CHAR(3)		NOT NULL,
	estab_nro			CHAR(5)		NOT NULL,
	estab_tipo			CHAR(1)		NOT NULL,
	cod_servicio		CHAR(3)		NOT NULL,
	sector				CHAR(1)		NOT NULL,
	subsector			CHAR(1)		NOT NULL,
	medico				CHAR(1)		NOT NULL,
	intermedio_gral		CHAR(1)		NOT NULL,
	fecha_apertura_ce	CHAR(10)	NOT NULL,
	fecha_cierre_ce		CHAR(10)	NOT NULL,
	fecha_cierre_ig		CHAR(10)	NOT NULL,
	cantidad_camas		CHAR(2)		NOT NULL,
	bco_sangre			CHAR(1)		NOT NULL
)ENGINE=MyISAM;	

LOAD DATA LOCAL INFILE './sipes/TESTSER.EXC' 
	INTO TABLE servicios_establecimientos_sipes_ce
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n';
	
	
/* modifica el formato de la fecha de apertura y fecha de cierre */
UPDATE 
	servicios_establecimientos_sipes_ce
SET
	fecha_apertura_ce = CONCAT(RIGHT(fecha_apertura_ce,4),'-',LEFT(RIGHT(fecha_apertura_ce,7),2),'-',LEFT(fecha_apertura_ce,2)),
	fecha_cierre_ce = CONCAT(RIGHT(fecha_cierre_ce,4),'-',LEFT(RIGHT(fecha_cierre_ce,7),2),'-',LEFT(fecha_cierre_ce,2)),
	fecha_cierre_ig = CONCAT(RIGHT(fecha_cierre_ig,4),'-',LEFT(RIGHT(fecha_cierre_ig,7),2),'-',LEFT(fecha_cierre_ig,2));
	
	
/* Pone en NULL las fechas de apertura = '2008-01-01' */
UPDATE
	servicios_establecimientos_sipes_ce
SET
	fecha_apertura_ce = '2008-01-01'
WHERE
	fecha_apertura_ce = '0000-00-00';
		
	
/* agrega el campo id_efector a las tablas del sipes de servicios de ce e internacion */
ALTER TABLE 
	servicios_establecimientos_sipes_ce
ADD COLUMN
	id_efector 					INT 	UNSIGNED 	NULL;
	
ALTER TABLE 
	servicios_establecimientos_sipes_int
ADD COLUMN
	id_efector 					INT 	UNSIGNED 	NULL;
	
/* actualiza el campo id_efector de las tablas del sipes de servicios de ce e internacion */
UPDATE
	servicios_establecimientos_sipes_ce
SET
	id_efector = 
		(SELECT
			e.id_efector
		FROM
			efectores0_53a.efectores e
		WHERE
			e.claveestd = CONCAT(
							servicios_establecimientos_sipes_ce.cod_estab_depto,
							servicios_establecimientos_sipes_ce.estab_nro
							)
		);
							
UPDATE
	servicios_establecimientos_sipes_int
SET
	id_efector = 
		(SELECT
			e.id_efector
		FROM
			efectores0_53a.efectores e
		WHERE
			e.claveestd = CONCAT(
							servicios_establecimientos_sipes_int.cod_estab_depto,
							servicios_establecimientos_sipes_int.estab_nro
							)
		);
							
/* agrega el campo id_servicio_estadistica a la tabla del sipes de servicios de ce */
ALTER TABLE 
	servicios_establecimientos_sipes_ce
ADD COLUMN
	id_servicio_estadistica 					INT 	UNSIGNED 	NULL;
	
/* actualiza el campo id_efector de las tablas del sipes de servicios de ce e internacion */
UPDATE
	servicios_establecimientos_sipes_ce
SET
	id_servicio_estadistica = 
		(SELECT
			se.id_servicio_estadistica
		FROM
			servicios_estadistica se
		WHERE
			se.cod_servicio = servicios_establecimientos_sipes_ce.cod_servicio
		AND se.sector = servicios_establecimientos_sipes_ce.sector
		AND se.subsector = servicios_establecimientos_sipes_ce.subsector
		);
		
/* agrega el campo area_id_servicio_estadistica a la tabla del sipes de servicios de internacion */
ALTER TABLE 
	servicios_establecimientos_sipes_int
ADD COLUMN
	area_id_servicio_estadistica 					INT 	UNSIGNED 	NULL;
	
/* actualiza el campo area_id_servicio_estadistica de las tablas del sipes de servicios de ce e internacion */
UPDATE
	servicios_establecimientos_sipes_int
SET
	area_id_servicio_estadistica = 
		(SELECT
			se.id_servicio_estadistica
		FROM
			servicios_estadistica se
		WHERE
			se.cod_servicio = servicios_establecimientos_sipes_int.area_cod_servicio
		AND se.sector = servicios_establecimientos_sipes_int.area_sector
		AND se.subsector = servicios_establecimientos_sipes_int.area_subsector
		);
		
/* agrega el campo id_servicio_estadistica a la tabla del sipes de servicios de internacion */
ALTER TABLE 
	servicios_establecimientos_sipes_int
ADD COLUMN
	id_servicio_estadistica 					INT 	UNSIGNED 	NULL;
	
/* actualiza el campo id_servicio_estadistica de las tablas del sipes de servicios de internacion */
UPDATE
	servicios_establecimientos_sipes_int sei
SET
	id_servicio_estadistica =
		IFNULL( 
			(SELECT
				se.id_servicio_estadistica
			FROM
				servicios_estadistica se
			WHERE
				se.cod_servicio = sei.cod_servicio
			AND se.sector = sei.area_sector
			AND se.subsector = sei.area_subsector
			),
			IFNULL(
				(SELECT
					se.id_servicio_estadistica
				FROM
					servicios_estadistica se
				WHERE
					se.cod_servicio = sei.cod_servicio
				AND se.sector = '2'
				AND se.subsector = sei.area_subsector
				),
				(SELECT
					se.id_servicio_estadistica
				FROM
					servicios_estadistica se
				WHERE
					se.cod_servicio = sei.cod_servicio
				AND se.sector = '1'
				AND se.subsector = sei.area_subsector
				)
			)
		)
WHERE
	sei.cod_servicio<>'000';
		

	
	
	
	
/* --------------------------------------------------------------- */
/* Actualiza el campo "medico" de la tabla "servicios_estadistica" */
/* --------------------------------------------------------------- */
UPDATE	
	servicios s, 
	servicios_estadistica se, 
	servicios_establecimientos_sipes_ce sce
	
SET s.medico = sce.medico
WHERE
	se.id_servicio_estadistica = sce.id_servicio_estadistica
AND se.id_servicio = s.id_servicio;
	
	
	
	
	

/* ======================== */
/* efectores_servicios (CE) */
/* ======================== */		

/* carga los servicios de consultorio externo en la tabla de efectores_servicios */

INSERT INTO 

	efectores_servicios
	
	SELECT
		
		/* id_efector_servicio */
		get_id_efector_servicio(sce.id_efector,sce.id_servicio_estadistica),
		
		/* id_efector */
		sce.id_efector,
		
		/* id_servicio_estadistica */
		sce.id_servicio_estadistica,
		
		/* claveestd */
		CONCAT(sce.cod_estab_depto,sce.estab_nro),
		
		/* cod_servicio */
		sce.cod_servicio,
		
		/* sector */
		sce.sector,
		
		/* subsector */
		sce.subsector,
		
		/* nom_servicio_estadistica */
		(SELECT 
			se.nom_servicio_estadistica
		FROM
			servicios_estadistica se
		WHERE 
			se.id_servicio_estadistica = sce.id_servicio_estadistica),
		
		/* baja */
		FALSE,
		
		/* fecha_modificacion */
		NULL
		
	FROM
		servicios_establecimientos_sipes_ce sce
	INNER JOIN 
		establecimientos_sipes es
	ON 
		CONCAT(sce.cod_estab_depto,sce.estab_nro,sce.estab_tipo)=es.codigo
	
	WHERE
		es.marca_informante = 'S'
	AND sce.id_efector IS NOT NULL;
	

		
/* ============================= */
/* efectores_servicios_hist (CE) */
/* ============================= */

/* carga el historico de los servicios de consultorio externo en la tabla de efectores_servicios_hist */
INSERT INTO 

	efectores_servicios_hist
	
	SELECT
	
		/* id_efector_servicio_hist */
		0,
		
		/* id_efector_servicio */
		get_id_efector_servicio(sce.id_efector,sce.id_servicio_estadistica),
		
		/* fecha_apertura */
		sce.fecha_apertura_ce,
		
		/* fecha_cierre */
		IF(sce.fecha_cierre_ce ='0000-00-00',NULL,sce.fecha_cierre_ce),
		
		/* fecha_modificacion */
		NULL
		
	FROM
		servicios_establecimientos_sipes_ce sce
	INNER JOIN 
		establecimientos_sipes es
	ON 
		CONCAT(sce.cod_estab_depto,sce.estab_nro,sce.estab_tipo)=es.codigo
	
	WHERE
	
	/* con esta marca se controla que sea un efector informante. NOTA: en el */
	/* SIPES el mismo efector puede estar mas de una vez en la tabla servicios */
	/* establecimientos porque el tipo efector es parte de la clave, pero con */
	/* la marca de informante se asegura que sea el ultima clave de efector vigente */
		es.marca_informante = 'S'
		
	/* check efectores que no estan en el SIMS pero si en SIPES */
	AND sce.id_efector IS NOT NULL;
	
	

		
/* ================================= */
/* efectores_servicios (Internacion) */
/* ================================= */

				
/* carga los servicios de internacion en la tabla de efectores_servicios */

INSERT INTO 

	efectores_servicios
	
	SELECT DISTINCT
		
		/* id_efector_servicio */
		get_id_efector_servicio(si.id_efector,
								IF(
									si.cod_servicio='000',
									si.area_id_servicio_estadistica,
									si.id_servicio_estadistica
									)
								),
		
		/* id_efector */
		si.id_efector,
		
		/* id_servicio_estadistica */
		IF(
			si.cod_servicio='000',
			si.area_id_servicio_estadistica,
			si.id_servicio_estadistica
		),
		
		/* claveestd */
		CONCAT(si.cod_estab_depto,si.estab_nro),
		
		/* cod_servicio */
		IF(
			si.cod_servicio='000',
			(SELECT
				se.cod_servicio
			FROM
				servicios_estadistica se
			WHERE
				
				se.id_servicio_estadistica = si.area_id_servicio_estadistica
			),
			(SELECT
				se.cod_servicio
			FROM
				servicios_estadistica se
			WHERE
				
				se.id_servicio_estadistica = si.id_servicio_estadistica
			)
		),
		
		/* sector */
		IF(
			si.cod_servicio='000',
			(SELECT
				se.sector
			FROM
				servicios_estadistica se
			WHERE
				
				se.id_servicio_estadistica = si.area_id_servicio_estadistica
			),
			(SELECT
				se.sector
			FROM
				servicios_estadistica se
			WHERE
				
				se.id_servicio_estadistica = si.id_servicio_estadistica
			)
		),
		
		/* subsector */
		IF(
			si.cod_servicio='000',
			(SELECT
				se.subsector
			FROM
				servicios_estadistica se
			WHERE
				
				se.id_servicio_estadistica = si.area_id_servicio_estadistica
			),
			(SELECT
				se.subsector
			FROM
				servicios_estadistica se
			WHERE
				
				se.id_servicio_estadistica = si.id_servicio_estadistica
			)
		),
		
		/* nom_servicio_estadistica */
		(SELECT 
			se.nom_servicio_estadistica
		FROM
			servicios_estadistica se
		WHERE 
			se.id_servicio_estadistica = IF(
											si.cod_servicio='000',
											si.area_id_servicio_estadistica,
											si.id_servicio_estadistica
											)
		),
		
		/* baja */
		FALSE,
		
		/* fecha_modificacion */
		NULL
		
	FROM
		servicios_establecimientos_sipes_int si
	INNER JOIN 
		establecimientos_sipes es
	ON 
		CONCAT(si.cod_estab_depto,si.estab_nro,si.estab_tipo)=es.codigo
	
	WHERE
	
	/* con esta marca se controla que sea un efector informante. NOTA: en el */
	/* SIPES el mismo efector puede estar mas de una vez en la tabla servicios */
	/* establecimientos porque el tipo efector es parte de la clave, pero con */
	/* la marca de informante se asegura que sea el ultima clave de efector vigente */
		es.marca_informante = 'S'
	
	/* check efectores que no estan en el SIMS pero si en SIPES */
	AND si.id_efector IS NOT NULL;	
	
	

/* ====================================== */
/* efectores_servicios_hist (Internacion) */
/* ====================================== */

	
/* carga el historico de los servicios de las areas(sala) de internacion en la tabla de efectores_servicios_hist */
INSERT

	efectores_servicios_hist
	
	SELECT DISTINCT
	
		/* id_efector_servicio_hist */
		0,
		
		/* id_efector_servicio */
		get_id_efector_servicio(si.id_efector, 
									IF(
										si.cod_servicio='000',
										si.area_id_servicio_estadistica,
										si.id_servicio_estadistica
										)
									),
		
		/* fecha_apertura */
		si.fecha_apertura,
		
		/* fecha_cierre */
		IF(si.fecha_cierre ='0000-00-00',NULL,si.fecha_cierre),
		
		/* fecha_modificacion */
		NULL
		
	FROM
		servicios_establecimientos_sipes_int si
	INNER JOIN 
		establecimientos_sipes es
	ON 
		CONCAT(si.cod_estab_depto,si.estab_nro,si.estab_tipo)=es.codigo
	
	WHERE
	
	/* con esta marca se controla que sea un efector informante. NOTA: en el */
	/* SIPES el mismo efector puede estar mas de una vez en la tabla servicios */
	/* establecimientos porque el tipo efector es parte de la clave, pero con */
	/* la marca de informante se asegura que sea el ultima clave de efector vigente */
		es.marca_informante = 'S'
		
	/* check efectores que no estan en el SIMS pero si en SIPES */
	AND si.id_efector IS NOT NULL;
	
/* Actualiza el campo baja de los servicios que tienen fecha de cierre */
UPDATE
	efectores_servicios es,
	efectores_servicios_hist esh
SET
	es.baja = TRUE
	
WHERE
	es.id_efector_servicio = esh.id_efector_servicio
AND esh.fecha_cierre IS NOT NULL
AND esh.fecha_apertura = (
	SELECT 
		MAX(esh2.fecha_apertura)
	FROM
		efectores_servicios_hist esh2
	WHERE
		esh2.id_efector_servicio = es.id_efector_servicio
		);
		
		
		
/* ===== */
/* Salas */
/* ===== */
		
/* carga la tabla "salas" */
INSERT INTO

	salas
	
	SELECT
		
		/* id_sala */
		(SELECT 
			id_efector_servicio
		FROM
			efectores_servicios ese
		WHERE
			ese.cod_servicio = si.area_cod_servicio
		AND ese.sector = si.area_sector
		AND ese.subsector = si.area_subsector
		AND ese.id_efector = si.id_efector
		),
			
		/* id_efector */
		si.id_efector,
		
		/* nombre */
		CONCAT(
			(SELECT 
				nom_servicio_estadistica
			FROM
				efectores_servicios ese
			WHERE
				ese.cod_servicio = si.area_cod_servicio
			AND ese.sector = si.area_sector
			AND ese.subsector = si.area_subsector
			AND ese.id_efector = si.id_efector
			),
			' - ',
			si.area_sector
		),
		
		/* cant_camas */
		0,
		
		/* mover_camas */
		FALSE,
		
		/* area_id_efector_servicio */
		(SELECT 
			id_efector_servicio
		FROM
			efectores_servicios ese
		WHERE
			ese.cod_servicio = si.area_cod_servicio
		AND ese.sector = si.area_sector
		AND ese.subsector = si.area_subsector
		AND ese.id_efector = si.id_efector
		),
		
		/* area_cod_servicio */
		si.area_cod_servicio,
		
		/* area_sector */
		si.area_sector,
		
		/* area_subsector */
		si.area_subsector,
		
		/* baja */
		FALSE,
		
		/* fecha_modificacion */
		NULL
	
	FROM
		servicios_establecimientos_sipes_int si
	INNER JOIN 
		establecimientos_sipes es
	ON 
		CONCAT(si.cod_estab_depto,si.estab_nro,si.estab_tipo)=es.codigo
	
	WHERE
	
	/* con esta marca se controla que sea un efector informante. NOTA: en el */
	/* SIPES el mismo efector puede estar mas de una vez en la tabla servicios */
	/* establecimientos porque el tipo efector es parte de la clave, pero con */
	/* la marca de informante se asegura que sea el ultima clave de efector vigente */
		es.marca_informante = 'S'
		
	/* check efectores que no estan en el SIMS pero si en SIPES */
	AND si.id_efector IS NOT NULL
	AND si.cod_servicio='000';
		


		
/* ========== */
/* salas_hist */
/* ========== */

/* carga el historico de los areas(sala) de internacion en la tabla de salas_hist */
INSERT INTO 

	salas_hist
	
	SELECT
	
		/* id_sala_hist */
		0,
		
		/* id_sala */
		(SELECT 
			id_efector_servicio
		FROM
			efectores_servicios ese
		WHERE
			ese.cod_servicio = si.area_cod_servicio
		AND ese.sector = si.area_sector
		AND ese.subsector = si.area_subsector
		AND ese.id_efector = si.id_efector
		),
		
		/* fecha_apertura */
		si.fecha_apertura,
		
		/* fecha_cierre */
		IF(si.fecha_cierre ='0000-00-00',NULL,si.fecha_cierre),
		
		/* fecha_modificacion */
		NULL
		
	FROM
		servicios_establecimientos_sipes_int si
	INNER JOIN 
		establecimientos_sipes es
	ON 
		CONCAT(si.cod_estab_depto,si.estab_nro,si.estab_tipo)=es.codigo
	
	WHERE
	
	/* con esta marca se controla que sea un efector informante. NOTA: en el */
	/* SIPES el mismo efector puede estar mas de una vez en la tabla servicios */
	/* establecimientos porque el tipo efector es parte de la clave, pero con */
	/* la marca de informante se asegura que sea el ultima clave de efector vigente */
		es.marca_informante = 'S'
		
	/* check efectores que no estan en el SIMS pero si en SIPES */
	AND si.id_efector IS NOT NULL
	AND si.cod_servicio='000';
		
	
/* Actualiza el campo baja de las salas que tienen fecha de cierre */
UPDATE
	salas s,
	salas_hist sh
SET
	s.baja = TRUE
	
WHERE
	s.id_sala = sh.id_sala
AND sh.fecha_cierre IS NOT NULL
AND sh.fecha_apertura = (
	SELECT 
		MAX(sh2.fecha_apertura)
	FROM
		salas_hist sh2
	WHERE
		sh2.id_sala = s.id_sala
		);		
		

		
/* =============== */
/* servicios salas */
/* =============== */


/* carga la tabla de "servicios_salas" */
INSERT INTO

	servicios_salas
	
	SELECT
		
		/* id_servicio_sala */
		get_id_servicio_sala(
			(SELECT
			id_sala
				FROM
					salas s
				WHERE
					s.id_efector = si.id_efector
				AND s.area_cod_servicio = si.area_cod_servicio
				AND s.area_sector = si.area_sector
				AND s.area_subsector = si.area_subsector
			),
			si.id_servicio_estadistica
		),
			
		/* id_efector */
		si.id_efector,
		
		/* id_efector_servicio */
		get_id_efector_servicio(si.id_efector,si.id_servicio_estadistica),
		
		/* id_sala */
		(SELECT
			id_sala
		FROM
			salas s
		WHERE
			s.id_efector = si.id_efector
		AND s.area_cod_servicio = si.area_cod_servicio
		AND s.area_sector = si.area_sector
		AND s.area_subsector = si.area_subsector
		),
		
		/* agudo_cronico */
		si.cerrado_cronico,
		
		/* tipo_servicio_sala */
		si.tipo_servicio,
		
		/* baja */
		FALSE,
		
		/* fecha_modificacion */
		NULL
	
	FROM
		servicios_establecimientos_sipes_int si
	INNER JOIN 
		establecimientos_sipes es
	ON 
		CONCAT(si.cod_estab_depto,si.estab_nro,si.estab_tipo)=es.codigo
	
	WHERE
	
	/* con esta marca se controla que sea un efector informante. NOTA: en el */
	/* SIPES el mismo efector puede estar mas de una vez en la tabla servicios */
	/* establecimientos porque el tipo efector es parte de la clave, pero con */
	/* la marca de informante se asegura que sea el ultima clave de efector vigente */
		es.marca_informante = 'S'
		
	/* check efectores que no estan en el SIMS pero si en SIPES */
	AND si.id_efector IS NOT NULL
	AND si.cod_servicio<>'000';

	
	
			
/* ==================== */
/* servicios_salas_hist */
/* ==================== */
		
/* carga el historico de los servicios salas */
INSERT INTO 

	servicios_salas_hist
	
	SELECT
	
		/* id_servicio_sala_hist */
		0,
		
		/* id_servicio_sala */
		get_id_servicio_sala(
			(SELECT
			id_sala
				FROM
					salas s
				WHERE
					s.id_efector = si.id_efector
				AND s.area_cod_servicio = si.area_cod_servicio
				AND s.area_sector = si.area_sector
				AND s.area_subsector = si.area_subsector
			),
			si.id_servicio_estadistica
		),
		
		/* fecha_apertura */
		si.fecha_apertura,
		
		/* fecha_cierre */
		IF(si.fecha_cierre ='0000-00-00',NULL,si.fecha_cierre),
		
		/* fecha_modificacion */
		NULL
		
	FROM
		servicios_establecimientos_sipes_int si
	INNER JOIN 
		establecimientos_sipes es
	ON 
		CONCAT(si.cod_estab_depto,si.estab_nro,si.estab_tipo)=es.codigo
	
	WHERE
	
	/* con esta marca se controla que sea un efector informante. NOTA: en el */
	/* SIPES el mismo efector puede estar mas de una vez en la tabla servicios */
	/* establecimientos porque el tipo efector es parte de la clave, pero con */
	/* la marca de informante se asegura que sea el ultima clave de efector vigente */
		es.marca_informante = 'S'
		
	/* check efectores que no estan en el SIMS pero si en SIPES */
	AND si.id_efector IS NOT NULL
	AND si.cod_servicio<>'000';
	
	
/* Actualiza el campo baja de los servicios que tienen fecha de cierre */
UPDATE
	servicios_salas ss,
	servicios_salas_hist ssh
SET
	ss.baja = TRUE
	
WHERE
	ss.id_servicio_sala = ssh.id_servicio_sala
AND ssh.fecha_cierre IS NOT NULL
AND ssh.fecha_apertura = (
	SELECT 
		MAX(ssh2.fecha_apertura)
	FROM
		servicios_salas_hist ssh2
	WHERE
		ssh2.id_servicio_sala = ss.id_servicio_sala
		);			
		
		
	
