/*==============================================================*/
/* Table: nomenclador_nacional                                  */
/*==============================================================*/

DROP TABLE IF EXISTS nomenclador_nacional;

CREATE TABLE nomenclador_nacional
(
   tipo                 CHAR(1)                 not null,
   codigo               CHAR(6)                 not null,
   descripcion			CHAR(50)               	not null,
   PRIMARY KEY (codigo)
)TYPE=MyISAM;

/* carga los datos de los archivos de texto */
LOAD DATA LOCAL INFILE 'd:/sebas/proyectos/hospitales/extras/anexoii/NomencladorNacional.txt' 
	INTO TABLE nomenclador_nacional
	FIELDS	TERMINATED BY ';'
			ENCLOSED BY '"'
			LINES TERMINATED BY '\r\n';