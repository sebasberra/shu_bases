/*==============================================================*/
/* Table: nomenclador_autogestion                               */
/*==============================================================*/

DROP TABLE IF EXISTS nomenclador_autogestion;

CREATE TABLE nomenclador_autogestion
(
   codigo               CHAR(6)                 not null,
   desc_corta			VARCHAR(50)            	not null,
   gasto				DOUBLE					not null,
   desc_larga			VARCHAR(255)			not null,
   PRIMARY KEY (codigo)
)TYPE=MyISAM;

/* carga los datos de los archivos de texto */
LOAD DATA LOCAL INFILE 'd:/sebas/proyectos/hospitales/extras/anexoii/NomencladordeAutogestion.txt' 
	INTO TABLE nomenclador_autogestion
	FIELDS	TERMINATED BY ';'
			ENCLOSED BY '"'
			LINES TERMINATED BY '\r\n';