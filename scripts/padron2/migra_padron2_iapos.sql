/*============================================================= */
/* Integracion del padron de IAPOS a la base "padron2"			*/
/*============================================================= */



/* Elimina la tabla auxIAPOS si ésta existe */
DROP TABLE IF EXISTS padron_iapos;

/* Table: auxIAPOS */
CREATE TABLE padron_iapos
(
   tipodoctitular                 CHAR(2)                  NOT NULL, 
   nrodoctitular                  CHAR(9)                  NOT NULL, 
   tipodocbenef                   CHAR(2)                  NOT NULL, 
   nrodocbenef                    CHAR(9)                  NOT NULL,
   orden                          CHAR(3),                           
   apenom                         CHAR(20),                          
   sexo                           CHAR(1),                           
   fecnac                         CHAR(8),                           
   codpostal                      CHAR(4)                            
);


/* Toma los datos del archivo de texto del IAPOS */
LOAD DATA LOCAL INFILE 'c:/apos1005.dat' 
	INTO TABLE padron_iapos
	FIELDS 	TERMINATED BY '';


/* afiliados_iapos */
DROP TABLE IF EXISTS afiliados_iapos;

CREATE TABLE afiliados_iapos (
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
ALTER TABLE afiliados_iapos DISABLE KEYS;

/* Pasa los datos del padron_iapos a la tabla de afiliados_iapos */
/* inserta los datos en la tabla de afiliados */
INSERT INTO afiliados_iapos 
	SELECT 	0, 
			1, 
			CASE LEFT(orden,1) /* id_condicion */
				WHEN 'A' THEN 1
				WHEN 'B' THEN 2
				WHEN 'C' THEN 3
				WHEN 'D' THEN 4
				WHEN 'E' THEN 5
				ELSE 15
			END, 
			380, 	/* id_obra_social */ 
			CASE LEFT(pi.tipodocbenef,1) /*ps.tipodoc, */
				WHEN 1 THEN 1
				WHEN 2 THEN (IF (pi.sexo=1,2,3))
				WHEN 3 THEN 4
				WHEN 4 THEN 4
				ELSE 5
			END,	
			IF (pi.sexo=1,'M',
				IF (pi.sexo=2,'F',NULL)
				),
			IF (LEFT(pi.nrodocbenef,1)='M' 
				OR LEFT(pi.nrodocbenef,1)='F'
				OR LEFT(pi.nrodocbenef,1)='K',
				SUBSTRING(pi.nrodocbenef,2,7),
				SUBSTRING(pi.nrodocbenef,1,8)
				),
			str_separa_ape(pi.apenom,true),
			str_separa_ape(pi.apenom,false),
			CONCAT(
					LEFT(pi.fecnac,4),
					'-',
					LEFT(RIGHT(pi.fecnac,4),2),
					'-',
					RIGHT(pi.fecnac,2)
					),
			TRIM(pi.codpostal),
			/* !!! actualizar periodo aporte !!! */
			'201005',
			NULL,
			NULL
	FROM padron_iapos pi;

/* quita la tabla auxiliar
DROP TABLE padron_iapos; */

/* Actualiza la tabla infoactualizacion */
UPDATE info_actualizaciones SET fecha_actualizacion='05/2010' WHERE obra_social='I';

/* Reactiva los indices */
ALTER TABLE afiliados_iapos ENABLE KEYS;