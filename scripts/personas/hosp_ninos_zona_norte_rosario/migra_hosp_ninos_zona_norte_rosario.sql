DROP TABLE IF EXISTS pacientes_hosp_ninos_zona_norte_rosario;

/* carga los pacientes del hospital de ninos zona norte rosario */
CREATE TABLE IF NOT EXISTS pacientes_hosp_ninos_zona_norte_rosario(
	codigo				INTEGER			NOT NULL,
	nomyape				VARCHAR(255)	NOT NULL,
	docum				INTEGER			NOT NULL,
	direc				VARCHAR(255)	NOT NULL,
	localidad			VARCHAR(255)	NOT NULL,
	barrio				VARCHAR(255)	NOT NULL,
	ref_				VARCHAR(255)	NOT NULL,
	secc				VARCHAR(255)	NOT NULL,
	fecnac				DATE			NOT NULL,
	madre				VARCHAR(255)	NOT NULL,
	mdocum				INTEGER			NOT NULL,
	mestudio			VARCHAR(255)	NOT NULL,
	mocupa				VARCHAR(255)	NOT NULL,
	padre				VARCHAR(255)	NOT NULL,
	pdocum				VARCHAR(255)	NOT NULL,
	pestudio			VARCHAR(255)	NOT NULL,
	pocupa				VARCHAR(255)	NOT NULL,
	obsoc				VARCHAR(255)	NOT NULL,
	sexo				VARCHAR(255)	NOT NULL,
	numero				VARCHAR(255)	NOT NULL,
	fecnacpac			VARCHAR(255)	NOT NULL,
	fecnacm				VARCHAR(255)	NOT NULL,
	fecnacp				VARCHAR(255)	NOT NULL,
	tipodocpac			TINYINT			NOT NULL,
	tipodocm			TINYINT			NOT NULL,
	tipodocp			TINYINT			NOT NULL,
	telefono			VARCHAR(255)	NOT NULL,
	marca_borrado		BOOLEAN			NOT NULL 	DEFAULT FALSE,
PRIMARY KEY (codigo)
)ENGINE=MyISAM;

/* carga los datos de los archivos de texto de datos generales de pacientes */
LOAD DATA LOCAL INFILE 'pacientes_hosp_ninos_zona_norte_rosario.txt'
	INTO TABLE pacientes_hosp_ninos_zona_norte_rosario
	FIELDS	TERMINATED BY ';'
			OPTIONALLY ENCLOSED BY '"'
	LINES	TERMINATED BY '\r\n'
	IGNORE 1 LINES;
	
/* elimina los pacientes con docum = 0 y docum = 1 */
DELETE FROM pacientes_hosp_ninos_zona_norte_rosario
	WHERE	docum = 0
	OR		docum = 1;
	