DROP TABLE IF EXISTS d_region;
DROP TABLE IF EXISTS d_subregion;
DROP TABLE IF EXISTS nodos;
DROP TABLE IF EXISTS subnodos;

CREATE TABLE d_region (
  numregion				TINYINT(4) 	NOT NULL DEFAULT '0',
  nomregion				CHAR(30) 	NOT NULL DEFAULT '',   
  PRIMARY KEY  (numregion)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table d_region */

INSERT  INTO d_region(numregion,nomregion) VALUES (1,'RECONQUISTA');
INSERT  INTO d_region(numregion,nomregion) VALUES (2,'RAFAELA');
INSERT  INTO d_region(numregion,nomregion) VALUES (3,'SANTA FE');
INSERT  INTO d_region(numregion,nomregion) VALUES (4,'ROSARIO');
INSERT  INTO d_region(numregion,nomregion) VALUES (5,'VENADO TUERTO');
INSERT  INTO d_region(numregion,nomregion) VALUES (0,'NO DEFINIDO');

/*Table structure for table d_subregion */

CREATE TABLE d_subregion (
  numregion 			TINYINT(4) 		NOT NULL DEFAULT '0',
  numsubregion 			SMALLINT(6) 	NOT NULL DEFAULT '0',
  descsubregion 		VARCHAR(100) 	NOT NULL DEFAULT '', 
  PRIMARY KEY  (numregion,numsubregion)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table d_subregion */

INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (4,2,'ROSARIO SUDOESTE');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (4,3,'ROSARIO SUR');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (3,2,'SANTO TOME');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (3,3,'LA COSTA');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (3,8,'SAN JUSTO');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (3,7,'ESPERANZA');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (3,6,'SAN CARLOS CENTRO');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (3,5,'HELVECIA');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (4,4,'ARTEAGA');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (3,4,'GALVEZ');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (5,1,'NO DEFINIDO (NODO VENADO TUERTO)');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (4,1,'NO DEFINIDO (NODO ROSARIO)');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (3,1,'NO DEFINIDO (NODO SANTA FE)');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (2,1,'NO DEFINIDO (NODO RAFAELA)');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (1,1,'NO DEFINIDO (NODO RECONQUISTA)');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (3,9,'SAN JAVIER');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (3,10,'NORTE');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (3,11,'CENTRO');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (3,12,'SUR');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (3,13,'PROTOMEDICO');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (4,5,'ROSARIO NOROESTE');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (4,6,'ROSARIO OESTE');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (4,7,'SAN MARTÍN');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (4,8,'CASILDA');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (4,9,'CHABÁS');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (4,10,'SAN JERÓNIMO');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (4,11,'SAN LORENZO NORTE');
INSERT  INTO d_subregion(numregion,numsubregion,descsubregion) VALUES (4,12,'IRIONDO OESTE');

/* nodos */
CREATE TABLE nodos (
  id_nodo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nom_nodo VARCHAR(255) NOT NULL,
  numregion TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY(id_nodo),
  UNIQUE INDEX idx_unique_numregion(numregion)
)
ENGINE=InnoDB;

/* datos nodos */
INSERT INTO nodos

	SELECT
		0,
		dr.nomregion,
		dr.numregion
	FROM
		d_region dr;
		
		
/* subnodos */
CREATE TABLE subnodos (
  id_subnodo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  id_nodo INTEGER UNSIGNED NOT NULL,
  nom_subnodo VARCHAR(255) NOT NULL,
  numregion TINYINT UNSIGNED NOT NULL,
  numsubregion SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY(id_subnodo),
  UNIQUE INDEX idx_unique_numregion_numsubregion(numregion, numsubregion)
)
ENGINE=InnoDB;

/* datos subnodos */
INSERT INTO subnodos
	
	SELECT
		0,
		(SELECT 
			id_nodo
		FROM
			nodos n
		WHERE
			n.numregion = dsr.numregion
		),
		dsr.descsubregion,
		dsr.numregion,
		dsr.numsubregion
	FROM
		d_subregion dsr;		
		
ALTER TABLE efectores
	ADD COLUMN id_nodo				INTEGER		UNSIGNED	NULL AFTER id_efector;
	
ALTER TABLE efectores
	ADD COLUMN id_subnodo			INTEGER		UNSIGNED	NULL AFTER id_nodo;
	

	
	
/*

NOTA: esto se ejecuta despues de correr actualizacion_efectores.sql

ALTER TABLE efectores
	MODIFY COLUMN id_nodo				INTEGER		UNSIGNED	NOT NULL;
	
ALTER TABLE efectores
	MODIFY COLUMN id_subnodo			INTEGER		UNSIGNED	NOT NULL;
				
ALTER TABLE efectores
	ADD	FOREIGN KEY fk_id_nodo(id_nodo)
	    REFERENCES nodos(id_nodo)
	      ON DELETE NO ACTION
	      ON UPDATE NO ACTION;
	      
ALTER TABLE efectores
	ADD	FOREIGN KEY fk_id_subnodo(id_subnodo)
	    REFERENCES subnodos(id_subnodo)
	      ON DELETE NO ACTION
	      ON UPDATE NO ACTION;*/
		
		
		