/* Carga las tablas base con la info del HMI */

/* IMPORTANTE: Modificar los nombres de los archivos fuentes y actualizar	*/
/* Actualizar los nombres de base de datos auxiliares. Son ! 3 !			*/

/* Casilda, Hospital SC 					->	id_efector = 434	*/
/* Samco Ceres								->  id_efector = 226	*/
/* Samco Hersilia							->  id_efector = 230	*/
/* Samco Maria Susana						->  id_efector = 329	*/
/* Samco Pilar								->  id_efector = 127	*/
/* Samco Rafaela							->  id_efector = 450	*/
/* Samco Sastre								->  id_efector = 333	*/
/* Hospital Mira y Lope						->  id_efector = 73		*/
/* Samco San Jorge							->  id_efector = 331	*/
/* Samco Villa Eloisa						->  id_efector = 47		*/
/* Samco Vera								->  id_efector = 340	*/
/* Hospital Cullen							->	id_efector = 71		*/
/* Hospital Iturraspe						->	id_efector = 72		*/
/* Inst. Vera Candiotti 					->	id_efector = 74		*/
/* Hospital Alassia							->	id_efector = 121	*/
/* Hospital Eva Peron   					->  id_efector = 167	*/
/* Hospital Centenario						->	id_efector = 183	*/
/* Hospital Provincial						->	id_efector = 184	*/
/* Hospital San Javier						->	id_efector = 251	*/
/* Hospital Santo Tome  					->  id_efector = 86		*/
/* Hospital Protomedico						->	id_efector = 63		*/
/* Hospital Sayago							->	id_efector = 64		*/
/* Hospital San Lorenzo 					->  id_efector = 313	*/
/* Hospital Dra Olga Stucky (Reconquista)   ->	id_efector = 5		*/
/* Hospital Cañada de Gomez (Hosp San Jose) ->  id_efector = 38		*/
/* Hospital San Justo						->	id_efector = 292	*/
/* Hospital Totaras							->	id_efector = 45		*/


SET @id_efector := 340;

	/*CREATE DATABASE IF NOT EXISTS hmi_alassia_18_10_2012;
	CREATE DATABASE IF NOT EXISTS hmi_casilda_30_08_2011; 
	CREATE DATABASE IF NOT EXISTS hmi_centenario_05_11_2011;
	CREATE DATABASE IF NOT EXISTS hmi_ceres_28_02_2011; 
	CREATE DATABASE IF NOT EXISTS hmi_cullen_20_03_2012; 
	CREATE DATABASE IF NOT EXISTS hmi_evaperon_20_03_2012;
	CREATE DATABASE IF NOT EXISTS hmi_iturraspe_04_05_2012; 
	CREATE DATABASE IF NOT EXISTS hmi_mariasusana_28_02_2011;
	CREATE DATABASE IF NOT EXISTS hmi_pilar_03_03_2011;
	CREATE DATABASE IF NOT EXISTS hmi_provincial_01_03_2011;
	CREATE DATABASE IF NOT EXISTS hmi_rafaela_23_02_2011;
	CREATE DATABASE IF NOT EXISTS hmi_santotome_23_08_2011;
	CREATE DATABASE IF NOT EXISTS hmi_sastre_28_02_2011;
	CREATE DATABASE IF NOT EXISTS hmi_miraylopez_20_03_2012;
	CREATE DATABASE IF NOT EXISTS hmi_sanjavier_20_11_2012;
	CREATE DATABASE IF NOT EXISTS hmi_sanjusto_20_03_2012;
	CREATE DATABASE IF NOT EXISTS hmi_totoras_20_03_2012;
	CREATE DATABASE IF NOT EXISTS hmi_sanjorge_22_07_2011;
	CREATE DATABASE IF NOT EXISTS hmi_villaeloisa_28_02_2011;
	CREATE DATABASE IF NOT EXISTS hmi_vera_20_11_2012;
	CREATE DATABASE IF NOT EXISTS hmi_veracandiotti_25_02_2011;
	CREATE DATABASE IF NOT EXISTS hmi_protomedico_27_06_2012;
	CREATE DATABASE IF NOT EXISTS hmi_canada_gomez_20_11_2012;*/
	DROP DATABASE IF EXISTS migra_hmi_personas_auxiliar;
	CREATE DATABASE migra_hmi_personas_auxiliar;/*
	CREATE DATABASE IF NOT EXISTS hmi_hersilia_20_03_2012;*/
	
 	USE migra_hmi_personas_auxiliar 

	




/* Fecha de ultima actualizacion 15/03/2011 */

CREATE DATABASE IF NOT EXISTS migra_hmi_personas;


/* Crea y carga las tablas auxiliares de codigos del HMI*/
DROP TABLE IF EXISTS migra_hmi_personas.asociado_hmi;
DROP TABLE IF EXISTS migra_hmi_personas.instruccion_hmi;
DROP TABLE IF EXISTS migra_hmi_personas.situacion_laboral_hmi;

CREATE TABLE migra_hmi_personas.asociado_hmi (
	id_asociado		CHAR(1) NOT NULL,
	desc_asociado	VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_asociado)
) TYPE=MyISAM;

INSERT INTO migra_hmi_personas.asociado_hmi VALUES ('1','obra social'),('2','plan de salud privado o laboral'),
	('3','plan o seguro publico'),('4','mas de uno'),('5','ninguno'),('6','se ignora');
	
CREATE TABLE migra_hmi_personas.instruccion_hmi (
	id_instruccion		CHAR(2) 	NOT NULL,
	desc_instruccion	VARCHAR(50)	NOT NULL,
	PRIMARY KEY (id_instruccion)
) TYPE=MyISAM;

INSERT INTO migra_hmi_personas.instruccion_hmi (id_instruccion,desc_instruccion) VALUES ('01','nunca asistio'),('02','primaria incompleta'),
	('03','primaria completa'),('04','secundario incompleto'),('05','secundario completo'),('06','universitario incompleto'),
	('07','universitario completo'),('11','egb.(1-2) incompleto'),('12','egb.(1-2) completo'),('13','egb.(3) incompleto'),
	('14','egb.(3) completo'),('15','polimodal incompleto'),('16','polimodal completo');

CREATE TABLE migra_hmi_personas.situacion_laboral_hmi (	  
	id_sit_lab		CHAR(1) NOT NULL,
	desc_sit_lab	VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_sit_lab)
) TYPE=MyISAM;

INSERT INTO migra_hmi_personas.situacion_laboral_hmi VALUES ('1','trabaja o esta de licencia'),('2','busca trabajo'),
	('3','no busca trabajo');

/* Fin de creacion y carga de tablas auxiliares de codigos del HMI */


DROP TABLE IF EXISTS dg_pacientes_hmi_cruda;
DROP TABLE IF EXISTS dg5_pacientes_hmi_cruda;


/* arma la tabla donde se va a volcar los datos generales de pacientes del hmi dg */
CREATE TABLE dg_pacientes_hmi_cruda (
ptipdoc			CHAR(1)		NOT NULL,
nrodoc	   		INTEGER		NOT NULL,
s1hiscli  		INTEGER		NOT NULL,
apenompac 		CHAR(30)	NOT NULL,
apenommad 		CHAR(30)	NULL,
calle	    	CHAR(40)	NOT NULL,
domnro	   		CHAR(5)		NOT NULL,
dompiso	  		CHAR(2)		NOT NULL,
domdep	   		CHAR(2)		NULL,
pais	     	CHAR(3)		NOT NULL,
provincia 		CHAR(2)		NOT NULL,
departamento  	CHAR(3)		NOT NULL,
localidad 	   	CHAR(3)		NOT NULL,
sexo	      	CHAR(1)		NOT NULL,
cantobrasocial	CHAR(1)		NOT NULL,
fnanio	   		CHAR(4)		NOT NULL,
fnmes	    	CHAR(2)		NOT NULL,
fndia	    	CHAR(2)		NOT NULL,
fpanio	   		CHAR(4)		NOT NULL,
fpmes	    	CHAR(2)		NOT NULL,
fpdia	    	CHAR(2)		NOT NULL,
conext	   		CHAR(3)		NOT NULL,
inter	    	CHAR(3)		NOT NULL,
condicion 		CHAR(1)		NOT NULL,
fcanio	   		CHAR(4)		NOT NULL,
fcmes	    	CHAR(2)		NOT NULL,
fcdia	    	CHAR(2)		NOT NULL,
s3hisclice		INTEGER		NOT NULL,
PRIMARY KEY (ptipdoc,nrodoc))
ENGINE=MyISAM;

/* carga los datos de los archivos de texto de datos generales de pacientes */
LOAD DATA LOCAL INFILE './hvera/hmidg.txt' 
	INTO TABLE dg_pacientes_hmi_cruda
	FIELDS	TERMINATED BY '|'
	IGNORE 1 LINES;

	
/* corrige el codigo de localidad, que es de 2 caracteres */
UPDATE dg_pacientes_hmi_cruda SET localidad=RIGHT(localidad,2);
ALTER TABLE dg_pacientes_hmi_cruda MODIFY localidad CHAR(2);

/* arma la tabla donde se va a volcar los datos generales de pacientes del hmi dg5 */
CREATE TABLE dg5_pacientes_hmi_cruda(
ptipdoc			CHAR(1)		NOT NULL,
nrodoc			INTEGER		NOT NULL,
fmanio			CHAR(4)		NOT NULL,
fmmes			CHAR(2)		NOT NULL,
fmdia			CHAR(2)		NOT NULL,
tipo_mad		CHAR(1)		NOT NULL,
nrodoc_mad		CHAR(9)		NOT NULL,
barrio			CHAR(30)	NOT NULL,
carac_tc		CHAR(5)		NOT NULL,
pre_tc			CHAR(3)		NOT NULL,
nro_tc			CHAR(6)		NOT NULL,
carac_td		CHAR(5)		NOT NULL,
nro_td			CHAR(7)		NOT NULL,
asociado		CHAR(1)		NOT NULL,
instruc			CHAR(2)		NOT NULL,
sit_lab			CHAR(1)		NOT NULL,
ocup_hab		CHAR(5)		NOT NULL,
PRIMARY KEY (ptipdoc,nrodoc))
ENGINE=MyISAM;

/* carga los datos de extension de datos generales de pacientes de los archivos de texto */
LOAD DATA LOCAL INFILE './hvera/hmidg5.txt'
	INTO TABLE dg5_pacientes_hmi_cruda
	FIELDS	TERMINATED BY ';'
	IGNORE 1 LINES;
	
/* arma la tabla juntando las 2 tablas */
DROP TABLE IF EXISTS dg_pacientes_hmi;

/* datos generales de pacientes del hmi, junta las dos tablas dg y dg5 */
CREATE TABLE dg_pacientes_hmi (
ptipdoc		   	CHAR(1)		NOT NULL,
nrodoc		  	INTEGER		NOT NULL,
s1hiscli	   	INTEGER		NULL,
apenompac	  	CHAR(30)	NOT NULL,
apenommad	  	CHAR(30)	NULL,
calle		   	CHAR(40)	NOT NULL,
domnro		  	CHAR(5)		NOT NULL,
dompiso		   	CHAR(2)		NOT NULL,
domdep		  	CHAR(2)		NULL,
pais		   	CHAR(3)		NOT NULL,
provincia	  	CHAR(2)		NOT NULL,
departamento	CHAR(3)		NOT NULL,
localidad	  	CHAR(3)		NOT NULL,
sexo		   	CHAR(1)		NOT NULL,
cantobrasocial	CHAR(1)		NOT NULL,
fnanio		   	CHAR(4)		NOT NULL,
fnmes		   	CHAR(2)		NOT NULL,
fndia		   	CHAR(2)		NOT NULL,
fpanio		   	CHAR(4)		NOT NULL,
fpmes		   	CHAR(2)		NOT NULL,
fpdia		   	CHAR(2)		NOT NULL,
conext		   	CHAR(3)		NOT NULL,
inter		   	CHAR(3)		NOT NULL,
condicion	  	CHAR(1)		NOT NULL,
fcanio		   	CHAR(4)		NOT NULL,
fcmes		   	CHAR(2)		NOT NULL,
fcdia		   	CHAR(2)		NOT NULL,
s3hisclice	 	INTEGER		NULL,
fmanio		   	CHAR(4)		NULL,
fmmes		   	CHAR(2)		NULL,
fmdia		   	CHAR(2)		NULL,
tipo_mad	   	CHAR(1)		NULL,
nrodoc_mad	 	CHAR(9)		NULL,
barrio		   	CHAR(30)	NULL,
carac_tc	   	CHAR(5)		NULL,
pre_tc		   	CHAR(3)		NULL,
nro_tc		  	CHAR(6)		NULL,
carac_td	   	CHAR(5)		NULL,
nro_td		   	CHAR(7)		NULL,
asociado	   	CHAR(1)		NULL,
instruc		   	CHAR(2)		NULL,
sit_lab		   	CHAR(1)		NULL,
ocup_hab	   	CHAR(5)		NULL,
marca_borrado	BOOLEAN		NOT NULL DEFAULT FALSE,
PRIMARY KEY (ptipdoc,nrodoc))
ENGINE=MyISAM;

/* Carga los datos de la primer tabla datos generales de pacientes dg a la tabla definitiva */
LOAD DATA LOCAL INFILE './hvera/hmidg.txt' 
	INTO TABLE dg_pacientes_hmi
	FIELDS	TERMINATED BY '|'
	IGNORE 1 LINES;

/* corrige el codigo de localidad, que es de 2 caracteres */
UPDATE dg_pacientes_hmi SET localidad=RIGHT(localidad,2);
ALTER TABLE dg_pacientes_hmi MODIFY localidad CHAR(2);

/* actualiza la tabla definitiva haciendo un cruce con la tabla de extension de datos generales dg5 */
UPDATE dg_pacientes_hmi dg,dg5_pacientes_hmi_cruda dg5_c
	SET	dg.fmanio		= dg5_c.fmanio,
		dg.fmmes		= dg5_c.fmmes,
		dg.fmdia		= dg5_c.fmdia,
		dg.tipo_mad		= dg5_c.tipo_mad,
		dg.nrodoc_mad	= dg5_c.nrodoc_mad,
		dg.barrio		= dg5_c.barrio,
		dg.carac_tc		= dg5_c.carac_tc,
		dg.pre_tc		= dg5_c.pre_tc,
		dg.nro_tc		= dg5_c.nro_tc,
		dg.carac_td		= dg5_c.carac_td,
		dg.nro_td		= dg5_c.nro_td,
		dg.asociado		= dg5_c.asociado,
		dg.instruc		= dg5_c.instruc,
		dg.sit_lab		= dg5_c.sit_lab,
		dg.ocup_hab		= dg5_c.ocup_hab 
	WHERE 	dg.ptipdoc = dg5_c.ptipdoc
	AND		dg.nrodoc  = dg5_c.nrodoc;

/* pone en NULL las historias clinicas = 0 */
UPDATE dg_pacientes_hmi SET s1hiscli = NULL WHERE s1hiscli=0;
UPDATE dg_pacientes_hmi SET s3hisclice = NULL WHERE s3hisclice=0;	
	
	

/* Elimina los pacientes del HMI con tipo doc 7, 8 o 9 que son para los pacientes que le ponen	*/
/* como numero de documento el nro de historia clinica											*/

DELETE FROM dg_pacientes_hmi 
	WHERE 	ptipdoc = 8 
	OR 		ptipdoc = 9
	OR		ptipdoc = 7;

/* Modifica el tipo de documento para que sea como en la base personas */
ALTER TABLE dg_pacientes_hmi MODIFY COLUMN ptipdoc CHAR(3) NOT NULL;
ALTER TABLE dg_pacientes_hmi MODIFY COLUMN tipo_mad CHAR(3) NULL;

UPDATE dg_pacientes_hmi
	SET 
		ptipdoc	= 
				(CASE ptipdoc
					WHEN '0' THEN 'DNR'
					WHEN '1' THEN 'DNI'
					WHEN '2' THEN 'LC'
					WHEN '3' THEN 'LE'
					WHEN '4' THEN 'CI'
					WHEN '5' THEN 'OTR'
					ELSE 'DNR'
				END),			
		tipo_mad =
				(CASE tipo_mad
					WHEN '0' THEN 'DNR'
					WHEN '1' THEN 'DNI'
					WHEN '2' THEN 'LC'
					WHEN '3' THEN 'LE'
					WHEN '4' THEN 'CI'
					WHEN '5' THEN 'OTR'
					ELSE 'DNR'
				END); 					
	
/* crea los indices para la tabla migrada del hmi */
CREATE INDEX idx_nrodoc ON dg_pacientes_hmi (nrodoc);
CREATE INDEX idx_tipo_nro_doc ON dg_pacientes_hmi (ptipdoc,nrodoc);
CREATE INDEX idx_s1hiscli ON dg_pacientes_hmi (s1hiscli);
CREATE INDEX idx_s3hisclice ON dg_pacientes_hmi (s3hisclice);

/* Actualiza los valores de historia clinica de consultorio externo con 2020202 */
UPDATE dg_pacientes_hmi 
	SET s3hisclice		=	NULL 
	WHERE s3hisclice	=	2020202
	OR	s3hisclice		=	2000002;

/* Crea una tabla auxiliar de migracion con la estructura de la tabla personas */
/* hace drop de la tabla auxiliar de migracion */
DROP TABLE IF EXISTS migra_hmi_personas.hmi_dg_pacientes_personas;

/* crea la tabla auxiliar que se usa para migrar los datos */
CREATE TABLE migra_hmi_personas.hmi_dg_pacientes_personas (
	id_localidad 		INTEGER(10) 	UNSIGNED 	NULL,
	tipo_doc 			VARCHAR(15) 				NOT NULL,
	nro_doc 			INTEGER 		UNSIGNED	NOT NULL,
	apellido 			VARCHAR(255) 				NOT NULL,
	nombre 				VARCHAR(255) 				NOT NULL,
	sexo 				CHAR(1) 					NOT NULL,
	dom_calle 			VARCHAR(255) 				NULL,
	dom_nro 			VARCHAR(20) 				NULL,
	dom_dpto 			CHAR(3) 					NULL,
	dom_piso 			VARCHAR(5) 					NULL,
	dom_mza_monobloc 	VARCHAR(40) 				NULL,
	telefono_dom 		VARCHAR(30) 				NULL,
	telefono_cel 		VARCHAR(30) 				NULL,
	barrio 				VARCHAR(255) 				NULL,
	localidad 			VARCHAR(255) 				NULL,
	departamento 		VARCHAR(255) 				NULL,
	provincia 			VARCHAR(255) 				NULL,
	pais 				VARCHAR(255) 				NULL,
	fecha_nac 			DATE 						NULL,
	ocupacion 			VARCHAR(255) 				NULL,
	tipo_doc_madre 		VARCHAR(15) 				NULL,
	nro_doc_madre 		VARCHAR(255) 				NULL,
	nivel_academico 	VARCHAR(255) 				NULL,
	estado_civil 		VARCHAR(25) 				NULL,
	situacion_laboral 	VARCHAR(255) 				NULL,
	asociado 			VARCHAR(50) 				NULL,
	fallecido 			BOOLEAN 					NOT NULL,
	fecha_ultima_cond 	DATE 						NULL,
	s1hiscli			INTEGER						NULL,
	s3hisclice			INTEGER						NULL,
	marca_borrado		BOOLEAN						NOT NULL,
	marca_diferente		BOOLEAN						NOT NULL,
	FOREIGN KEY fk_id_localidad (id_localidad)
	REFERENCES localidades(id_localidad)
		ON DELETE RESTRICT
		ON UPDATE RESTRICT
	) ENGINE=MyISAM;

	
/* crea un indice unico para tipo y nro de doc */
CREATE UNIQUE INDEX idx_unique_tipo_nro_doc ON migra_hmi_personas.hmi_dg_pacientes_personas (tipo_doc,nro_doc);

/* crea indice unico para el numero de historia clinica "s1hiscli" */
CREATE UNIQUE INDEX idx_s1hiscli ON migra_hmi_personas.hmi_dg_pacientes_personas (s1hiscli);

/* crea indice unico para el numero de historia clinica "s3hisclice" */
CREATE UNIQUE INDEX idx_s3hisclice ON migra_hmi_personas.hmi_dg_pacientes_personas (s3hisclice);

/* indice para nro de documento "nro_doc" */
CREATE INDEX idx_nro_doc ON migra_hmi_personas.hmi_dg_pacientes_personas (nro_doc);

CREATE INDEX idx_fallecido ON migra_hmi_personas.hmi_dg_pacientes_personas (fallecido);


/* Crea tabla para guardar historias clinicas duplicadas */
CREATE TABLE IF NOT EXISTS migras.hc_hmi_duplicadas (
	id_hmi_duplicada			INTEGER		UNSIGNED	AUTO_INCREMENT,
	id_efector					INTEGER 	UNSIGNED 	NOT NULL COMMENT 'id del efector de donde es la historia clinica',
	tipo_doc					CHAR(3) 				NOT NULL COMMENT 'tipo y nro de documento',
	nro_doc						INTEGER 	UNSIGNED 	NOT NULL,
	apellido					VARCHAR(255)			NOT NULL,
	nombre						VARCHAR(255)			NOT NULL,
	fecha_nac					DATE					NULL,
	his_cli_internacion_hmi 	INTEGER 	UNSIGNED 	NULL COMMENT 'Historia clinica',
	his_cli_ce_hmi 				INTEGER 	UNSIGNED 	NULL,
	PRIMARY KEY (id_hmi_duplicada),
	FOREIGN KEY fk_id_efector (id_efector)
	    REFERENCES efectores(id_efector)
	      ON DELETE RESTRICT
	      ON UPDATE RESTRICT,
	UNIQUE INDEX idx_unique_id_efector_tipo_doc_nro_doc_his_cli_internacion_hmi 
		(id_efector, tipo_doc, nro_doc, his_cli_internacion_hmi),
	UNIQUE INDEX idx_unique_id_efector_tipo_doc_nro_doc_his_cli_ce_hmi 
		(id_efector, tipo_doc, nro_doc, his_cli_ce_hmi),
	INDEX idx_id_efector_his_cli_internacion_hmi (id_efector,his_cli_internacion_hmi),
	INDEX idx_id_efector_his_cli_ce_hmi (id_efector,his_cli_ce_hmi)
) ENGINE=MyISAM;



/* deshabilita los indices de la tabla "hmi_dg_pacientes_personas" */
ALTER TABLE migra_hmi_personas.hmi_dg_pacientes_personas DISABLE KEYS;

/* NOTA: en la insercion de los pacientes, en caso de darse algun duplicado de tipo y nro de documento	*/
/* o duplicado de historia clinica (la tabla tiene creado los indices unicos correspondientes), se 		*/
/* pone la marca_diferente = TRUE al primer registro que entro											*/
INSERT INTO migra_hmi_personas.hmi_dg_pacientes_personas
	SELECT 
			(SELECT id_localidad 
				FROM localidades.localidades l,localidades.departamentos d 
					WHERE	l.cod_loc	= dg.localidad
					AND		d.cod_dpto	= dg.departamento
					AND		l.id_dpto	= d.id_dpto),
			dg.ptipdoc,
			dg.nrodoc,
			migras.str_separa_ape(dg.apenompac,TRUE),
			migras.str_separa_ape(dg.apenompac,FALSE),
			CASE sexo
				WHEN '0' THEN 'D'
				WHEN '1' THEN 'M'
				WHEN '2' THEN 'F'
				ELSE 'D'
        	END,
			calle,
			domnro,
			IF (domdep='',NULL,domdep),
			NULL,
			NULL,
			TRIM(CONCAT(carac_td,' ',nro_td)),
			TRIM(CONCAT(carac_tc,' ',pre_tc,' ',nro_tc)),
			barrio,
			(SELECT nom_loc 
				FROM localidades.localidades l,localidades.departamentos d 
					WHERE	l.cod_loc	= dg.localidad
					AND		d.cod_dpto	= dg.departamento
					AND		l.id_dpto	= d.id_dpto),
			(SELECT nom_dpto 
				FROM localidades.departamentos d 
					WHERE	d.cod_dpto	= dg.departamento),
			(SELECT nom_prov 
				FROM localidades.provincias p 
					WHERE	p.cod_prov	= dg.provincia),
			(SELECT nom_pais 
				FROM localidades.paises p 
					WHERE	p.cod_pais	= dg.pais),						
			IF (
				migras.es_fecha(
					CONCAT( dg.fnanio ,'-',dg.fnmes,'-',dg.fndia)
					),
				migras.valida_fecha_nac(
					CONCAT( dg.fnanio ,'-',dg.fnmes,'-',dg.fndia)
					),
				NULL
			),
			dg.ocup_hab,
			dg.tipo_mad,
			dg.nrodoc_mad,
			(SELECT desc_instruccion 
				FROM migra_hmi_personas.instruccion_hmi i
				WHERE i.id_instruccion=dg.instruc),
			NULL,
			(SELECT desc_sit_lab
				FROM migra_hmi_personas.situacion_laboral_hmi s
				WHERE s.id_sit_lab=dg.sit_lab),
			(SELECT desc_asociado
				FROM migra_hmi_personas.asociado_hmi a
				WHERE a.id_asociado=dg.asociado),
			IF (dg.condicion=2,TRUE,FALSE),
			IF (
				migras.es_fecha(
					CONCAT(dg.fcanio,'-',dg.fcmes,'-',dg.fcdia)
					),
				migras.valida_fecha_nac(
					CONCAT(dg.fcanio,'-',dg.fcmes,'-',dg.fcdia)
					),
				NULL
			),
			IF (dg.s1hiscli=0,NULL,dg.s1hiscli),
			IF (dg.s3hisclice=0,NULL,dg.s3hisclice),
			FALSE,
			FALSE
			
	FROM 	dg_pacientes_hmi dg
	
	ON DUPLICATE KEY UPDATE
		
			marca_diferente = TRUE;
	
	
/* habilita los indices de la tabla "hmi_dg_pacientes_personas" */
ALTER TABLE migra_hmi_personas.hmi_dg_pacientes_personas ENABLE KEYS;

/* Elimina las historias clinicas duplicadas que hallan quedado de una migracion anterior */
/* del efector*/
DELETE 
	FROM migras.hc_hmi_duplicadas
	WHERE id_efector = @id_efector;
	
/* Ingresa las historias clinicas duplicadas en una tabla auxiliar - segun hc de internacion */
INSERT INTO migras.hc_hmi_duplicadas
	SELECT 	
			0,
			@id_efector,
			dg.ptipdoc,			                                
			dg.nrodoc,					            
			migras.str_separa_ape(dg.apenompac,TRUE),
			migras.str_separa_ape(dg.apenompac,FALSE),					             
			CONCAT(dg.fcanio,'-',dg.fcmes,'-',dg.fcdia),				           
			dg.s1hiscli,
			dg.s3hisclice      
			
		FROM
			dg_pacientes_hmi dg
						
		WHERE
			1 < (SELECT COUNT(*)
					FROM dg_pacientes_hmi dg2
					WHERE
						dg2.s1hiscli	= dg.s1hiscli)
		ON DUPLICATE KEY UPDATE
			his_cli_internacion_hmi = dg.s1hiscli;

			
/* Ingresa las historias clinicas duplicadas en una tabla auxiliar - segun hc de ce */						
INSERT INTO migras.hc_hmi_duplicadas
	SELECT 	
			0,
			@id_efector,
			dg.ptipdoc,			                                
			dg.nrodoc,					            
			migras.str_separa_ape(dg.apenompac,TRUE),
			migras.str_separa_ape(dg.apenompac,FALSE),					             
			CONCAT(dg.fcanio,'-',dg.fcmes,'-',dg.fcdia),				           
			dg.s1hiscli,
			dg.s3hisclice	      
			
		FROM
			dg_pacientes_hmi dg
						
		WHERE
	
			1 < (SELECT COUNT(*)
					FROM dg_pacientes_hmi dg2
					WHERE
						dg2.s3hisclice	= dg.s3hisclice)
		ON DUPLICATE KEY UPDATE
			his_cli_ce_hmi = dg.s3hisclice;