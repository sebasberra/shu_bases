DROP TABLE IF EXISTS afiliados_nacionales;
DROP TABLE IF EXISTS afiliados_iapos;
DROP TABLE IF EXISTS afiliados_profe;
DROP TABLE IF EXISTS afiliados;
DROP TABLE IF EXISTS condiciones_os;
DROP TABLE IF EXISTS info_actualizaciones;
DROP TABLE IF EXISTS coberturas_sociales;
DROP TABLE IF EXISTS sexo;
DROP TABLE IF EXISTS tipos_documentos;
DROP TABLE IF EXISTS usuarios_web;


/* -------------------------------------------- */
/* Funcion para separar el apellido del nombre	*/
/* !!! chequear si hay cambios !!! 				*/
/* fecha: 04/02/2010 							*/
/* -------------------------------------------- */

DELIMITER ;
	
DROP FUNCTION IF EXISTS str_separa_ape;

DELIMITER $$

CREATE
    DEFINER = CURRENT_USER 
    FUNCTION str_separa_ape (ape_nom VARCHAR(255), tipo BOOLEAN)
    RETURNS VARCHAR(255)
    DETERMINISTIC
	COMMENT 'Devuelve el apellido de un STRING tipo apellido y nombre'

BEGIN
	DECLARE ape VARCHAR(255) DEFAULT '';
	DECLARE nom VARCHAR(255) DEFAULT '';
	DECLARE aux_ape_nom VARCHAR(255);
	DECLARE indice SMALLINT DEFAULT 1;
	
	/* check NULL */
	IF ISNULL(ape_nom) THEN 
		RETURN NULL; 
	END IF;
	
	/* hace un trim y limpia las comas */
	SET ape_nom = TRIM(REPLACE(ape_nom,","," "));
	
	/* hace un upper case */
	SET aux_ape_nom = UPPER(ape_nom);
	
	/* separa con el primer espacio */
	SET ape = SUBSTRING_INDEX(aux_ape_nom," ",1);
	
	/* si queda un apellido de menos de 3 digitos no puede ser */
	IF LENGTH(ape)<3 THEN
		SET indice=2;
	END IF;
	
	/* un solo espacio en blanco */
	IF	ape = "VON" 	OR
		ape = "SANTA"	OR
		ape = "DAL" 	OR
		ape = "DEL" 	OR
		ape = "VAN" 	OR
		ape = "SAN" 	OR
		ape = "MAC" 	OR
		ape = "DOS" 	OR
		ape = "DAS" 
		THEN
		SET indice=2;
	END IF;
	
	/* separa nuevamente con el 2do espacio */
	SET ape = SUBSTRING_INDEX(aux_ape_nom," ",2);
		
	/* dos espacios en blaco */
	IF	ape = "DE LA" 		OR 
		ape = "VON DER" 	OR
		ape = "DE LOS" 		OR
		ape = "PONCE DE"
		THEN
		SET indice=3;
	END IF;
	
	/* separa nuevamente con el valor que quedo en la variable indice*/
	SET ape = SUBSTRING_INDEX(ape_nom," ",indice);
	SET indice = LENGTH(ape)+2;
	SET nom = SUBSTRING(ape_nom,indice);
	
	/* devuelve el apellido o el nombre segun corresponda */
	IF tipo THEN
		RETURN TRIM(ape);
	ELSE
		RETURN TRIM(nom);
	END IF;
	
END$$

DELIMITER ;

/* ----------------------------------------------- */
/* fin funcion para separar el apellido del nombre */
/* ----------------------------------------------- */


/* versiones */
CREATE TABLE IF NOT EXISTS versiones (
	base	VARCHAR(255) NOT NULL,	
	version VARCHAR(255) NOT NULL,
	fecha 	DATETIME NOT NULL,
	PRIMARY KEY (base)
);
REPLACE INTO versiones VALUES ('padron2','v 0.14a',NOW());

/* provincias superintendencia */
DROP TABLE IF EXISTS provincias_superintendencia;

CREATE TABLE provincias_superintendencia (
  codprov CHAR(2)		NOT NULL,
  nomprov CHAR(20) 		NOT NULL,
  id_prov INTEGER		NOT NULL,
  PRIMARY KEY (codprov)
) ENGINE=MyISAM;

INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('01','CAPITAL FEDERAL',3);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('02','BUENOS AIRES',2);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('03','CATAMARCA',4);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('04','CORDOBA',7);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('05','CORRIENTES',8);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('06','ENTRE RIOS',9);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('07','JUJUY',11);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('08','LA RIOJA',13);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('09','MENDOZA',14);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('10','SALTA',18);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('11','SAN JUAN',19);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('12','SAN LUIS',20);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('13','SANTA FE',1);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('14','SANTIAGO DEL ESTERO',22);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('15','TUCUMAN',24);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('16','CHACO',5);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('17','CHUBUT',6);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('18','FORMOSA',10);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('19','LA PAMPA',12);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('20','MISIONES',15);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('21','NEUQUEN',16);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('22','RIO NEGRO',17);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('23','SANTA CRUZ',21);
INSERT  INTO provincias_superintendencia(codprov,nomprov,id_prov) VALUES ('24','TIERRA DEL FUEGO',23);

/* afiliados_nacionales */
CREATE TABLE afiliados_nacionales (
	id_afiliado 		INTEGER(11) 					NOT NULL 	AUTO_INCREMENT,
	id_prov 			TINYINT 		UNSIGNED		NOT NULL,
	id_condicion 		TINYINT 		UNSIGNED 		NOT NULL,
	id_cobertura_social	SMALLINT 		UNSIGNED 		NOT NULL,
	id_tipo_doc 		TINYINT 		UNSIGNED 		NOT NULL,
	sexo	 			ENUM			('M','F','D') 	NOT NULL,
	nro_doc 			INTEGER 		UNSIGNED 		NOT NULL,
	apellido 			VARCHAR(255) 					NOT NULL,
	nombre 				VARCHAR(255) 					NOT NULL,
	fecha_nac 			DATE 							NOT NULL,
	codigo_postal 		VARCHAR(8) 						NOT NULL,
	periodo_aporte 		CHAR(6)							NOT NULL,
	cuil_titular 		BIGINT 			UNSIGNED 		NULL,
	cuit_empresa 		BIGINT 			UNSIGNED 		NULL,
	PRIMARY KEY(id_afiliado),
	INDEX idx_apellido(apellido),
	INDEX idx_nombre(nombre),
	INDEX idx_fecha_nac (fecha_nac),
	INDEX idx_id_cobertura_social(id_cobertura_social),
	INDEX idx_id_prov(id_prov),
	INDEX idx_nro_doc(nro_doc)
)ENGINE=MyISAM;

/* afiliados_iapos */
CREATE TABLE afiliados_iapos (
	id_afiliado 		INTEGER(11) 					NOT NULL 	AUTO_INCREMENT,
	id_prov 			TINYINT 		UNSIGNED		NOT NULL,
	id_condicion 		TINYINT 		UNSIGNED 		NOT NULL,
	id_cobertura_social	SMALLINT 		UNSIGNED 		NOT NULL,
	id_tipo_doc 		TINYINT 		UNSIGNED 		NOT NULL,
	sexo	 			ENUM			('M','F','D') 	NOT NULL,
	nro_doc 			INTEGER 		UNSIGNED 		NOT NULL,
	apellido 			VARCHAR(255) 					NOT NULL,
	nombre 				VARCHAR(255) 					NOT NULL,
	fecha_nac 			DATE 							NOT NULL,
	codigo_postal 		VARCHAR(8) 						NOT NULL,
	periodo_aporte 		CHAR(6)							NOT NULL,
	cuil_titular 		BIGINT 			UNSIGNED 		NULL,
	cuit_empresa 		BIGINT 			UNSIGNED 		NULL,
	PRIMARY KEY(id_afiliado),
	INDEX idx_apellido(apellido),
	INDEX idx_nombre(nombre),
	INDEX idx_fecha_nac (fecha_nac),
	INDEX idx_id_cobertura_social(id_cobertura_social),
	INDEX idx_id_prov(id_prov),
	INDEX idx_nro_doc(nro_doc)
)ENGINE=MyISAM;

/* afiliados_profe */
CREATE TABLE afiliados_profe (
	id_afiliado 		INTEGER(11) 					NOT NULL 	AUTO_INCREMENT,
	id_prov 			TINYINT 		UNSIGNED		NOT NULL,
	id_condicion 		TINYINT 		UNSIGNED 		NOT NULL,
	id_cobertura_social	SMALLINT 		UNSIGNED 		NOT NULL,
	id_tipo_doc 		TINYINT 		UNSIGNED 		NOT NULL,
	sexo	 			ENUM			('M','F','D') 	NOT NULL,
	nro_doc 			INTEGER 		UNSIGNED 		NOT NULL,
	apellido 			VARCHAR(255) 					NOT NULL,
	nombre 				VARCHAR(255) 					NOT NULL,
	fecha_nac 			DATE 							NOT NULL,
	codigo_postal 		VARCHAR(8) 						NOT NULL,
	periodo_aporte 		CHAR(6)							NOT NULL,
	cuil_titular 		BIGINT 			UNSIGNED 		NULL,
	cuit_empresa 		BIGINT 			UNSIGNED 		NULL,
	PRIMARY KEY(id_afiliado),
	INDEX idx_apellido(apellido),
	INDEX idx_nombre(nombre),
	INDEX idx_fecha_nac (fecha_nac),
	INDEX idx_id_cobertura_social(id_cobertura_social),
	INDEX idx_id_prov(id_prov),
	INDEX idx_nro_doc(nro_doc)
)ENGINE=MyISAM;

/* afiliados_nacionales */
CREATE TABLE afiliados_plan_nacer (
	id_afiliado 		INTEGER(11) 					NOT NULL 	AUTO_INCREMENT,
	id_prov 			TINYINT 		UNSIGNED		NOT NULL,
	id_condicion 		TINYINT 		UNSIGNED 		NOT NULL,
	id_cobertura_social	SMALLINT 		UNSIGNED 		NOT NULL,
	id_tipo_doc 		TINYINT 		UNSIGNED 		NOT NULL,
	sexo	 			ENUM			('M','F','D') 	NOT NULL,
	nro_doc 			INTEGER 		UNSIGNED 		NOT NULL,
	apellido 			VARCHAR(255) 					NOT NULL,
	nombre 				VARCHAR(255) 					NOT NULL,
	fecha_nac 			DATE 							NOT NULL,
	codigo_postal 		VARCHAR(8) 						NOT NULL,
	periodo_aporte 		CHAR(6)							NOT NULL,
	cuil_titular 		BIGINT 			UNSIGNED 		NULL,
	cuit_empresa 		BIGINT 			UNSIGNED 		NULL,
	PRIMARY KEY(id_afiliado),
	INDEX idx_apellido(apellido),
	INDEX idx_nombre(nombre),
	INDEX idx_fecha_nac (fecha_nac),
	INDEX idx_id_cobertura_social(id_cobertura_social),
	INDEX idx_id_prov(id_prov),
	INDEX idx_nro_doc(nro_doc)
)ENGINE=MyISAM;

/* afiliados */
CREATE TABLE afiliados (
	id_afiliado 		INTEGER(11) 					NOT NULL 	AUTO_INCREMENT,
	id_prov 			TINYINT 		UNSIGNED		NOT NULL,
	id_condicion 		TINYINT 		UNSIGNED 		NOT NULL,
	id_cobertura_social	SMALLINT 		UNSIGNED 		NOT NULL,
	id_tipo_doc 		TINYINT 		UNSIGNED 		NOT NULL,
	sexo	 			ENUM			('M','F','D') 	NOT NULL,
	nro_doc 			INTEGER 		UNSIGNED 		NOT NULL,
	apellido 			VARCHAR(255) 					NOT NULL,
	nombre 				VARCHAR(255) 					NOT NULL,
	fecha_nac 			DATE 							NOT NULL,
	codigo_postal 		VARCHAR(8) 						NOT NULL,
	periodo_aporte 		CHAR(6)							NOT NULL,
	cuil_titular 		BIGINT 			UNSIGNED 		NULL,
	cuit_empresa 		BIGINT 			UNSIGNED 		NULL,
	PRIMARY KEY(id_afiliado),
	INDEX idx_apellido(apellido),
	INDEX idx_nombre(nombre),
	INDEX idx_fecha_nac (fecha_nac),
	INDEX idx_id_cobertura_social(id_cobertura_social),
	INDEX idx_id_prov(id_prov),
	INDEX idx_nro_doc(nro_doc)
)ENGINE=MERGE UNION=(afiliados_iapos,afiliados_nacionales,afiliados_profe,afiliados_plan_nacer);

/* condiciones_os */
CREATE TABLE condiciones_os (
	id_condicion 		TINYINT 		UNSIGNED 	NOT NULL 	AUTO_INCREMENT,
	nom_condicion 		VARCHAR(50) 				NOT NULL,
	PRIMARY KEY(id_condicion)
)ENGINE=MyISAM;

INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (1,'TITULAR');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (2,'CONYUGE');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (3,'HIJOS');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (4,'VOLUNTARIOS');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (5,'OPCIONALES');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (6,'ADHERENTE');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (7,'CONCUBINO/A');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (8,'HIJO SOLTERO MENOR DE 21 AÑOS');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (9,'HIJO SOLTERO ENTRE 21/25 AÑOS ESTUDIANTE');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (10,'HIJO DEL CONYUGE SOLTERO MENOR DE 21 AÑOS');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (11,'HIJO DEL CONYUGE ENTRE 21/25 AÑOS ESTUDIANTE');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (12,'MENOR BAJO GUARDA O TUTELA');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (13,'FAMILIAR A CARGO');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (14,'MAYOR DE 25 AÑOS DISCAPACITADOS');
INSERT INTO condiciones_os (id_condicion,nom_condicion) VALUES (15,'SIN INFORMACION');


/* info_actualizacion */
CREATE TABLE info_actualizaciones (
	id_info_actualizacion	TINYINT 		UNSIGNED 	NOT NULL 	AUTO_INCREMENT,
	obra_social		 		VARCHAR(50)					NOT NULL,
	fecha_actualizacion 	CHAR(7) 					NOT NULL,
	PRIMARY KEY(id_info_actualizacion),
	UNIQUE INDEX idx_unique_obra_social (obra_social)
)ENGINE=MyISAM;

INSERT INTO info_actualizaciones VALUES ('N','11/2009');
INSERT INTO info_actualizaciones VALUES ('I','01/2010');
INSERT INTO info_actualizaciones VALUES ('P','12/2009');




/* tipos_documentos */
CREATE TABLE tipos_documentos (
	id_tipo_doc 		TINYINT 		UNSIGNED 	NOT NULL,
	nom_tipo_doc 		CHAR(3) 					NOT NULL,
	nom_largo_tipo_doc	VARCHAR(255)				NOT NULL,
	PRIMARY KEY(id_tipo_doc)
)ENGINE=MyISAM;

INSERT INTO tipos_documentos (id_tipo_doc,nom_tipo_doc,nom_largo_tipo_doc) VALUES (1,'DNI','Documento Nacional de Identidad');
INSERT INTO tipos_documentos (id_tipo_doc,nom_tipo_doc,nom_largo_tipo_doc) VALUES (2,'LC','Libreta civica');
INSERT INTO tipos_documentos (id_tipo_doc,nom_tipo_doc,nom_largo_tipo_doc) VALUES (3,'LE','Libreta de enrolamiento');
INSERT INTO tipos_documentos (id_tipo_doc,nom_tipo_doc,nom_largo_tipo_doc) VALUES (4,'CI','Cedula de identidad');
INSERT INTO tipos_documentos (id_tipo_doc,nom_tipo_doc,nom_largo_tipo_doc) VALUES (5,'OTR','Otros');
INSERT INTO tipos_documentos (id_tipo_doc,nom_tipo_doc,nom_largo_tipo_doc) VALUES (9,'DNR','Dato no registrado');


/* usuarios_web */
CREATE TABLE usuarios_web (
	usuario 			VARCHAR(10) 				NOT NULL,
	password 			VARCHAR(32) 				NOT NULL,
	nombre 				VARCHAR(32) 				NOT NULL,
	mail 				VARCHAR(255) 				NULL,
	visitas 			BIGINT(10) 		UNSIGNED 	NOT NULL,
	ultimaVisita 		TIMESTAMP 					NOT NULL 	DEFAULT '0000-00-00',
	PRIMARY KEY(usuario)
)ENGINE=MyISAM;





/* -------------- */
/* obras_sociales */
/* -------------- */
DROP TABLE IF EXISTS obras_sociales_profe;

CREATE TABLE obras_sociales_profe (

	codos	CHAR(6)		NOT NULL,
	descos	CHAR(50)	NOT NULL
)ENGINE=MyISAM;

LOAD DATA LOCAL INFILE './os/obras_sociales_profe.csv' 
	INTO TABLE obras_sociales_profe
	FIELDS 
		TERMINATED BY ';'
		OPTIONALLY ENCLOSED BY '"'
	LINES
		TERMINATED BY '\r\n';
		
CREATE TABLE coberturas_sociales (
	id_cobertura_social 		SMALLINT 		UNSIGNED 	NOT NULL 	AUTO_INCREMENT,
	rnos		 				CHAR(6) 					NULL,
	nom_cobertura_social	 	VARCHAR(255) 				NOT NULL,
	tipo_cobertura				CHAR(1)						NOT NULL 	COMMENT		'O=obra social; P=plan social',
	PRIMARY KEY(id_cobertura_social),
	INDEX idx_nom_cobertura_social(nom_cobertura_social),
	UNIQUE INDEX idx_unique_rnos(rnos)
)ENGINE=MyISAM;

INSERT INTO coberturas_sociales
	SELECT	0,
			osp.codos,
			TRIM(osp.descos),
			'O'
		FROM	obras_sociales_profe osp
		WHERE	osp.codos>'000010';

INSERT INTO coberturas_sociales VALUES (0,'004000','IAPOS','O');
INSERT INTO coberturas_sociales VALUES (0,'010101','PROFE','O');

/*DROP TABLE obras_sociales_profe;*/
