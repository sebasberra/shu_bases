DROP TABLE IF EXISTS os_hmi;
DROP TABLE IF EXISTS os_gob_cordoba;
DROP TABLE IF EXISTS coberturas_sociales;
DROP TABLE IF EXISTS os_cruce_hmi_gob_cordoba;
DROP TABLE IF EXISTS os_hmi_no_en_gob_cordoba;
DROP TABLE IF EXISTS os_superintendencia;
DROP TABLE IF EXISTS os_cruce_superintendencia_gob_cordoba;
DROP TABLE IF EXISTS os_superintendencia_no_en_gob_cordoba;



CREATE TABLE os_hmi (
	rnos						CHAR(5)				NOT NULL,
	nom_cobertura_social		VARCHAR(255) 		NOT NULL,
	INDEX idx_rnos (rnos),
	INDEX idx_nom_obra_social(nom_cobertura_social)
	
)ENGINE=InnoDB;

/* carga los datos */
LOAD DATA LOCAL INFILE 'osabrev.txt' 
	INTO TABLE os_hmi
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\r\n';

UPDATE os_hmi SET rnos = LPAD(TRIM(rnos),5,'0');






CREATE TABLE os_gob_cordoba (
	rnos						CHAR(6) 			NOT NULL,
	nom_cobertura_social		VARCHAR(255) 		NOT NULL,
	nom_abreviado				VARCHAR(50)			NULL,
	INDEX (rnos),
	INDEX idx_nom_obra_social(nom_cobertura_social)
)ENGINE=InnoDB;

/* carga los datos */
LOAD DATA LOCAL INFILE 'sal_obrassociales.txt' 
	INTO TABLE os_gob_cordoba
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n';
	
UPDATE os_gob_cordoba SET rnos = LPAD(TRIM(rnos),6,'0');
UPDATE os_gob_cordoba SET nom_abreviado = NULL WHERE TRIM(nom_abreviado) = '';






CREATE TABLE os_cruce_hmi_gob_cordoba (
	rnos_hmi					CHAR(5)				NULL,
	rnos_gob_cordoba			CHAR(6) 			NOT NULL,
	nom_os_hmi					VARCHAR(50) 		NULL,
	nom_os_gob_cordoba			VARCHAR(50) 		NOT NULL
)ENGINE=InnoDB;

INSERT INTO os_cruce_hmi_gob_cordoba
	SELECT 
		osh.rnos,
		osc.rnos,
		LEFT(osh.nom_cobertura_social,50),
		LEFT(osc.nom_cobertura_social,50)
	FROM
		os_gob_cordoba osc
		LEFT JOIN
		os_hmi osh
		ON
			osh.rnos=LEFT(osc.rnos,5);

			
			
			
			
			
CREATE TABLE os_hmi_no_en_gob_cordoba (
	rnos_hmi					CHAR(5)				NOT NULL,
	nom_os_hmi					VARCHAR(255) 		NOT NULL
)ENGINE=InnoDB;	

INSERT INTO os_hmi_no_en_gob_cordoba
	SELECT
		osh.rnos,
		osh.nom_cobertura_social 
	FROM os_hmi osh
	WHERE osh.rnos NOT IN (SELECT LEFT(osc.rnos,5) FROM os_gob_cordoba osc);


	
	
	
CREATE TABLE os_superintendencia (
	rnos						CHAR(6) 			NOT NULL,
	denominacion		VARCHAR(255) 		NOT NULL,
	sigla				VARCHAR(50)			NULL,
	domicilio			VARCHAR(255)		NOT NULL,
	codigo_postal		CHAR(4)				NOT NULL,
	provincia			VARCHAR(50)			NOT NULL,
	telefono			VARCHAR(100)		NULL,
	email1_web			VARCHAR(255)		NULL,
	email2_web			VARCHAR(255)		NULL,
	email3_web			VARCHAR(255)		NULL,
	email4_web			VARCHAR(255)		NULL,
	PRIMARY KEY (rnos),
	INDEX idx_nom_obra_social(denominacion)
)ENGINE=InnoDB;

/* carga los datos */
LOAD DATA LOCAL INFILE 'listadoSSSalud_csv.txt' 
	INTO TABLE os_superintendencia
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\r\n';
	
UPDATE os_superintendencia 
	SET rnos = LPAD(TRIM(rnos),6,'0'),
		denominacion = TRIM(denominacion),
		sigla = TRIM(sigla),
		domicilio = TRIM(domicilio),
		provincia = TRIM(provincia),
		telefono = TRIM(telefono),
		email1_web = TRIM(email1_web),
		email2_web = TRIM(email2_web),
		email3_web = TRIM(email3_web),
		email4_web = TRIM(email4_web);
		


CREATE TABLE os_cruce_superintendencia_gob_cordoba (
	rnos_superintendencia		CHAR(6)				NULL,
	rnos_gob_cordoba			CHAR(6) 			NOT NULL,
	nom_os_superintendencia		VARCHAR(50) 		NULL,
	nom_os_gob_cordoba			VARCHAR(50) 		NOT NULL
)ENGINE=InnoDB;

INSERT INTO os_cruce_superintendencia_gob_cordoba
	SELECT 
		oss.rnos,
		osc.rnos,
		LEFT(oss.denominacion,50),
		LEFT(osc.nom_cobertura_social,50)
	FROM
		os_gob_cordoba osc
		LEFT JOIN
		os_superintendencia oss
		ON
			oss.rnos=osc.rnos;
			

CREATE TABLE os_superintendencia_no_en_gob_cordoba (
	rnos_superintendencia				CHAR(6)				NOT NULL,
	nom_os_superintendencia				VARCHAR(255) 		NOT NULL,
	nom_abreviado_superintendencia		VARCHAR(50)			NULL
)ENGINE=InnoDB;	

INSERT INTO os_superintendencia_no_en_gob_cordoba
	SELECT
		oss.rnos,
		oss.denominacion,
		oss.sigla 
	FROM os_superintendencia oss
	WHERE oss.rnos NOT IN (SELECT osc.rnos FROM os_gob_cordoba osc);
	
	
	
	
	
/* ------------------- */
/*   Tabla principal */
/* ------------------- */
/* coberturas_sociales */
/* ------------------- */
			
CREATE TABLE coberturas_sociales (
	id_cobertura_social 		SMALLINT 		UNSIGNED 	NOT NULL AUTO_INCREMENT,
	id_prov						INTEGER  		UNSIGNED	NOT NULL,	
	rnos 						CHAR(6) 					NOT NULL,
	nom_cobertura_social 		VARCHAR(255) 				NOT NULL,
	sigla						VARCHAR(50)					NULL,
	domicilio					VARCHAR(255)				NULL,
	codigo_postal				CHAR(4)						NULL,
	telefono					VARCHAR(100)				NULL,
	email_web					VARCHAR(255)				NULL,
	tipo_cobertura 				CHAR(1) 					NOT NULL COMMENT '1 = Obra Social del Sistema Nacional del Seguro de Salud; 2 = Otras obras sociales; 3 = Plan de salud; 4 = Prepaga; 9 = Se ignora',
	PRIMARY KEY(id_cobertura_social),
	CONSTRAINT fk_id_prov FOREIGN KEY idx_id_prov (id_prov)
		REFERENCES provincias(id_prov)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	INDEX idx_nom_obra_social(nom_cobertura_social),
	UNIQUE INDEX idx_unique_rnos(rnos)
)ENGINE=InnoDB;


/* ----------------------------------------------- */
/* carga las obras sociales de la superintendencia */
/* ----------------------------------------------- */
INSERT INTO coberturas_sociales
	SELECT
		0,
		IFNULL(
			(SELECT 
				p.id_prov
			FROM
				provincias p
			WHERE
				nom_prov LIKE CONCAT('%',oss.provincia,'%')
			)
			,25
		),
		oss.rnos,
		oss.denominacion,	
		oss.sigla,
		oss.domicilio,
		oss.codigo_postal,
		oss.telefono,	
		CONCAT(
				IF( TRIM(oss.email1_web = ''),
					NULL,
					CONCAT(oss.email1_web,'; ')
				),
				oss.email2_web
			),
		1		 
	FROM
		os_superintendencia oss
		
		
ON DUPLICATE KEY UPDATE

	id_prov = IFNULL(
				(SELECT 
					p.id_prov
				FROM
					provincias p
				WHERE
					nom_prov LIKE CONCAT('%',oss.provincia,'%')
				),
				25
				),
	rnos =	oss.rnos,
	nom_cobertura_social = oss.denominacion,	
	sigla = oss.sigla,
	domicilio = oss.domicilio,
	codigo_postal = oss.codigo_postal,
	telefono = oss.telefono,	
	email_web = CONCAT(
					IF( TRIM(oss.email1_web = ''),
					NULL,
					CONCAT(oss.email1_web,'; ')
					),
					oss.email2_web
				),
	tipo_cobertura = 1;

	
/* ------------------------------------------------------- */
/* carga los datos de la base de obras sociales de cordoba */
/* ------------------------------------------------------- */
INSERT IGNORE INTO coberturas_sociales 
	SELECT
		0,
		25,
		TRIM(osc.rnos),            
        TRIM(osc.nom_cobertura_social),
        TRIM(osc.nom_abreviado),
		NULL,
		NULL,
		NULL,	
		NULL,
		2		 
	FROM
		os_gob_cordoba osc
    	
    ORDER BY osc.rnos;

    	
/* Actualiza los codigos de rnos del IAPOS y de PROFE para compatibilidad con el padron */

/* IAPOS */
UPDATE coberturas_sociales 
	SET 
		id_prov = 1,
		rnos='004000',
	 	tipo_cobertura = 3 
	WHERE 
		rnos='913001';

/* PROFE */
UPDATE  coberturas_sociales 
	SET 
		id_prov = 1,
		rnos='010101',
	 	tipo_cobertura = 3
	WHERE 
		rnos='997001';


/* Agrega el plan nacer a las obras sociales */
INSERT INTO coberturas_sociales
	VALUES 
		(0,
		1,
		'020202',
		'PLAN NACER',
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		3);
		
/* Actualiza las cadenas vacias por nulos */
UPDATE coberturas_sociales 
	SET 
		sigla = (IF (TRIM(sigla)='',NULL,TRIM(sigla)) ),
		domicilio = (IF (TRIM(domicilio)='',NULL,TRIM(domicilio)) ),
		telefono = (IF (TRIM(telefono)='',NULL,TRIM(telefono)) );
		
		
/* !!!!!!!!!!! faltaria agregar !!!!!!!!!!!! */
/* 988888 Otras no incluidas en tabla */
		