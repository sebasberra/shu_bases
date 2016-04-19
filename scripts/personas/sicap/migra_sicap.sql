DROP TABLE IF EXISTS historiasClinicas_sicap;
DROP TABLE IF EXISTS paciente_sicap;

CREATE TABLE historiasClinicas_sicap
(
	NumeroPaciente 			INT(11) 		NOT NULL DEFAULT 0,
	NumeroGrupoFamiliar 	INT(11) 		NOT NULL DEFAULT 0,
	CodEstablecimiento 		VARCHAR(8) 		NOT NULL DEFAULT '',
	HistoriaFamiliar 		VARCHAR(11) 	NOT NULL DEFAULT '',
	HistoriaPersonal 		VARCHAR(11) 	NOT NULL DEFAULT '',
	PRIMARY KEY (NumeroPaciente, NumeroGrupoFamiliar, CodEstablecimiento),
	KEY (CodEstablecimiento),
	KEY (NumeroGrupoFamiliar),
	KEY (NumeroPaciente)
) TYPE=MyISAM;

CREATE TABLE paciente_sicap
(
	numeropaciente 			INT(11) 		NOT NULL 	AUTO_INCREMENT,
	codocupacion 			CHAR(3) 		NOT NULL 	DEFAULT '',
	codestciv 				CHAR(1) 		NOT NULL 	DEFAULT '',
	descripestciv 			VARCHAR(25) 	NOT NULL 	DEFAULT '',
	codparentesco 			CHAR(2) 		NOT NULL 	DEFAULT '',
	codniveleduc 			CHAR(2) 		NOT NULL 	DEFAULT '',
	codestadoreg 			CHAR(2) 		NOT NULL 	DEFAULT '',
	codcondicion 			CHAR(2) 		NOT NULL 	DEFAULT '',
	codpais 				CHAR(3) 		NOT NULL 	DEFAULT '',
	codsexo 				CHAR(1) 		NULL 		DEFAULT NULL,
	numerogrupofamiliar 	INT(11) 		NOT NULL,	
	codequipoatencion 		INT(11) 		NOT NULL,	
	codtipdocumento 		CHAR(3) 		NULL	 	DEFAULT NULL,
	clasedocumento 			CHAR(1) 		NOT NULL 	DEFAULT 'P',
	codequipomedico 		INT(11) 		NOT NULL,	
	nrodocumento 			INTEGER		 	NULL 		DEFAULT NULL,
	nombre 					VARCHAR(25) 	NOT NULL 	DEFAULT '',
	apellido 				VARCHAR(25) 	NOT NULL 	DEFAULT '',
	clavelocalidad 			VARCHAR(8) 		NOT NULL 	DEFAULT '',
	fechaingreso 			DATE 			NOT NULL,	
	calle 					VARCHAR(40) 	NULL 		DEFAULT NULL,
	numero 					VARCHAR(5) 		NULL 		DEFAULT NULL,
	piso 					VARCHAR(5) 		NULL 		DEFAULT NULL,
	depto 					CHAR(3) 		NULL 		DEFAULT NULL,
	manzana 				VARCHAR(17) 	NULL 		DEFAULT NULL,
	entrecalle 				VARCHAR(27) 	NOT NULL 	DEFAULT '',
	ycalle 					VARCHAR(17) 	NOT NULL 	DEFAULT '',
	municipio 				VARCHAR(13) 	NOT NULL 	DEFAULT '',
	codpostal 				VARCHAR(4) 		NOT NULL 	DEFAULT '',
	telefono 				VARCHAR(15) 	NOT NULL 	DEFAULT '',
	apellidocasada 			VARCHAR(25) 	NOT NULL 	DEFAULT '',
	fechanacimiento 		DATE 			NULL		DEFAULT NULL,	
	provincianacimiento 	VARCHAR(11) 	NOT NULL 	DEFAULT '',
	localidadnacimiento 	VARCHAR(11) 	NOT NULL 	DEFAULT '',
	paisnacimiento 			VARCHAR(20) 	NOT NULL 	DEFAULT '',
	idporiginaria 			INT(11) 		NOT NULL 	DEFAULT 0,
	idlengua 				INT(11) 		NOT NULL 	DEFAULT 0,
	fechafallecimiento 		DATE 			NULL 		DEFAULT NULL,
	codprovincia 			CHAR(2) 		NOT NULL 	DEFAULT '',
	codparajebarrio 		CHAR(3) 		NOT NULL 	DEFAULT '',
	seguro 					CHAR(1) 		NOT NULL 	DEFAULT '',
	obra 					CHAR(1) 		NOT NULL 	DEFAULT '',
	observacion 			VARCHAR(255)	NOT NULL 	DEFAULT '',
	fuente 					VARCHAR(20) 	NOT NULL 	DEFAULT '',
	fechaata 				DATETIME 		NOT NULL 	DEFAULT '0000-00-00 00:00:00',
	usuarioingreso 			VARCHAR(12) 	,        	
	fechamodificacion 		DATETIME 		NOT NULL 	DEFAULT '0000-00-00 00:00:00',
	usuariomodificacion 	VARCHAR(12) 	NOT NULL 	DEFAULT '',
	marca_borrado			BOOLEAN 		NOT NULL 	DEFAULT FALSE,
	PRIMARY KEY (NumeroPaciente),
	KEY (CodEquipoAtencion),
	KEY (CodEstCiv),
	KEY (CodEquipoMedico),
	KEY (idlengua),
	KEY (ClaveLocalidad),
	KEY (CodNivelEduc),
	KEY (CodOcupacion),
	KEY (CodParentesco),
	KEY (idporiginaria),
	KEY (CodSexo),
	KEY (CodTipDocumento),
	INDEX idx_NumeroGrupoFamiliar (NumeroGrupoFamiliar ASC),
	INDEX Nombre (Nombre ASC),
	INDEX Apellido (Apellido ASC),
	INDEX NroDocumento (NroDocumento ASC)
) TYPE=MyISAM;

/* carga los datos de los archivos de texto */
LOAD DATA LOCAL INFILE './dumps/historiasClinicas.csv' 
	INTO TABLE historiasClinicas_sicap
	CHARACTER SET utf8
	FIELDS	TERMINATED BY ';'
			ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n';

/* carga los datos de los archivos de texto */
LOAD DATA LOCAL INFILE './dumps/paciente.csv' 
	INTO TABLE paciente_sicap
	CHARACTER SET utf8
	FIELDS	TERMINATED BY ';'
			ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n';
	
	
/* pone NULL a fechas de nacimiento no validas */
UPDATE
	paciente_sicap
SET
	fechanacimiento = NULL
WHERE
	valida_fecha_nac (fechanacimiento) = FALSE ;
	
				
/* convierte los tipos de documentos a los del HMI 1 */
UPDATE
	paciente_sicap
SET
	codtipdocumento =
		IF ( LEFT(nrodocumento,1)='F', 'DNI',
			IF (LEFT(nrodocumento,1)='M', 'DNI',
				(CASE codtipdocumento
					WHEN '0' THEN 'DNR'
					WHEN '1' THEN 'DNI'
					WHEN '2' THEN 'LC'
					WHEN '3' THEN 'LE'
					WHEN '4' THEN 'CI'
					WHEN '5' THEN 'OTR'
					WHEN '6' THEN 'OTR'
					WHEN '7' THEN 'OTR'
					WHEN '8' THEN 'DNR'
					WHEN '9' THEN 'DNR'
					ELSE 'DNR'
				END)
				)
			);