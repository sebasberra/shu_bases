/* Elimina la tabla auxiliar si existe */
DROP TABLE IF EXISTS padron_profe;

/* Crea una tabla auxiliar con la estructura del archivo de texto */
CREATE TABLE padron_profe(
	Clave_ExCaja			TINYINT,
	Clave_Tipo				TINYINT,
	Clave_Numero			INTEGER,
	Clave_Coparticipe		TINYINT,
	Clave_Parentesco		TINYINT,
	LeyAplicada				CHAR(2),
	ApeNom					CHAR(20),
	Sexo					CHAR(1),
	EstCivil				TINYINT,
	Tipo_Doc				CHAR(2),
	Numero_Doc				INTEGER,
	FeNac					CHAR(10),
	Incapacidad				TINYINT,
	Fech_Alta				DATE,
	Dom_Calle				CHAR(50),
	Calle_Numero			INTEGER,
	Dom_Piso				INTEGER,
	Dom_Dpto				CHAR(3),
	Cod_Pos					CHAR(8),
	Provincia				INTEGER,
	Departamento			INTEGER,
	Localidad				INTEGER
)ENGINE=MyISAM;

/* Toma los datos del archivo de texto del Profe */
LOAD DATA LOCAL INFILE 'c:/padronprofe.txt' 
	INTO TABLE padron_profe
	FIELDS TERMINATED BY ',' 
	IGNORE 1 LINES;

	
/* afiliados_profe */
DROP TABLE IF EXISTS afiliados_profe;

/* afiliados_profe */
CREATE TABLE afiliados_profe (
	id_afiliado 		INTEGER(11) 					NOT NULL 	AUTO_INCREMENT,
	id_prov 			TINYINT 		UNSIGNED		NOT NULL,
	id_condicion 		TINYINT 		UNSIGNED 		NOT NULL,
	id_obra_social 		SMALLINT 		UNSIGNED 		NOT NULL,
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
	INDEX idx_id_obra_social(id_obra_social),
	INDEX idx_id_prov(id_prov),
	INDEX idx_nro_doc(nro_doc)
)ENGINE=MyISAM;
	
/* Deshabilita los indices */
ALTER TABLE afiliados_profe DISABLE KEYS;

/* Inserta los datos */
INSERT INTO afiliados_profe
	SELECT	0,
			1,
			IF (pp.Clave_Parentesco=0,1,6),
			381,
			CASE pp.Tipo_Doc
				WHEN 'DU' THEN 1
				WHEN 'LE' THEN 2
				WHEN 'LC' THEN 3
				WHEN 'CI' THEN 4
				ELSE 5
			END,
			pp.Sexo,
			pp.Numero_Doc,
			str_separa_ape(pp.ApeNom,true),
			str_separa_ape(pp.ApeNom,false),
			CONCAT(
				RIGHT(pp.FeNac,4),
				'-',
				RIGHT(LEFT(pp.FeNac,5),2),
				'-',
				LEFT(pp.FeNac,2)
			),
			Cod_Pos,
			'201004',
			NULL,
			NULL 
	FROM padron_profe pp;

/* elimina tabla padron_profe */
/*DROP TABLE padron_profe;*/

/* actualiza tabla info_actualizaciones */
UPDATE info_actualizaciones SET fecha_actualizacion='04/2010' WHERE obra_social='P';

/* Reactiva los indices */
ALTER TABLE afiliados_profe ENABLE KEYS;