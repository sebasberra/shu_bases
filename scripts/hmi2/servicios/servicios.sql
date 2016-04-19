/* tablas HMI2 */
DROP TABLE IF EXISTS censos_diarios;
DROP TABLE IF EXISTS pases;
DROP TABLE IF EXISTS servicios_salas;
DROP TABLE IF EXISTS subservicios;
DROP TABLE IF EXISTS efectores_servicios;
/* DROP TABLE IF EXISTS servicios_estadistica; */
DROP TABLE IF EXISTS servicios;


/* tablas auxiliares para migracion sipes */
DROP TABLE IF EXISTS servicios_sipes;
DROP TABLE IF EXISTS servicios_estadistica_sipes;
DROP TABLE IF EXISTS servicios_establecimientos_sipes_int;
DROP TABLE IF EXISTS servicios_establecimientos_sipes_ce;

/* version */
REPLACE INTO versiones VALUES ("servicios","v 0.95a",NOW());


/* ------------------- */
/* servicios nucleares */
/* ------------------- */

/* crea la tabla auxiliar para migrar los servicios nucleares de nacion */
CREATE TABLE servicios_sipes(
	cod_servicio		CHAR(3)				NOT NULL,
	nom_servicio		VARCHAR(255)		NOT NULL
)ENGINE=MyISAM;

LOAD DATA LOCAL INFILE './servicios_nuclear_sipes.txt' 
	INTO TABLE servicios_sipes
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n';
	
	
/* Crea la tabla de servicios nuclear */
CREATE TABLE servicios (
	id_servicio 		INTEGER UNSIGNED 	NOT NULL AUTO_INCREMENT,
	cod_servicio 		CHAR(3) 			NOT NULL,
	nom_servicio 		VARCHAR(255) 		NOT NULL,
	nom_red_servicio 	VARCHAR(30)			NOT NULL,
	PRIMARY KEY(id_servicio),
	UNIQUE INDEX idx_unique_cod_servicio (cod_servicio)
)
COMMENT 'servicios que establecio nacion a partir del año 2008'
ENGINE=InnoDB;


/* carga la tabla de servicios con informacion obtenida del sipes */
INSERT INTO servicios
	
	SELECT	0,
			ssip.cod_servicio,
			TRIM(ssip.nom_servicio),
			LEFT(TRIM(ssip.nom_servicio),30)
	
	FROM	servicios_sipes ssip;
	
	
	
	
	
	
/* --------------------- */
/* servicios_estadistica */	
/* --------------------- */

/* crea la tabla auxiliar para migrar los servicios de estadistiva */
CREATE TABLE servicios_estadistica_sipes(
	cod_servicio		CHAR(3)				NOT NULL,
	sector				CHAR(1)				NOT NULL,
	subsector			CHAR(1)				NOT NULL,
	nom_servicio		VARCHAR(255)		NOT NULL,
	tipo_servicio		CHAR(1)				NOT NULL
)ENGINE=MyISAM;
	
LOAD DATA LOCAL INFILE './servicios_estadistica_sipes.txt' 
	INTO TABLE servicios_estadistica_sipes
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\r\n';
	
/* crea la tabla de servicios de estadistica para el hmi2 */
CREATE IF NOT EXISTS TABLE servicios_estadistica (
	id_servicio_estadistica 		INTEGER 	UNSIGNED 	NOT NULL AUTO_INCREMENT,
	id_servicio 					INTEGER(10) UNSIGNED 	NOT NULL,
	cod_servicio 					CHAR(3) 				NOT NULL COMMENT 'codigo nuclear de servicios de nacion vigente desde 2008',
	sector 							CHAR(1) 				NOT NULL COMMENT '1=varones; 2=mujeres; 3=mixto',
	subsector 						CHAR(1) 				NOT NULL COMMENT '4=internacion; 5=CE; 6=atencion domiciliaria',
	nom_servicio_estadistica 		VARCHAR(255) 			NOT NULL,
	nom_red_servicio_estadistica 	VARCHAR(30) 			NOT NULL,
	tipo_servicio_estadistica 		TINYINT 	UNSIGNED 	NOT NULL COMMENT '1=medico; 2=no medico',
	PRIMARY KEY(id_servicio_estadistica),
	CONSTRAINT fk_servicios_estadistica_id_servicio FOREIGN KEY fk_id_servicio (id_servicio)
    REFERENCES servicios(id_servicio)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	UNIQUE INDEX idx_unique_cod_servicio_sector_subsector(cod_servicio, sector, subsector)	

)
COMMENT 'servicios que maneja estadistica de la provincia de santa fe'
ENGINE=InnoDB;


/* carga la tabla de "servicios_estadistica" que se usara en el hmi2 */
INSERT INTO servicios_estadistica
	SELECT	0,
			(SELECT id_servicio
				FROM servicios s
				WHERE ses.cod_servicio = s.cod_servicio),
			ses.cod_servicio,
			ses.sector,
			ses.subsector,
			TRIM(ses.nom_servicio),
			LEFT(TRIM(ses.nom_servicio),30),
			ses.tipo_servicio
	
		FROM servicios_estadistica_sipes ses
		
	ON DUPLICATE KEY UPDATE
	
		id_servicio = (SELECT ss.id_servicio
				FROM servicios ss
				WHERE ses.cod_servicio = ss.cod_servicio),
		nom_servicio_estadistica = TRIM(ses.nom_servicio),
		nom_red_servicio_estadistica = LEFT(TRIM(ses.nom_servicio),30),
		tipo_servicio_estadistica = ses.tipo_servicio;
				

		
		
		

/* ------------------- */	
/* efectores_servicios */
/* ------------------- */

/* ------------------------ */
/* servicios de internacion */
/* ------------------------ */
		
/* crea tabla auxiliar para migrar los servicios de internacion traidos del sipes */
CREATE TABLE servicios_establecimientos_sipes_int(
	cod_servicio		CHAR(3)		NOT NULL,
	sector				CHAR(1)		NOT NULL,
	subsector			CHAR(1)		NOT NULL,
	cod_servicio_area	CHAR(3)		NOT NULL,
	claveestd			CHAR(8)		NOT NULL,
	tipo_est			CHAR(1)		NOT NULL,
	tipo_servicio		CHAR(1)		NOT NULL,
	dd_apertura			CHAR(2)		NOT NULL,
	mm_apertura			CHAR(2)		NOT NULL,
	aaaa_apertura		CHAR(4)		NOT NULL,
	dd_cierre			CHAR(2)		NOT NULL,
	mm_cierre			CHAR(2)		NOT NULL,
	aaaa_cierre			CHAR(4)		NOT NULL

)ENGINE=MyISAM;

LOAD DATA LOCAL INFILE './efectores_servicios_int_sipes.txt' 
	INTO TABLE servicios_establecimientos_sipes_int
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES;

	
/* -------------------------------- */
/* servicios de consultorio externo */
/* -------------------------------- */	
	
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

LOAD DATA LOCAL INFILE './efectores_servicios_ce_sipes.txt' 
	INTO TABLE servicios_establecimientos_sipes_ce
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n';

/* crea la tabla de efectores servicios */
CREATE TABLE efectores_servicios(
	id_efector_servicio				INTEGER 	UNSIGNED 	NOT NULL AUTO_INCREMENT,
	id_efector 						INTEGER		UNSIGNED	NULL,
  	id_servicio_estadistica			INTEGER		UNSIGNED	NOT NULL,
  	claveestd						CHAR(8)					NOT NULL COMMENT 'codigo de establecimiento de 8 digitos obtenido del mod_sims',
  	cod_servicio					CHAR(3)					NOT NULL COMMENT 'codigo nuclear de servicios de nacion vigente desde 2008',
  	sector							CHAR(1)					NOT NULL COMMENT '1=varones; 2=mujeres; 3=mixto',
  	subsector						CHAR(1)					NOT NULL COMMENT '4=internacion; 5=CE; 6=atencion domiciliaria',
  	nom_servicio_estadistica		VARCHAR(255)			NOT NULL COMMENT 'Nombre del servicio de estadistica. Este campo se agrego para facilitar los select y reportes en programacion',
  	fecha_apertura					DATE					NOT NULL COMMENT 'fecha apertura = 01/01/2008 por los cambios de los codigos de servicios',
  	fecha_cierre					DATE					NULL,
  	fecha_modificacion				TIMESTAMP				NOT NULL DEFAULT 
																			CURRENT_TIMESTAMP 
																		ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(id_efector_servicio),
	CONSTRAINT fk_efectores_servicios_id_efector FOREIGN KEY idx_id_efector (id_efector)
    	REFERENCES efectores(id_efector)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_efectores_servicios_id_servicio_estadistica FOREIGN KEY idx_id_servicio_estadistica (id_servicio_estadistica)
    	REFERENCES servicios_estadistica(id_servicio_estadistica)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	UNIQUE INDEX idx_unique_claveestd_cod_servicio_sector_subsector
						(claveestd,cod_servicio, sector, subsector,fecha_apertura)
)
COMMENT 'servicios habilitados por estadistica en el efector'
ENGINE=InnoDB;


/* inserta los datos de efectores-servicios de internacion */
INSERT INTO efectores_servicios
	SELECT	DISTINCT 0,
			(SELECT id_efector 
				FROM efectores e
				WHERE sesi.claveestd = e.claveestd),
			(SELECT id_servicio_estadistica
				FROM servicios_estadistica se
				WHERE	sesi.cod_servicio	= se.cod_servicio
				AND		sesi.sector			= se.sector
				AND		sesi.subsector		= se.subsector),
			sesi.claveestd,
			sesi.cod_servicio,
			sesi.sector,
			sesi.subsector,
			(SELECT nom_servicio_estadistica
				FROM servicios_estadistica se
				WHERE	sesi.cod_servicio	= se.cod_servicio
				AND		sesi.sector			= se.sector
				AND		sesi.subsector		= se.subsector),
			CONCAT(sesi.aaaa_apertura,'-',sesi.mm_apertura,'-',sesi.dd_apertura),
			NULL,
			CURRENT_TIMESTAMP
	FROM servicios_establecimientos_sipes_int sesi
	WHERE cod_servicio_area<>'000';
	

/* inserta los datos de efectores-servicios de consultorio externo */
INSERT INTO efectores_servicios
	SELECT	0,
			(SELECT id_efector 
				FROM efectores e
				WHERE CONCAT(sesc.cod_estab_depto,sesc.estab_nro) = e.claveestd),
			(SELECT id_servicio_estadistica
				FROM servicios_estadistica se
				WHERE	sesc.cod_servicio	= se.cod_servicio
				AND		sesc.sector			= se.sector
				AND		sesc.subsector		= se.subsector),
			CONCAT(sesc.cod_estab_depto,sesc.estab_nro),
			sesc.cod_servicio,
			sesc.sector,
			sesc.subsector,
			(SELECT nom_servicio_estadistica
				FROM servicios_estadistica se
				WHERE	sesc.cod_servicio	= se.cod_servicio
				AND		sesc.sector			= se.sector
				AND		sesc.subsector		= se.subsector),
			CONCAT( RIGHT(sesc.fecha_apertura_ce,4),
					'-',
					LEFT(RIGHT(sesc.fecha_apertura_ce,7),2),
					'-',
					LEFT(sesc.fecha_apertura_ce,2)
					),
			NULL,
			CURRENT_TIMESTAMP
	FROM servicios_establecimientos_sipes_ce sesc;

	
/* subservicios */	
CREATE TABLE subservicios (
	id_subservicio				INTEGER		UNSIGNED	NOT NULL AUTO_INCREMENT,
	id_efector_servicio 		INTEGER		UNSIGNED	NOT NULL,
	id_servicio 				INTEGER		UNSIGNED	NOT NULL,
	claveestd 					CHAR(8)					NOT NULL,
	cod_servicio 				CHAR(3)					NOT NULL,
	fecha_modificacion			TIMESTAMP				NOT NULL	DEFAULT 
																			CURRENT_TIMESTAMP 
																		ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(id_subservicio),
	CONSTRAINT fk_subservicios_id_efector_servicio FOREIGN KEY idx_id_efector_servicio (id_efector_servicio)
		REFERENCES efectores_servicios(id_efector_servicio)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_subservicios_id_servicio FOREIGN KEY idx_id_servicio (id_servicio)
		REFERENCES servicios(id_servicio)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	INDEX idx_claveestd_cod_servicio(claveestd, cod_servicio),
	UNIQUE INDEX idx_unique_id_efector_servicio_id_servicio(id_efector_servicio, id_servicio)
)
ENGINE=InnoDB;

	
/* servicios_salas */
CREATE TABLE servicios_salas (
	id_servicio_sala 			INTEGER 	UNSIGNED 	NOT NULL AUTO_INCREMENT,
	id_efector_servicio 		INTEGER		UNSIGNED	NOT NULL,
	id_sala 					INTEGER 	UNSIGNED 	NOT NULL,
	baja						BOOLEAN					NOT NULL 	COMMENT 'Se puede dar de baja a un servicio de una sala y mantener los pases de este',
	fecha_modificacion			TIMESTAMP				NOT NULL	DEFAULT 
																			CURRENT_TIMESTAMP 
																		ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(id_servicio_sala),
	CONSTRAINT fk_servicios_salas_id_sala FOREIGN KEY idx_id_sala (id_sala)
		REFERENCES salas(id_sala)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_servicios_salas_id_efector_servicio FOREIGN KEY idx_id_efector_servicio (id_efector_servicio)
		REFERENCES efectores_servicios(id_efector_servicio)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	UNIQUE INDEX idx_unique_id_efector_servicio_id_sala  (id_efector_servicio,id_sala)
)
ENGINE=InnoDB;

/* censos_diarios */
CREATE TABLE censos_diarios (
	id_censo_diario 			INTEGER 	UNSIGNED 	NOT NULL 	AUTO_INCREMENT,
	id_efector_servicio			INTEGER 	UNSIGNED 	NULL					COMMENT 'Cuando id_efector_servicio IS NULL entonces es el total de la sala',
	id_sala 					INTEGER 	UNSIGNED 	NOT NULL				COMMENT 'Id de la sala censada',
	fecha_censo					DATE					NOT NULL				COMMENT 'Dia del censo',
	existencia_0 				SMALLINT 	 			NOT NULL	DEFAULT 0	COMMENT 'Es la cantidad de pacientes que estan en la sala a las 0hs',
	ingresos 					SMALLINT 	UNSIGNED 	NOT NULL	DEFAULT 0	COMMENT 'Es la cantidad de pacientes que ingresaron, sin contar los pases_de',
	pases_de 					SMALLINT 	UNSIGNED 	NOT NULL	DEFAULT 0	COMMENT 'Es la cantidad de ingresos de pacientes que provienen de otras salas',
	altas 						SMALLINT 	UNSIGNED 	NOT NULL	DEFAULT 0	COMMENT 'Es la cantidad de egresos por alta',
	defunciones_menos_48 		SMALLINT 	UNSIGNED 	NOT NULL	DEFAULT 0	COMMENT 'Es la cantidad de pacientes que fallecieron ese dia y estuvieron internados en esa sala menos de 48 hs',
	defunciones_mas_48 			SMALLINT 	UNSIGNED 	NOT NULL	DEFAULT 0	COMMENT 'Es la cantidad de pacientes que fallecieron ese dia y estuvieron internados en esa sala mas de 48 hs',
	pases_a 					SMALLINT 	UNSIGNED 	NOT NULL	DEFAULT 0	COMMENT 'Son los pacientes que pasaron a otra sala',
	existencia_24 				SMALLINT 	 			NOT NULL	DEFAULT 0	COMMENT 'existencia_0 + los ingresos + pases_de - egresos - pases_a',
	entradas_salidas_dia 		SMALLINT 	UNSIGNED 	NOT NULL	DEFAULT 0	COMMENT 'Son solo los pacientes que entraron y egresaron (por alta u obito) ese dia, sin tener en cuenta los pases',
	pacientes_dia 				SMALLINT 			 	NOT NULL	DEFAULT 0	COMMENT 'Es la suma de la existencia 24hs mas la cantidad de pacientes que entraron ese dia, sin importar que se hallan ido',
	dias_estada					SMALLINT	UNSIGNED	NOT NULL	DEFAULT 0	COMMENT 'Es la sumatoria de los dias que estuvieron internados los pacientes egresados ese dia',
	total_camas_sala			SMALLINT	UNSIGNED	NOT NULL	DEFAULT 0	COMMENT 'Es el total de camas que esten en condiciones de uso o en uso de esa sala para ese dia. Editable por programa',
	camas_disponibles 			SMALLINT 	UNSIGNED 	NOT NULL	DEFAULT 0	COMMENT 'Son la cantidad de camas que existen en esa sala, sin tener en cuenta el estado de la cama',
	baja						BOOLEAN					NOT NULL	DEFAULT 0,
	fecha_modificacion			TIMESTAMP				NOT NULL	DEFAULT 
																			CURRENT_TIMESTAMP 
																		ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(id_censo_diario),
	CONSTRAINT fk_censos_diarios_id_sala FOREIGN KEY idx_id_sala (id_sala)
		REFERENCES salas(id_sala)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_censos_diarios_id_efector_servicio FOREIGN KEY idx_id_efector_servicio (id_efector_servicio)
		REFERENCES efectores_servicios(id_efector_servicio)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	INDEX idx_id_efector_servicio(id_efector_servicio),
	INDEX idx_id_sala(id_sala),
	INDEX idx_fecha_censo(fecha_censo)
)
ENGINE=InnoDB;


/* pases */
CREATE TABLE pases (
	id_pase 					INTEGER 	UNSIGNED 	NOT NULL 	AUTO_INCREMENT,
	id_censo_diario				INTEGER 	UNSIGNED 	NULL,
	id_internacion 				INTEGER 	UNSIGNED 	NOT NULL,
	id_servicio_sala_entrada	INTEGER 	UNSIGNED 	NOT NULL,
	fecha_entrada				DATETIME				NOT NULL,
	tipo_entrada				CHAR(1)					NOT NULL	COMMENT 'I=ingreso; P=pase de; R=Reingreso;',
	id_servicio_sala_salida		INTEGER 	UNSIGNED 	NULL,
	fecha_salida				DATETIME				NULL,
	tipo_salida					CHAR(1)					NULL		COMMENT 'A=alta medica; O=obito; P=pase a; T=alta transitoria;',
	dias_estada					SMALLINT	UNSIGNED	NOT NULL	DEFAULT 0 COMMENT 'fecha_entrada - fecha_salida + 1 o 0 si fecha_salida es NULL',
	id_pase_siguiente			INTEGER 	UNSIGNED 	NULL		COMMENT 'id_pase del siguiente pase, si existe',
	id_habitacion				INTEGER		UNSIGNED	NOT NULL	COMMENT 'id_habitacion de la cama en ese momento (permite movimiento de camas)',
	id_cama 					INTEGER 	UNSIGNED 	NOT NULL	COMMENT 'No debe restringir el ingreso si la cama esta ocupada',
	estado_pase 				CHAR(1) 				NOT NULL 	COMMENT 'P=pendiente; A=aceptado; E=egresado; I=inconcluso (altas donde el paciente no se retiro del hospital);',
	observacion_pase 			TEXT		 			NULL,
	baja						BOOLEAN					NOT NULL	DEFAULT 0,
	fecha_modificacion			TIMESTAMP				NOT NULL	DEFAULT 
																			CURRENT_TIMESTAMP 
																		ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(id_pase),
	CONSTRAINT fk_pases_id_internacion FOREIGN KEY idx_id_internacion (id_internacion)
		REFERENCES internaciones(id_internacion)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_pases_id_servicio_sala_entrada FOREIGN KEY idx_id_servicio_sala_entrada (id_servicio_sala_entrada)
		REFERENCES servicios_salas(id_servicio_sala)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_pases_id_servicio_sala_salida FOREIGN KEY idx_id_servicio_sala_salida (id_servicio_sala_salida)
		REFERENCES servicios_salas(id_servicio_sala)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_pases_id_habitacion FOREIGN KEY idx_id_habitacion (id_habitacion)
		REFERENCES habitaciones(id_habitacion)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_pases_id_cama FOREIGN KEY idx_id_cama (id_cama)
		REFERENCES camas(id_cama)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_pases_id_censo_diario FOREIGN KEY idx_id_censo_diario (id_censo_diario)
		REFERENCES censos_diarios(id_censo_diario)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_pases_id_pase_siguiente FOREIGN KEY idx_id_pase_siguiente (id_pase_siguiente)
		REFERENCES pases(id_pase)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	INDEX idx_fecha_entrada (fecha_entrada),
	INDEX idx_fecha_salida (fecha_salida)
);


/* ---------------------------------------------------------- */
/* Carga la tabla de "salas" con los servicios de internacion */
/* ---------------------------------------------------------- */
DELETE FROM salas;

INSERT INTO salas
	SELECT	0,
			(SELECT id_efector 
				FROM efectores e
				WHERE sesi.claveestd = e.claveestd),
			(SELECT nom_servicio_estadistica
				FROM servicios_estadistica se
				WHERE	sesi.cod_servicio	= se.cod_servicio
				AND		sesi.sector			= se.sector
				AND		sesi.subsector		= se.subsector),
			0,
			0,
			CURRENT_TIMESTAMP
	FROM servicios_establecimientos_sipes_int sesi
	WHERE cod_servicio_area='000';
	

/* -------------------------------------------------------------------- */
/* Carga la tabla de "servicios_salas" con los servicios de internacion */
/* -------------------------------------------------------------------- */
INSERT INTO servicios_salas
	SELECT	0,
			(SELECT id_efector_servicio 
				FROM efectores_servicios es
				WHERE	sesi.claveestd 			= es.claveestd
				AND		sesi.cod_servicio_area 	= es.cod_servicio
				AND		sesi.sector 			= es.sector
				AND		sesi.subsector			= es.subsector),
	
			(SELECT id_sala 
				FROM salas
				
				WHERE 	id_efector = (SELECT id_efector 
										FROM efectores e
										WHERE	sesi.claveestd = e.claveestd)
				AND
				
						nombre = (SELECT nom_servicio_estadistica
									FROM servicios_estadistica se
									WHERE	sesi.cod_servicio	= se.cod_servicio
									AND		sesi.sector			= se.sector
									AND		sesi.subsector		= se.subsector)
			),
			0,
			CURRENT_TIMESTAMP
			
	FROM servicios_establecimientos_sipes_int sesi
	WHERE	cod_servicio_area<>'000'
	AND		(SELECT id_efector_servicio 
				FROM efectores_servicios es
				WHERE	sesi.claveestd 			= es.claveestd
				AND		sesi.cod_servicio_area 	= es.cod_servicio
				AND		sesi.sector 			= es.sector
				AND		sesi.subsector			= es.subsector) IS NOT NULL;
	
DROP TABLE servicios_sipes;
DROP TABLE servicios_estadistica_sipes;
DROP TABLE servicios_establecimientos_sipes_int;
DROP TABLE servicios_establecimientos_sipes_ce;

/* Se agregan los indices a la tabla internaciones que referencian a la tabla de servicios de estadistica */
ALTER TABLE internaciones ADD
	CONSTRAINT fk_internaciones_ing_id_servicio_estadistica FOREIGN KEY idx_ing_id_servicio_estadistica (ing_id_servicio_estadistica)
		REFERENCES servicios_estadistica(id_servicio_estadistica)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION;

ALTER TABLE internaciones ADD
	CONSTRAINT fk_internaciones_egr_id_servicio_estadistica FOREIGN KEY idx_egr_id_servicio_estadistica (egr_id_servicio_estadistica)
		REFERENCES servicios_estadistica(id_servicio_estadistica)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION;