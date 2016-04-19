DROP TABLE IF EXISTS ubigeo_hmi;


CREATE TABLE ubigeo_hmi (
	cod_pais 			CHAR(3) 				NOT NULL,
	cod_prov 			CHAR(2) 				NOT NULL,
	cod_dpto 			CHAR(3) 				NOT NULL,
	cod_loc 			CHAR(2) 				NOT NULL,
	descripcion			VARCHAR(255)			NOT NULL
)ENGINE=MyISAM;
  

/* carga los datos */
LOAD DATA LOCAL INFILE 'D:/sebas/proyectos/hospitales/shu_inicio/scripts/efectores/localidades/tablaubigeo.txt' 
	INTO TABLE ubigeo_hmi
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\r\n';
	
	
/* paises */
DELETE FROM paises;
INSERT  INTO `paises`(`id_pais`,`nom_pais`,`cod_pais`) VALUES (1,'ARGENTINA','200');

INSERT INTO paises
	SELECT	0, 
			descripcion, 
			cod_pais 
		FROM ubigeo_hmi
		WHERE cod_pais<>'200' 
		AND cod_prov='00' 
		ORDER BY descripcion;
		
/* provincias */
DELETE FROM provincias;
INSERT  INTO `provincias`(`id_prov`,`id_pais`,`nom_prov`,`cod_prov`) VALUES (1,1,'SANTA FE','82');

INSERT INTO provincias
	SELECT	0,
			1, 
			descripcion, 
			cod_prov 
			
		FROM ubigeo_hmi
		
		WHERE cod_prov<>'82' 
		AND cod_pais='200'
		AND cod_prov<>'00'
		AND cod_dpto='000'
			 
		ORDER BY descripcion;
		
			
