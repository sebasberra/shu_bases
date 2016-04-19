/* drops */
DROP TABLE IF EXISTS diagnosticos;
DROP TABLE IF EXISTS ciex_restricciones;
DROP TABLE IF EXISTS ciex_titulos;
DROP TABLE IF EXISTS ciex_4;
DROP TABLE IF EXISTS ciex_3;
DROP TABLE IF EXISTS ciex_frecuentes_servicios;
DROP TABLE IF EXISTS servicios_sipes;
DROP TABLE IF EXISTS patologiascomunes;
DROP TABLE IF EXISTS temp_servicios;
DROP TABLE IF EXISTS servicios;

/* versiones */
CREATE TABLE versiones (
	base	VARCHAR(255) NOT NULL,	
	version VARCHAR(255) NOT NULL,
	fecha 	DATETIME NOT NULL,
	PRIMARY KEY (base)
);

REPLACE INTO versiones VALUES ('ciex','v 0.35a',NOW());

/* ciex 3 */
CREATE TABLE ciex_3 (
	id_ciex_3 							INTEGER 	UNSIGNED 	NOT NULL 	AUTO_INCREMENT,
	cod_3dig 							CHAR(3) 				NOT NULL,
	descripcion 						VARCHAR(255) 			NOT NULL,
	desc_red 							VARCHAR(50) 			NOT NULL,
	PRIMARY KEY(id_ciex_3),
	UNIQUE INDEX idx_unique_cod_3dig(cod_3dig),
	INDEX idx_descripcion(descripcion)
)ENGINE=InnoDB;

INSERT INTO ciex_3

	SELECT	0,
			c.cod3dig,
			TRIM(c.descripcion),
			LEFT(TRIM(c.descripcion),50)
			
		FROM ciex.ciex3car c;
		
				
/* ciex 4 */
CREATE TABLE ciex_4 (
	id_ciex_4 							INTEGER 	UNSIGNED 	NOT NULL 	AUTO_INCREMENT,
	id_ciex_3 							INTEGER 	UNSIGNED 	NOT NULL,
	cod_3dig 							CHAR(3) 				NOT NULL,
	cod_4dig 							CHAR(1) 				NOT NULL,
	descripcion 						VARCHAR(255) 			NOT NULL,
	desc_red 							VARCHAR(50) 			NOT NULL,
	informa_c2							ENUM('0','1','2')		NOT NULL	COMMENT '0 = no informa; 1 = informar inmediatamente; 2 = informar semanalmente',
	PRIMARY KEY(id_ciex_4),
	UNIQUE INDEX idx_unique_cod_3dig_cod_4dig(cod_3dig, cod_4dig),
	INDEX idx_descripcion(descripcion),
	FOREIGN KEY(id_ciex_3)
		REFERENCES ciex_3(id_ciex_3)
		  ON DELETE NO ACTION
		  ON UPDATE NO ACTION
)ENGINE=InnoDB;


INSERT INTO ciex_4

	SELECT	0,
			(SELECT c3.id_ciex_3
				FROM ciex_3 c3
				WHERE	c.cod3dig = c3.cod_3dig
			),
			c.cod3dig,
			c.cod4dig,
			TRIM(c.descripcion),
			LEFT(TRIM(c.descripcion),50),
			'0'
			
		FROM	ciex.catego c;
			
/* actualiza patologias que informan al c2 inmediatamente */
UPDATE ciex_4 
	SET informa_c2 = '1'
	WHERE	(cod_3dig = 'A05'		AND		cod_4dig='1')
	OR		(cod_3dig = 'B57'		AND		cod_4dig='1')
	OR		(cod_3dig = 'A00'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A90'		AND		cod_4dig='X')
	OR		(cod_3dig = 'A91'		AND		cod_4dig='X')
	OR		(cod_3dig = 'A36'		AND		cod_4dig='9')
	OR		(cod_3dig = 'G04'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A81'		AND		cod_4dig='0')
	OR		(cod_3dig = 'A95'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A96'		AND		cod_4dig='0')
	OR		(cod_3dig = 'A68'		AND		cod_4dig='0')
	OR		(cod_3dig = 'J12'		AND		cod_4dig='8')
	OR		(cod_3dig = 'T61'		AND		cod_4dig='2')
	OR		(cod_3dig = 'G00'		AND		cod_4dig='9')
	OR		(cod_3dig = 'G03'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A17'		AND		cod_4dig='0')
	OR		(cod_3dig = 'A87'		AND		cod_4dig='9')
	OR		(cod_3dig = 'B54'		AND		cod_4dig='X')
	OR		(cod_3dig = 'G83'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A20'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A80'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A70'		AND		cod_4dig='X')
	OR		(cod_3dig = 'A82'		AND		cod_4dig='9')
	OR		(cod_3dig = 'P35'		AND		cod_4dig='0')
	OR		(cod_3dig = 'B05'		AND		cod_4dig='9')
	OR		(cod_3dig = 'D59'		AND		cod_4dig='3')
	OR		(cod_3dig = 'A35'		AND		cod_4dig='X')
	OR		(cod_3dig = 'A33'		AND		cod_4dig='X')
	OR		(cod_3dig = 'A75'		AND		cod_4dig='0')
	OR		(cod_3dig = 'A75'		AND		cod_4dig='2')
	OR		(cod_3dig = 'A05'		AND		cod_4dig='9')
	OR		(cod_3dig = 'B75'		AND		cod_4dig='X')
	OR		(cod_3dig = 'B03'		AND		cod_4dig='X');
	
/* actualiza patologias que informan al c2 semanalmente */
UPDATE ciex_4 
	SET informa_c2 = '2'
	WHERE	(cod_3dig = 'X59'		AND		cod_4dig='0')
	OR		(cod_3dig = 'V89'		AND		cod_4dig='0')
	OR		(cod_3dig = 'T63'		AND		cod_4dig='3')
	OR		(cod_3dig = 'A23'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A22'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A57'		AND		cod_4dig='X')
	OR		(cod_3dig = 'A56'		AND		cod_4dig='1')
	OR		(cod_3dig = 'A38'		AND		cod_4dig='X')
	OR		(cod_3dig = 'T63'		AND		cod_4dig='2')
	OR		(cod_3dig = 'B65'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A01'		AND		cod_4dig='4')
	OR		(cod_3dig = 'I00'		AND		cod_4dig='X')
	OR		(cod_3dig = 'A01'		AND		cod_4dig='0')
	OR		(cod_3dig = 'A58'		AND		cod_4dig='X')
	OR		(cod_3dig = 'B15'		AND		cod_4dig='9')
	OR		(cod_3dig = 'B16'		AND		cod_4dig='9')
	OR		(cod_3dig = 'B17'		AND		cod_4dig='1')
	OR		(cod_3dig = 'B17'		AND		cod_4dig='0')
	OR		(cod_3dig = 'B17'		AND		cod_4dig='2')
	OR		(cod_3dig = 'B19'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A60'		AND		cod_4dig='0')
	OR		(cod_3dig = 'A67'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A54'		AND		cod_4dig='9')
	OR		(cod_3dig = 'T60'		AND		cod_4dig='9')
	OR		(cod_3dig = 'B55'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A30'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A27'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A55'		AND		cod_4dig='X')
	OR		(cod_3dig = 'J18'		AND		cod_4dig='9')
	OR		(cod_3dig = 'T63'		AND		cod_4dig='0')
	OR		(cod_3dig = 'B26'		AND		cod_4dig='9')
	OR		(cod_3dig = 'Z24'		AND		cod_4dig='2')
	OR		(cod_3dig = 'B06'		AND		cod_4dig='9')
	OR		(cod_3dig = 'B24'		AND		cod_4dig='X')
	OR		(cod_3dig = 'A50'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A51'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A53'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A37'		AND		cod_4dig='9')
	OR		(cod_3dig = 'B58'		AND		cod_4dig='9')
	OR		(cod_3dig = 'A16'		AND		cod_4dig='9')
	OR		(cod_3dig = 'N34'		AND		cod_4dig='1')
	OR		(cod_3dig = 'B01'		AND		cod_4dig='9')
	OR		(cod_3dig = 'B24'		AND		cod_4dig='X');
	
/* titulos */
CREATE TABLE ciex_titulos (
	id_ciex_titulo	 					INTEGER 	UNSIGNED 	NOT NULL 	AUTO_INCREMENT,
	id_ciex_3_desde 					INTEGER 	UNSIGNED 	NOT NULL,
	id_ciex_3_hasta 					INTEGER 	UNSIGNED 	NOT NULL,
	capitulo 							CHAR(2) 				NOT NULL,
	grupo 								CHAR(2) 				NOT NULL,
	subgrupo 							CHAR(2) 				NOT NULL,
	cod_3dig_desde 						CHAR(3) 				NOT NULL,
	cod_3dig_hasta 						CHAR(3) 				NOT NULL,
	descripcion 						VARCHAR(255) 			NOT NULL,
	desc_red 							VARCHAR(50) 			NOT NULL,
	PRIMARY KEY(id_ciex_titulo),
	INDEX idx_cod_3dig_desde(cod_3dig_desde),
	INDEX idx_cod_3dig_hasta(cod_3dig_hasta),
	FOREIGN KEY(id_ciex_3_desde)
		REFERENCES ciex_3(id_ciex_3)
			  ON DELETE NO ACTION
			  ON UPDATE NO ACTION,
	FOREIGN KEY(id_ciex_3_hasta)
		REFERENCES ciex_3(id_ciex_3)
			  ON DELETE NO ACTION
			  ON UPDATE NO ACTION
)ENGINE=InnoDB;

INSERT INTO ciex_titulos

	SELECT	0,
			(SELECT c3.id_ciex_3
				FROM ciex_3 c3
				WHERE	tx.cod3dig_desde = c3.cod_3dig
			),
			(SELECT c3.id_ciex_3
				FROM ciex_3 c3
				WHERE	tx.cod3dig_hasta = c3.cod_3dig
			),
			tx.capitulo,
			tx.grupo,
			tx.subgrupo,
			tx.cod3dig_desde,
			tx.cod3dig_hasta,
			TRIM(tx.descripcion),
			LEFT(TRIM(tx.descripcion),50)
			
		FROM ciex.tx307 tx;
			
			
/* restricciones */
CREATE TABLE ciex_restricciones (
	id_ciex_restriccion 				INTEGER 	UNSIGNED 	NOT NULL 	AUTO_INCREMENT,
	id_ciex_4 							INTEGER 	UNSIGNED 	NULL,
	id_ciex_3 							INTEGER 	UNSIGNED 	NULL,
	cod_3dig 							CHAR(3) 				NOT NULL,
	cod_4dig 							CHAR(1) 				NULL,
	sexo 								TINYINT 	UNSIGNED 	NOT NULL    COMMENT '0=no tiene restriccion; 1=solo masculino; 2=solo femenino',                
	frecuencia		 					TINYINT 	UNSIGNED 	NOT NULL 	COMMENT '0=no tiene restriccion; 1=poco frecuente; 2=no puede aparecer',            
	tipoedad_min 						TINYINT 	UNSIGNED 	NOT NULL    COMMENT '0=no tiene restriccion; 1=años; 2=meses; 3=dias; 4=horas; 5=100 y+',       
	edad_min 							TINYINT 	UNSIGNED 	NOT NULL,                                                                                             
	tipoedad_max 						TINYINT 	UNSIGNED 	NOT NULL    COMMENT '1=años; 2=meses; 3=dias; 4=horas; 5=100 y+; 9=no tiene restriccion maxima',
	edad_max 							TINYINT 	UNSIGNED 	NOT NULL,                                                                                             
	restriccion_edad 					TINYINT 	UNSIGNED 	NOT NULL 	COMMENT '0=no tiene; 1=puede pasar; 2=no puede pasar',                               
	PRIMARY KEY(id_ciex_restriccion),
	UNIQUE INDEX idx_unique_cod_3dig_cod_4dig(cod_3dig, cod_4dig),
	FOREIGN KEY(id_ciex_3)
		REFERENCES ciex_3(id_ciex_3)
			  ON DELETE NO ACTION
			  ON UPDATE NO ACTION,
	FOREIGN KEY(id_ciex_4)
		REFERENCES ciex_4(id_ciex_4)
			  ON DELETE NO ACTION
			  ON UPDATE NO ACTION
)ENGINE=InnoDB;

INSERT INTO ciex_restricciones

	SELECT	0,
			
			(SELECT c4.id_ciex_4
				FROM ciex_4 c4
				WHERE	r.cod3dig = c4.cod_3dig
				AND		r.cod4dig = c4.cod_4dig
			),
			IF(r.cod4dig IS NOT NULL,
				NULL,
				(SELECT c3.id_ciex_3
					FROM ciex_3 c3
					WHERE	r.cod3dig = c3.cod_3dig)
			),
			r.cod3dig,
			r.cod4dig,
			r.sexo,
			r.frecuencia,
			r.tipoedad_min,
			r.edad_min,
			r.tipoedad_max,
			r.edad_max,
			r.restriccion_edad
			
		FROM ciex.restric r;


		
/*		
/* NOTA: la creacion de servicios nucleares se tomo del script "servicios.sql"
/*		
/* ------------------- */
/* servicios nucleares */
/* ------------------- */

/* crea la tabla auxiliar para migrar los servicios nucleares de nacion */
CREATE TABLE servicios_sipes(
	cod_servicio		CHAR(3)				NOT NULL,
	nom_servicio		VARCHAR(255)		NOT NULL
)ENGINE=MyISAM;

LOAD DATA LOCAL INFILE '../hmi2/servicios/servicios_nuclear_sipes.txt' 
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
	
/* ---------------------- */
/* FIN de servicios SIPES */
/* ---------------------- */
	


/* bs_sicap.patologiascomunes */
CREATE TABLE patologiascomunes (
  Servicio 					CHAR(3) 	NOT NULL 	DEFAULT '',
  CepsapCodigo 				VARCHAR(4) 	NOT NULL 	DEFAULT '',
  PRIMARY KEY  (Servicio,CepsapCodigo)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOAD DATA LOCAL INFILE './auxiliares/patologiascomunes.csv' 
	INTO TABLE patologiascomunes
	FIELDS	TERMINATED BY ';'
			ENCLOSED BY '"'
	LINES TERMINATED BY '\n';

/* bs_sicap.temp_servicios */
CREATE TABLE temp_servicios (
  cod_viejo 				VARCHAR(3) 	NOT NULL,
  descripcion 				VARCHAR(60) NOT NULL,
  cod_nuevo 				VARCHAR(3) 	NOT NULL,
  nombre 					VARCHAR(60) NOT NULL,
  tipo 						VARCHAR(1) 	NOT NULL,
  tipo_1 					VARCHAR(1) 	NOT NULL,
  PRIMARY KEY  (cod_nuevo)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
		
LOAD DATA LOCAL INFILE './auxiliares/temp_servicios.csv' 
	INTO TABLE temp_servicios
	FIELDS	TERMINATED BY ';'
			ENCLOSED BY '"'
	LINES TERMINATED BY '\n';
	
	
/* tabla de patologias frecuentes por servicio */	
CREATE TABLE ciex_frecuentes_servicios (
  id_ciex_frecuente_servicio 			INTEGER 		UNSIGNED 	NOT NULL 	AUTO_INCREMENT,
  id_servicio 							INTEGER(10) 	UNSIGNED 	NULL,
  id_ciex_4 							INTEGER 		UNSIGNED 	NOT NULL,
  cod_servicio 							CHAR(3) 					NULL,
  cod_3dig 								CHAR(3) 					NOT NULL,
  cod_4dig 								CHAR(1) 					NOT NULL,
  PRIMARY KEY(id_ciex_frecuente_servicio),
  UNIQUE INDEX idx_unique_id_servicio_id_ciex_4(id_servicio, id_ciex_4),
  UNIQUE INDEX idx_unique_cod_servicio_cod_3dig_cod_4dig(cod_servicio, cod_3dig, cod_4dig)
)
ENGINE=InnoDB;

/* ingresa los datos en la tabla de patologias frecuentes */
INSERT INTO ciex_frecuentes_servicios
	
	SELECT
			0,
			(SELECT id_servicio
				FROM servicios s
				WHERE s.cod_servicio = 
									(SELECT cod_nuevo
										FROM temp_servicios ts
										WHERE ts.cod_viejo = pc.Servicio)
			),
			(SELECT id_ciex_4
				FROM ciex_4 c4
				WHERE	c4.cod_3dig = LEFT(pc.CepsapCodigo,3)
				AND		c4.cod_4dig = RIGHT(pc.CepsapCodigo,1)
			),
			(SELECT cod_nuevo
				FROM temp_servicios ts
				WHERE ts.cod_viejo = pc.Servicio
			),
			LEFT(pc.CepsapCodigo,3),
			RIGHT(pc.CepsapCodigo,1)
										
										
		FROM	patologiascomunes pc;