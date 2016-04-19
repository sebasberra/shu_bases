DROP TABLE IF EXISTS paises;
DROP TABLE IF EXISTS provincias;
DROP TABLE IF EXISTS departamentos;
DROP TABLE IF EXISTS localidades;


CREATE TABLE paises (
	id_pais 			INTEGER 	UNSIGNED	NOT NULL 	AUTO_INCREMENT,
	nom_pais 			VARCHAR(50) 			NOT NULL,
	cod_pais 			CHAR(3) 				NOT NULL,
	PRIMARY KEY(id_pais)
)ENGINE=InnoDB;


CREATE TABLE provincias (
	id_prov				INTEGER 	UNSIGNED	NOT NULL	AUTO_INCREMENT,
	id_pais				INTEGER		UNSIGNED	NOT NULL,
	nom_prov			VARCHAR(50)				NOT NULL,
	cod_prov			CHAR(2)					NOT NULL,
	PRIMARY KEY(id_prov),
	INDEX provincias_FKIndex1(id_pais),
	FOREIGN KEY(id_pais)
		REFERENCES paises(id_pais)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
)ENGINE=InnoDB;


CREATE TABLE departamentos (
	id_dpto 			INTEGER		UNSIGNED	NOT NULL	AUTO_INCREMENT,
	id_prov				INTEGER		UNSIGNED	NOT NULL,
	nom_dpto			VARCHAR(50)				NOT NULL,
	cod_dpto			CHAR(3)					NOT NULL,
	PRIMARY KEY(id_dpto),
	INDEX departamentos_FKIndex1(id_prov),
	FOREIGN KEY(id_prov)
		REFERENCES provincias(id_prov)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
)ENGINE=InnoDB;


CREATE TABLE localidades (
  id_localidad 		INTEGER 	UNSIGNED 	NOT NULL AUTO_INCREMENT,
  id_dpto 			INTEGER 	UNSIGNED 	NOT NULL,
  nom_loc 			VARCHAR(50) 			NOT NULL,
  cod_loc 			CHAR(2) 				NOT NULL,
  cod_dpto 			CHAR(3) 				NOT NULL,
  cod_prov 			CHAR(2) 				NOT NULL,
  cod_pais 			CHAR(3) 				NOT NULL,
  cod_postal 		VARCHAR(4) 				NULL,
  PRIMARY KEY(id_localidad),
  INDEX localidades_FKIndex1(id_dpto),
  FOREIGN KEY(id_dpto)
    REFERENCES departamentos(id_dpto)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)ENGINE=MyISAM;

/* paises */
INSERT INTO paises VALUES (0,'ARGENTINA','200');

/* provincias */
INSERT INTO provincias VALUES (0,1,'SANTA FE','82');

/* departamentos */
INSERT INTO departamentos
	SELECT 0,1,nomdepto,coddepto FROM d_depto;
	
/* localidades */
INSERT INTO localidades
	SELECT 0,
			(SELECT id_dpto FROM departamentos d WHERE d.cod_dpto=l.coddepto),
			nomloc,
			codloc,
			coddepto,
			codprov,
			(SELECT cod_pais FROM provincias pr, paises pa
				WHERE	l.codprov	= pr.cod_prov
				AND 	pr.id_pais 	= pa.id_pais),
			codposloc
		FROM d_localidad l;
		
/* indice para los nombres de localidades */
CREATE INDEX idx_nom_loc ON localidades (nom_loc);
		 