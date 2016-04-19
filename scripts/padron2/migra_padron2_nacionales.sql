/* Carga de datos al Padron2 */
/* AFILIADOS NACIONALES */
/* Informacion proveniente de la superintendencia de salud */


/* padron_superintendencia */
DROP TABLE IF EXISTS padron_superintendencia;

CREATE TABLE padron_superintendencia
(
   cuilbenef                      CHAR(11)              NOT NULL,
   tipodoc                        CHAR(2)               NOT NULL,
   nrodoc                         CHAR(8)               NOT NULL,
   apenom                         CHAR(30)              NOT NULL,
   sexo                           CHAR(1)				NOT NULL,
   fecnac                         CHAR(8)				NOT NULL,
   tipobenef                      CHAR(1)				NOT NULL,
   codparentezco                  CHAR(1)				NOT NULL,
   codpostal                      CHAR(8)				NOT NULL,
   provincia                      CHAR(2)				NOT NULL,
   cuiltitular                    CHAR(11)				NOT NULL,
   codobrsoc                      CHAR(6)				NOT NULL,
   ultperaporte                   CHAR(6)				NOT NULL,
   validcuil                      CHAR(1)				NOT NULL,
   cuitempleador                  CHAR(11)				NOT NULL
)ENGINE=MyISAM;

/* carga los datos de los archivos de texto */
LOAD DATA LOCAL INFILE 'c:/Padron_MSalud-001.txt' 
	INTO TABLE padron_superintendencia
	FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'c:/Padron_MSalud-002.txt' 
	INTO TABLE padron_superintendencia
	FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'c:/Padron_MSalud-003.txt' 
	INTO TABLE padron_superintendencia
	FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'c:/Padron_MSalud-004.txt' 
	INTO TABLE padron_superintendencia
	FIELDS TERMINATED BY ',';

/* afiliados_nacionales */
DROP TABLE IF EXISTS afiliados_nacionales;

/* afiliados_nacionales */
CREATE TABLE afiliados_nacionales (
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
ALTER TABLE afiliados_nacionales DISABLE KEYS;
	
/* inserta los datos en la tabla de afiliados */
INSERT INTO afiliados_nacionales 
	SELECT 	0, 
			(SELECT prs.id_prov 
				FROM provincias_superintendencia prs
				WHERE prs.codprov=ps.provincia
			), 
			CASE ps.codparentezco
				WHEN 0 THEN 1	/* titular										*/
				WHEN 1 THEN 2	/* conyuge										*/
				WHEN 2 THEN 7	/* concubino 									*/
				WHEN 3 THEN 8	/* hijo soltero menor dee 21 años				*/
				WHEN 4 THEN 9	/* hijo soltero entre 21/25 años estudiante		*/
				WHEN 5 THEN 10	/* hijo del conyuge soltero menor de 21 años	*/
				WHEN 6 THEN 11	/* hijo del conyuge entre 21/25 años estudiante	*/
				WHEN 7 THEN 12	/* menor bajo guarda o tutela					*/
				WHEN 8 THEN 13	/* familiar a cargo								*/
				WHEN 9 THEN 14	/* mayor de 25 años discapacitado				*/
				ELSE 15			/* sin informacion								*/
			END, 
			IFNULL((SELECT id_cobertura_social		
				FROM	coberturas_sociales
				WHERE	rnos = ps.codobrsoc),360), 
			CASE ps.tipodoc		/* ps.tipodoc, */
				WHEN 'DU' THEN 1
				WHEN 'LE' THEN 2
				WHEN 'LC' THEN 3
				WHEN 'PA' THEN 5
				WHEN 'ET' THEN 5
				WHEN '99' THEN 9
				WHEN '02' THEN 4
				WHEN '08' THEN 4
				WHEN '01' THEN 4
				WHEN '07' THEN 4
				WHEN '16' THEN 4
				WHEN '11' THEN 4
				WHEN '13' THEN 4
				ELSE 9
			END,
			ps.sexo,
			ps.nrodoc,
			str_separa_ape(ps.apenom,true),
			str_separa_ape(ps.apenom,false),
			CONCAT(
					RIGHT(ps.fecnac,4),
					'-',
					LEFT(RIGHT(ps.fecnac,6),2),
					'-',
					LEFT(ps.fecnac,2)
					),
			TRIM(ps.codpostal),
			/* Si el Periodo de aporte es 000000 pone la fecha de 
			/* de actualizacion. NOTA: ACTUALIZAR ESTE DATO */
			IF (ps.ultperaporte='000000','201002',ps.ultperaporte),
			ps.cuiltitular,
			ps.cuitempleador
	FROM padron_superintendencia ps;

/* elimina tabla auxPadrones
DROP TABLE provincias_superintendencia; 
DROP TABLE padron_superintendencia; */

/* actualiza a iñiguez */
UPDATE afiliados_nacionales SET apellido='IÑIGUEZ' WHERE nro_doc='25992436';

/* actualiza tabla infoActualizacion */
UPDATE info_actualizaciones SET fecha_actualizacion='02/2010' WHERE obra_social='N';

/* Reactiva los indices */
ALTER TABLE afiliados_nacionales ENABLE KEYS;