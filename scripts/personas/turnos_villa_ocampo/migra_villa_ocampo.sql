DROP TABLE IF EXISTS archivos_villa_ocampo;
DROP TABLE IF EXISTS barrios_villa_ocampo;

/* NOTA: Las bases fueron exportadas con el FOX para windows (File-> Export...) */
/* 	Hubo problemas con la tabla "archivos.dbf", aparecieron nombres de campos */
/*  repetidos, los cuales tuve que borrar con (View-> Table Designer) */
/* seleccionar code page 850 desde el fox cuando se abren los archivos */


/* crea la tabla con los datos de pacientes del hospital de reconquista */
CREATE TABLE archivos_villa_ocampo (
	arc_nro_hi		VARCHAR(255)	NOT NULL,
	arc_ficha_      VARCHAR(255)	NOT NULL,
	arc_nombre      VARCHAR(255)	NOT NULL,
	arc_sexo        VARCHAR(255)	NOT NULL,
	arc_fec_na      VARCHAR(255)	NULL,
	arc_edad        VARCHAR(255)	NOT NULL,
	arc_tipo_e      VARCHAR(255)	NOT NULL,
	arc_tipo_d      CHAR(3)			NOT NULL,
	arc_nro_do      VARCHAR(255)	NOT NULL,
	arc_tip_ma      CHAR(3)			NULL,
	arc_doc_ma      VARCHAR(255)	NOT NULL,
	arc_te          VARCHAR(255)	NOT NULL,
	arc_domi		VARCHAR(255)	NOT NULL,
	arc_barrio      VARCHAR(255)	NOT NULL,
	arc_ciudad      VARCHAR(255)	NOT NULL,
	arc_depto       VARCHAR(255)	NOT NULL,
	arc_provin      VARCHAR(255)	NOT NULL,
	arc_pais        VARCHAR(255)	NOT NULL,
	arc_asoc_a      VARCHAR(255)	NOT NULL,
	arc_condic      VARCHAR(255)	NOT NULL,
	arc_obra_s      VARCHAR(255)	NOT NULL,
	arc_niv_in      VARCHAR(255)	NOT NULL,
	arc_sit_la      VARCHAR(255)	NOT NULL,
	arc_ocup_h      VARCHAR(255)	NOT NULL,
	arc_retiro      VARCHAR(255)	NOT NULL,
	arc_alta        VARCHAR(255)	NOT NULL,
	arc_serv_i      VARCHAR(255)	NOT NULL,
	arc_fec_in      VARCHAR(255)	NOT NULL,
	arc_ult_al      VARCHAR(255)	NOT NULL,
	arc_entreg      VARCHAR(255)	NOT NULL,
	arc_fec_en      VARCHAR(255)	NOT NULL,
	arc_fec_de      VARCHAR(255)	NOT NULL,
	arc_recibe      VARCHAR(255)	NOT NULL,
	arc_grupo       VARCHAR(255)	NOT NULL,
	arc_factor      VARCHAR(255)	NOT NULL,
	arc_ant_pe      VARCHAR(255)	NOT NULL,
	arc_ant_he      VARCHAR(255)	NOT NULL,
	arc_ant_qu      VARCHAR(255)	NOT NULL,
	arc_ano_qu      VARCHAR(255)	NOT NULL,
	arc_partos      VARCHAR(255)	NOT NULL,
	arc_normal      VARCHAR(255)	NOT NULL,
	arc_cesare      VARCHAR(255)	NOT NULL,
	arc_gemela      VARCHAR(255)	NOT NULL,
	arc_aborto      VARCHAR(255)	NOT NULL,
	arc_gestas      VARCHAR(255)	NOT NULL,
	arc_viven       VARCHAR(255)	NOT NULL,
	arc_men_25      VARCHAR(255)	NOT NULL,
	arc_peso_n      VARCHAR(255)	NOT NULL,
	arc_nro_be      VARCHAR(255)	NOT NULL,
	marca_borrado	BOOLEAN			NOT NULL 		DEFAULT FALSE,
PRIMARY KEY (arc_nro_hi)
)ENGINE=MyISAM ;	
	

/* carga los datos de los archivos de texto de datos generales de pacientes */
LOAD DATA LOCAL INFILE 'archivos_villa_ocampo.txt' 
	INTO TABLE archivos_villa_ocampo
	FIELDS	TERMINATED BY '\t'
			OPTIONALLY ENCLOSED BY '"'
			ESCAPED BY '"'
	LINES	TERMINATED BY '\r\n';

/* elimina el nro de historia clinica 91234 */
/* DELETE FROM archivos_villa_ocampo WHERE arc_nro_hi='91234'; viene del script de reconquista */


/* modifica el tipo de documento al formato de personas */
UPDATE archivos_villa_ocampo
	SET arc_tipo_d =
		(CASE arc_tipo_d
			WHEN '0' THEN 'DNR'
			WHEN '1' THEN 'DNI'
			WHEN '2' THEN 'LC'
			WHEN '3' THEN 'LE'
			WHEN '4' THEN 'OTR'
			WHEN '5' THEN 'DNR'
			WHEN '6' THEN 'DNR'
			WHEN '7' THEN 'DNR'
			WHEN '8' THEN 'DNR'
			ELSE 'DNR'
		END);
		
UPDATE archivos_villa_ocampo
	SET arc_tip_ma = 
		(CASE arc_tip_ma
			WHEN '0' THEN NULL
			WHEN '1' THEN 'DNI'
			WHEN '2' THEN 'LC'
			WHEN '3' THEN 'LC'
			WHEN '4' THEN 'OTR'
			WHEN '5' THEN 'DNR'
			WHEN '6' THEN 'DNR'
			WHEN '7' THEN 'DNR'
			WHEN '8' THEN 'DNR'
			ELSE NULL
		END);
		
						
/* actualiza la fecha de nacimiento */
UPDATE archivos_villa_ocampo 
	SET arc_fec_na =	
			IF(	arc_fec_na=0,
				NULL,
				DATE_ADD('1800-12-28',INTERVAL arc_fec_na DAY)
			);
			
ALTER TABLE archivos_villa_ocampo
	MODIFY COLUMN arc_fec_na DATE NULL;
	



									
/* crea la tabla de barrios de villa ocampo */
CREATE TABLE barrios_villa_ocampo (
	Bar_codigo		VARCHAR(255)	NOT NULL,
	Bar_nombre		VARCHAR(255)	NOT NULL,
PRIMARY KEY (Bar_codigo)
)ENGINE=MyISAM ;

LOAD DATA LOCAL INFILE 'barrios_villa_ocampo.txt' 
	INTO TABLE barrios_villa_ocampo
	FIELDS	TERMINATED BY '\t'
			OPTIONALLY ENCLOSED BY '"'
	LINES	TERMINATED BY '\r\n';