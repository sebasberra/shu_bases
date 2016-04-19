/*==============================================================*/
/* Table: padron_electoral                                    */
/*==============================================================*/

DROP TABLE IF EXISTS padron_electoral;

CREATE TABLE padron_electoral
(
   nro_doc                      CHAR(8)             NOT NULL,
   sexo							CHAR(1)				NOT NULL,
   ape_nom                      VARCHAR(30)         NOT NULL,
   ocup_dir_tipodoc				VARCHAR(30)         NOT NULL,
   cod_dpto                     CHAR(3)             NOT NULL,
   nom_dpto                     VARCHAR(30)			NOT NULL,
   nom_loc                      VARCHAR(30)			NOT NULL
)
ENGINE=MyISAM;

/* carga los datos de los archivos de texto */
LOAD DATA LOCAL INFILE 'd:/sebas/proyectos/hospitales/shu_inicio/scripts/personas/padron_electoral/padron_electoral.txt' 
	INTO TABLE padron_electoral
		FIELDS	TERMINATED BY ','
			ENCLOSED BY '"'
		LINES TERMINATED BY '\r\n';