
/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS localidades;
DROP TABLE IF EXISTS departamentos;
DROP TABLE IF EXISTS provincias;
DROP TABLE IF EXISTS paises;



/* paises */
CREATE TABLE paises (
	id_pais 			INTEGER 	UNSIGNED	NOT NULL 	AUTO_INCREMENT,
	nom_pais 			VARCHAR(50) 			NOT NULL,
	cod_pais 			CHAR(3) 				NOT NULL,
	PRIMARY KEY(id_pais),
	INDEX idx_nom_pais(nom_pais)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


/* provincias */
CREATE TABLE provincias (
	id_prov				INTEGER 	UNSIGNED	NOT NULL	AUTO_INCREMENT,
	id_pais				INTEGER		UNSIGNED	NOT NULL,
	nom_prov			VARCHAR(50)				NOT NULL,
	cod_prov			CHAR(2)					NOT NULL,
	PRIMARY KEY(id_prov),
	INDEX provincias_fk_id_pais(id_pais),
	INDEX idx_nom_prov(nom_prov),
	FOREIGN KEY(id_pais)
		REFERENCES paises(id_pais)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
)ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;


/* departamentos */
CREATE TABLE departamentos (
	id_dpto 			INTEGER		UNSIGNED	NOT NULL	AUTO_INCREMENT,
	id_prov				INTEGER		UNSIGNED	NOT NULL,
	nom_dpto			VARCHAR(50)				NOT NULL,
	cod_dpto			CHAR(3)					NOT NULL,
	PRIMARY KEY(id_dpto),
	INDEX departamentos_fk_id_prov(id_prov),
	INDEX idx_nom_dpto(nom_dpto),
	FOREIGN KEY(id_prov)
		REFERENCES provincias(id_prov)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
)ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;


/* localidades */
CREATE TABLE localidades (
  id_localidad 		INTEGER 	UNSIGNED 	NOT NULL AUTO_INCREMENT,
  id_dpto 			INTEGER 	UNSIGNED 	NULL,
  nom_loc 			VARCHAR(50) 			NOT NULL,
  cod_loc 			CHAR(2) 				NOT NULL,
  cod_dpto 			CHAR(3) 				NOT NULL,
  cod_prov 			CHAR(2) 				NOT NULL,
  cod_pais 			CHAR(3) 				NOT NULL,
  cod_postal 		VARCHAR(4) 				NULL,
  PRIMARY KEY(id_localidad),
  INDEX localidades_fk_id_dpto(id_dpto),
  INDEX idx_nom_loc(nom_loc),
  FOREIGN KEY(id_dpto)
    REFERENCES departamentos(id_dpto)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  UNIQUE INDEX idx_unique_cod_loc_cod_dpto_cod_prov_cod_pais (cod_loc,cod_dpto,cod_prov,cod_pais)
)ENGINE=InnoDB AUTO_INCREMENT=815 DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;