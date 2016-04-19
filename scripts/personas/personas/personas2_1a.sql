/* Estructura de base de personas 2.1a */

DROP TABLE IF EXISTS hc_personas;
DROP TABLE IF EXISTS personas;
DROP TABLE IF EXISTS personas_hmi_docs_inconsistentes;
DROP TABLE IF EXISTS personas_sihos_docs_inconsistentes;
DROP TABLE IF EXISTS personas_sicap_docs_inconsistentes;
DROP TABLE IF EXISTS personas_diagnose_docs_inconsistentes;
DROP TABLE IF EXISTS hc_personas_hmi_diferentes;
DROP TABLE IF EXISTS hc_personas_diagnose_diferentes;



/* Tabla de historias clinicas */
CREATE TABLE hc_personas (
	id_hc_persona					INT(10) 	UNSIGNED 			NOT NULL AUTO_INCREMENT,
	id_efector						INT(10) 	UNSIGNED 	DEFAULT NULL,           
	id_persona						INT(10) 	UNSIGNED 			NOT NULL,               
	id_sistema_propietario			TINYINT(3) 	UNSIGNED 	DEFAULT NULL,        
	numero_paciente_sicap			INT(10) 	UNSIGNED 	DEFAULT NULL,           
	numero_grupo_familiar_sicap		INT(10) 	UNSIGNED 	DEFAULT NULL,           
	historia_familiar_sicap			VARCHAR(11) 			DEFAULT NULL,                
	historia_personal_sicap			VARCHAR(11) 			DEFAULT NULL,                
	his_cli_internacion_hmi			INT(10) 	UNSIGNED 	DEFAULT NULL,           
	his_cli_ce_hmi					INT(10) 	UNSIGNED 	DEFAULT NULL,           
	his_cli_sihos					INT(10) 	UNSIGNED 	DEFAULT NULL,           
	his_cli_sistema_propietario		INT(10) 	UNSIGNED 	DEFAULT NULL,           
	nr0_hc_diagnose					INT(11) 				DEFAULT NULL,                    
	PRIMARY KEY (id_hc_persona),
	UNIQUE KEY idx_unique_id_efector_persona (id_efector,id_persona),
	UNIQUE KEY idx_unique_id_efector_his_cli_internacion_hmi (id_efector,his_cli_internacion_hmi),
	UNIQUE KEY idx_unique_id_efector_his_cli_ce_hmi (id_efector,his_cli_ce_hmi),
	UNIQUE KEY idx_unique_id_efector_his_cli_sihos (id_efector,his_cli_sihos),
	UNIQUE KEY idx_unique_id_sistema_propietario_his_cli_sistema_propietario (id_sistema_propietario,his_cli_sistema_propietario),
	UNIQUE KEY idx_unique_id_efector_nr0_hc_diagnose (id_efector,nr0_hc_diagnose),
	KEY fk_id_persona (id_persona)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;




/* Tabla de personas */
CREATE TABLE personas (
  id_persona						INT(10) 	UNSIGNED    			NOT NULL AUTO_INCREMENT,
  id_localidad						INT(10) 	UNSIGNED    			NULL 		COMMENT 'id_localidad de tabla localidades',
  tipo_doc							CHAR(3)		 		      			NOT NULL	COMMENT 'Se unifico a los tipo del HMI1 en formato texto: DNI, LC, LE, CI, OTR, DNR',
  nro_doc							INT(10) 	UNSIGNED    			NOT NULL	COMMENT 'Numero de documento en formato numerico',
  apellido							VARCHAR(255) 		     			NOT NULL,
  nombre							VARCHAR(255) 		     			NOT NULL,
  sexo								CHAR(1) 			        		NOT NULL	COMMENT 'F, M o I',
  dom_calle							VARCHAR(255) 		     			NULL		COMMENT 'Nombre de la calle o calle y numero en los casos donde no se pueda separar',
  dom_nro							VARCHAR(20) 		      			NULL,
  dom_dpto							CHAR(3) 			        		NULL,
  dom_piso							VARCHAR(5) 			      			NULL,
  dom_mza_monobloc					VARCHAR(40) 		      			NULL,
  telefono_dom						VARCHAR(30) 		      			NULL		COMMENT 'Telefono del domicilio o el unico que se obtenga',
  telefono_cel						VARCHAR(30) 		      			NULL		COMMENT 'Telefono celular en caso de obtenerlo',
  barrio							VARCHAR(255) 		     			NULL,
  localidad							VARCHAR(255) 		     			NULL		COMMENT 'Descripcion de la localidad obtenida. Si se pudo identificar id_localidad, es la descripcion correspondiente a dicho id en la tabla localidades',
  departamento						VARCHAR(255) 		     			NULL		COMMENT 'Idem',
  provincia							VARCHAR(255) 		     			NULL		COMMENT 'Idem',
  pais								VARCHAR(255) 		     			NULL		COMMENT 'Idem',
  fecha_nac							DATE 				        		NULL,
  ocupacion							VARCHAR(255) 		     			NULL,
  tipo_doc_madre					CHAR(3)		 		      			NULL,
  nro_doc_madre						INT(10) 	UNSIGNED    			NULL,
  nivel_academico					VARCHAR(255) 		     			NULL,
  estado_civil						VARCHAR(25) 		      			NULL,
  situacion_laboral					VARCHAR(255) 		     			NULL,
  asociado							VARCHAR(50) 		      			NULL,
  fallecido							TINYINT(1) 			      			NOT NULL,
  fecha_ultima_cond					DATE 				        		NULL,
  id_origen_info					TINYINT(3) 	UNSIGNED 				NOT NULL,
  baja								TINYINT(1) 			      			NOT NULL,
  PRIMARY KEY (id_persona),
  UNIQUE KEY idx_unique_tipo_nro_doc (tipo_doc,nro_doc),
  KEY fk_id_localidad (id_localidad),
  KEY fk_id_origen_info (id_origen_info),
  KEY idx_nro_doc (nro_doc),
  KEY idx_apellido (apellido),
  KEY idx_nombre (nombre),
  KEY idx_fecha_nac (fecha_nac),
  KEY idx_fallecido (fallecido),
  KEY idx_fecha_ultima_cond (fecha_ultima_cond)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;




/* Tabla de personas_hmi_docs_inconsistentes */
CREATE TABLE personas_hmi_docs_inconsistentes (
	id_persona_hmi_doc_inconsistente	INT(10) 	UNSIGNED    			NOT NULL AUTO_INCREMENT,
	id_efector							INTEGER		UNSIGNED				NOT NULL	COMMENT 'id del efector donde se obtiene la inconsistencia de documento',	
	his_cli_internacion_hmi				INT(10) 	UNSIGNED 				NULL		COMMENT 'Historia clinica de internacion HMI',           
	his_cli_ce_hmi						INT(10) 	UNSIGNED 				NULL		COMMENT 'Historia clinica de consultorio externo',
	id_localidad						INT(10) 	UNSIGNED    			NULL 		COMMENT 'id_localidad de tabla localidades',
	tipo_doc							CHAR(3)		 		      			NOT NULL	COMMENT 'Se unifico a los tipo del HMI1 en formato texto: DNI, LC, LE, CI, OTR, DNR',
	nro_doc								INT(10) 	UNSIGNED    			NOT NULL	COMMENT 'Numero de documento en formato numerico',
	apellido							VARCHAR(255) 		     			NOT NULL,
	nombre								VARCHAR(255) 		     			NOT NULL,
	sexo								CHAR(1) 			        		NOT NULL	COMMENT 'F, M o I',
	dom_calle							VARCHAR(255) 		     			NULL		COMMENT 'Nombre de la calle o calle y numero en los casos donde no se pueda separar',
	dom_nro								VARCHAR(20) 		      			NULL,
	dom_dpto							CHAR(3) 			        		NULL,
	dom_piso							VARCHAR(5) 			      			NULL,
	dom_mza_monobloc					VARCHAR(40) 		      			NULL,
	telefono_dom						VARCHAR(30) 		      			NULL		COMMENT 'Telefono del domicilio o el unico que se obtenga',
	telefono_cel						VARCHAR(30) 		      			NULL		COMMENT 'Telefono celular en caso de obtenerlo',
	barrio								VARCHAR(255) 		     			NULL,
	localidad							VARCHAR(255) 		     			NULL		COMMENT 'Descripcion de la localidad obtenida. Si se pudo identificar id_localidad, es la descripcion correspondiente a dicho id en la tabla localidades',
	departamento						VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	provincia							VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	pais								VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	fecha_nac							DATE 				        		NULL,
	ocupacion							VARCHAR(255) 		     			NULL,
	tipo_doc_madre						CHAR(3)		 		      			NULL,
	nro_doc_madre						INT(10) 	UNSIGNED    			NULL,
	nivel_academico						VARCHAR(255) 		     			NULL,
	estado_civil						VARCHAR(25) 		      			NULL,
	situacion_laboral					VARCHAR(255) 		     			NULL,
	asociado							VARCHAR(50) 		      			NULL,
	fallecido							TINYINT(1) 			      			NOT NULL,
	fecha_ultima_cond					DATE 				        		NULL,
	id_origen_info						TINYINT(3) 	UNSIGNED 				NOT NULL,
	baja								TINYINT(1) 			      			NOT NULL,
	PRIMARY KEY (id_persona_hmi_doc_inconsistente),
	UNIQUE KEY idx_unique_tipo_nro_doc (id_efector,tipo_doc,nro_doc),
	KEY fk_id_localidad (id_localidad),
	KEY fk_id_origen_info (id_origen_info),
	KEY idx_nro_doc (nro_doc),
	KEY idx_apellido (apellido),
	KEY idx_nombre (nombre),
	KEY idx_fecha_nac (fecha_nac),
	KEY idx_fallecido (fallecido),
	KEY idx_fecha_ultima_cond (fecha_ultima_cond)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



/* Tabla de personas_sihos_docs_inconsistentes */
CREATE TABLE personas_sihos_docs_inconsistentes (
	id_persona_sihos_doc_inconsistente	INT(10) 	UNSIGNED    			NOT NULL AUTO_INCREMENT,
	id_efector							INTEGER		UNSIGNED				NOT NULL	COMMENT 'id del efector donde se obtiene la inconsistencia de documento',	
	ihegr_nrohiscli						VARCHAR(9)							NULL		COMMENT 'Historia clinica del SiHos',
	id_localidad						INT(10) 	UNSIGNED    			NULL 		COMMENT 'id_localidad de tabla localidades',
	tipo_doc							CHAR(3)		 		      			NOT NULL	COMMENT 'Se unifico a los tipo del HMI1 en formato texto: DNI, LC, LE, CI, OTR, DNR',
	nro_doc								INT(10) 	UNSIGNED    			NOT NULL	COMMENT 'Numero de documento en formato numerico',
	apellido							VARCHAR(255) 		     			NOT NULL,
	nombre								VARCHAR(255) 		     			NOT NULL,
	sexo								CHAR(1) 			        		NOT NULL	COMMENT 'F, M o I',
	dom_calle							VARCHAR(255) 		     			NULL		COMMENT 'Nombre de la calle o calle y numero en los casos donde no se pueda separar',
	dom_nro								VARCHAR(20) 		      			NULL,
	dom_dpto							CHAR(3) 			        		NULL,
	dom_piso							VARCHAR(5) 			      			NULL,
	dom_mza_monobloc					VARCHAR(40) 		      			NULL,
	telefono_dom						VARCHAR(30) 		      			NULL		COMMENT 'Telefono del domicilio o el unico que se obtenga',
	telefono_cel						VARCHAR(30) 		      			NULL		COMMENT 'Telefono celular en caso de obtenerlo',
	barrio								VARCHAR(255) 		     			NULL,
	localidad							VARCHAR(255) 		     			NULL		COMMENT 'Descripcion de la localidad obtenida. Si se pudo identificar id_localidad, es la descripcion correspondiente a dicho id en la tabla localidades',
	departamento						VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	provincia							VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	pais								VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	fecha_nac							DATE 				        		NULL,
	ocupacion							VARCHAR(255) 		     			NULL,
	tipo_doc_madre						CHAR(3)		 		      			NULL,
	nro_doc_madre						INT(10) 	UNSIGNED    			NULL,
	nivel_academico						VARCHAR(255) 		     			NULL,
	estado_civil						VARCHAR(25) 		      			NULL,
	situacion_laboral					VARCHAR(255) 		     			NULL,
	asociado							VARCHAR(50) 		      			NULL,
	fallecido							TINYINT(1) 			      			NOT NULL,
	fecha_ultima_cond					DATE 				        		NULL,
	id_origen_info						TINYINT(3) 	UNSIGNED 				NOT NULL,
	baja								TINYINT(1) 			      			NOT NULL,
	PRIMARY KEY (id_persona_sihos_doc_inconsistente),
	UNIQUE KEY idx_unique_tipo_nro_doc (id_efector,tipo_doc,nro_doc),
	KEY fk_id_localidad (id_localidad),
	KEY fk_id_origen_info (id_origen_info),
	KEY idx_nro_doc (nro_doc),
	KEY idx_apellido (apellido),
	KEY idx_nombre (nombre),
	KEY idx_fecha_nac (fecha_nac),
	KEY idx_fallecido (fallecido),
	KEY idx_fecha_ultima_cond (fecha_ultima_cond)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;




/* Tabla de personas_diagnose_docs_inconsistentes */
CREATE TABLE personas_diagnose_docs_inconsistentes (
	id_persona_diagnose_doc_inconsistente	INTEGER 	UNSIGNED    			NOT NULL AUTO_INCREMENT,
	id_efector								INTEGER		UNSIGNED				NOT NULL	COMMENT 'id del efector donde se obtiene la inconsistencia de documento',	
	nr0_hc_diagnose							INTEGER 							NULL		COMMENT 'Numero de historia clinica',                    
	id_localidad							INTEGER 	UNSIGNED    			NULL 		COMMENT 'id_localidad de tabla localidades',
	tipo_doc								CHAR(3)		 		      			NOT NULL	COMMENT 'Se unifico a los tipo del HMI1 en formato texto: DNI, LC, LE, CI, OTR, DNR',
	nro_doc									INTEGER 	UNSIGNED    			NOT NULL	COMMENT 'Numero de documento en formato numerico',
	apellido								VARCHAR(255) 		     			NOT NULL,
	nombre									VARCHAR(255) 		     			NOT NULL,
	sexo									CHAR(1) 			        		NOT NULL	COMMENT 'F, M o I',
	dom_calle								VARCHAR(255) 		     			NULL		COMMENT 'Nombre de la calle o calle y numero en los casos donde no se pueda separar',
	dom_nro									VARCHAR(20) 		      			NULL,
	dom_dpto								CHAR(3) 			        		NULL,
	dom_piso								VARCHAR(5) 			      			NULL,
	dom_mza_monobloc						VARCHAR(40) 		      			NULL,
	telefono_dom							VARCHAR(30) 		      			NULL		COMMENT 'Telefono del domicilio o el unico que se obtenga',
	telefono_cel							VARCHAR(30) 		      			NULL		COMMENT 'Telefono celular en caso de obtenerlo',
	barrio									VARCHAR(255) 		     			NULL,
	localidad								VARCHAR(255) 		     			NULL		COMMENT 'Descripcion de la localidad obtenida. Si se pudo identificar id_localidad, es la descripcion correspondiente a dicho id en la tabla localidades',
	departamento							VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	provincia								VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	pais									VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	fecha_nac								DATE 				        		NULL,
	ocupacion								VARCHAR(255) 		     			NULL,
	tipo_doc_madre							CHAR(3)		 		      			NULL,
	nro_doc_madre							INTEGER 	UNSIGNED    			NULL,
	nivel_academico							VARCHAR(255) 		     			NULL,
	estado_civil							VARCHAR(25) 		      			NULL,
	situacion_laboral						VARCHAR(255) 		     			NULL,
	asociado								VARCHAR(50) 		      			NULL,
	fallecido								TINYINT(1) 			      			NOT NULL,
	fecha_ultima_cond						DATE 				        		NULL,
	id_origen_info							TINYINT(3) 	UNSIGNED 				NOT NULL,
	baja									TINYINT(1) 			      			NOT NULL,
	PRIMARY KEY (id_persona_diagnose_doc_inconsistente),
	UNIQUE KEY idx_unique_tipo_nro_doc (id_efector,tipo_doc,nro_doc),
	KEY fk_id_localidad (id_localidad),
	KEY fk_id_origen_info (id_origen_info),
	KEY idx_nro_doc (nro_doc),
	KEY idx_apellido (apellido),
	KEY idx_nombre (nombre),
	KEY idx_fecha_nac (fecha_nac),
	KEY idx_fallecido (fallecido),
	KEY idx_fecha_ultima_cond (fecha_ultima_cond)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;




/* Tabla de personas_sicap_docs_inconsistentes */
CREATE TABLE personas_sicap_docs_inconsistentes (
	id_persona_sicap_doc_inconsistente		INTEGER 	UNSIGNED    			NOT NULL AUTO_INCREMENT,
	id_efector								INTEGER		UNSIGNED				NOT NULL	COMMENT 'id del efector donde se obtiene la inconsistencia de documento',	
	numero_paciente_sicap					INT(10) 	UNSIGNED 				NULL,           
	numero_grupo_familiar_sicap				INT(10) 	UNSIGNED 				NULL,           
	historia_familiar_sicap					VARCHAR(11) 						NULL,                
	historia_personal_sicap					VARCHAR(11) 						NULL,							
	id_localidad							INTEGER 	UNSIGNED    			NULL 		COMMENT 'id_localidad de tabla localidades',
	tipo_doc								CHAR(3)		 		      			NOT NULL	COMMENT 'Se unifico a los tipo del HMI1 en formato texto: DNI, LC, LE, CI, OTR, DNR',
	nro_doc									INTEGER 	UNSIGNED    			NOT NULL	COMMENT 'Numero de documento en formato numerico',
	apellido								VARCHAR(255) 		     			NOT NULL,
	nombre									VARCHAR(255) 		     			NOT NULL,
	sexo									CHAR(1) 			        		NOT NULL	COMMENT 'F, M o I',
	dom_calle								VARCHAR(255) 		     			NULL		COMMENT 'Nombre de la calle o calle y numero en los casos donde no se pueda separar',
	dom_nro									VARCHAR(20) 		      			NULL,
	dom_dpto								CHAR(3) 			        		NULL,
	dom_piso								VARCHAR(5) 			      			NULL,
	dom_mza_monobloc						VARCHAR(40) 		      			NULL,
	telefono_dom							VARCHAR(30) 		      			NULL		COMMENT 'Telefono del domicilio o el unico que se obtenga',
	telefono_cel							VARCHAR(30) 		      			NULL		COMMENT 'Telefono celular en caso de obtenerlo',
	barrio									VARCHAR(255) 		     			NULL,
	localidad								VARCHAR(255) 		     			NULL		COMMENT 'Descripcion de la localidad obtenida. Si se pudo identificar id_localidad, es la descripcion correspondiente a dicho id en la tabla localidades',
	departamento							VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	provincia								VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	pais									VARCHAR(255) 		     			NULL		COMMENT 'Idem',
	fecha_nac								DATE 				        		NULL,
	ocupacion								VARCHAR(255) 		     			NULL,
	tipo_doc_madre							CHAR(3)		 		      			NULL,
	nro_doc_madre							INTEGER 	UNSIGNED    			NULL,
	nivel_academico							VARCHAR(255) 		     			NULL,
	estado_civil							VARCHAR(25) 		      			NULL,
	situacion_laboral						VARCHAR(255) 		     			NULL,
	asociado								VARCHAR(50) 		      			NULL,
	fallecido								TINYINT(1) 			      			NOT NULL,
	fecha_ultima_cond						DATE 				        		NULL,
	id_origen_info							TINYINT(3) 	UNSIGNED 				NOT NULL,
	baja									TINYINT(1) 			      			NOT NULL,
	PRIMARY KEY (id_persona_sicap_doc_inconsistente),
	UNIQUE KEY idx_unique_tipo_nro_doc (id_efector,tipo_doc,nro_doc),
	KEY fk_id_localidad (id_localidad),
	KEY fk_id_origen_info (id_origen_info),
	KEY idx_nro_doc (nro_doc),
	KEY idx_apellido (apellido),
	KEY idx_nombre (nombre),
	KEY idx_fecha_nac (fecha_nac),
	KEY idx_fallecido (fallecido),
	KEY idx_fecha_ultima_cond (fecha_ultima_cond)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;




/* Tabla de diferencias del HMI */
CREATE TABLE IF NOT EXISTS hc_personas_hmi_diferentes (
	id_hc_persona				INTEGER		UNSIGNED 	NOT NULL COMMENT 'id de historia clinica en cuestion',
	id_efector					INTEGER 	UNSIGNED 	NOT NULL COMMENT 'id del efector de donde es la historia clinica',
	id_persona_anterior 		INTEGER		UNSIGNED 	NOT NULL COMMENT 'id de persona anterior',
	tipo_doc_anterior			CHAR(3) 				NOT NULL COMMENT 'tipo y nro de documento anterior',
	nro_doc_anterior			INTEGER 	UNSIGNED 	NOT NULL,
	apellido_anterior			VARCHAR(255)			NOT NULL,
	nombre_anterior				VARCHAR(255)			NOT NULL,
	fecha_nac_anterior			DATE					NULL,
	id_persona_nuevo			INTEGER		UNSIGNED	NULL,
	tipo_doc_nuevo 				CHAR(3) 				NOT NULL COMMENT 'tipo y nro de documento nuevo',
	nro_doc_nuevo 				INTEGER 	UNSIGNED 	NOT NULL,
	apellido_nuevo				VARCHAR(255)			NOT NULL,
	nombre_nuevo				VARCHAR(255)			NOT NULL,
	fecha_nac_nuevo				DATE					NULL,
	his_cli_internacion_hmi 	INTEGER 	UNSIGNED 	NULL COMMENT 'Historia clinica en cuestion',
	his_cli_ce_hmi 				INTEGER 	UNSIGNED 	NULL,
	PRIMARY KEY pk_id_hc_persona (id_hc_persona),
	FOREIGN KEY fk_id_hc_persona (id_hc_persona)
	    REFERENCES hc_personas(id_hc_persona)
	      ON DELETE RESTRICT
	      ON UPDATE RESTRICT,
	FOREIGN KEY fk_id_persona_anterior (id_persona_anterior)
	    REFERENCES personas(id_persona)
	      ON DELETE RESTRICT
	      ON UPDATE RESTRICT,
	FOREIGN KEY fk_id_hc_persona (id_hc_persona)
	    REFERENCES hc_personas(id_hc_persona)
	      ON DELETE RESTRICT
	      ON UPDATE RESTRICT,
	FOREIGN KEY fk_id_efector (id_efector)
	    REFERENCES efectores(id_efector)
	      ON DELETE RESTRICT
	      ON UPDATE RESTRICT,
	UNIQUE INDEX idx_id_efector_his_cli_internacion_hmi (id_efector,his_cli_internacion_hmi),
	UNIQUE INDEX idx_id_efector_his_cli_ce_hmi (id_efector,his_cli_ce_hmi)
) ENGINE=MyISAM;




/* tabla de diferencias del diagnose */
CREATE TABLE IF NOT EXISTS hc_personas_diagnose_diferentes (
	id_hc_persona				INTEGER(10) UNSIGNED 	NOT NULL COMMENT 'id de historia clinica en cuestion',
	id_efector					INTEGER 	UNSIGNED 	NOT NULL COMMENT 'id del efector de donde es la historia clinica',
	id_persona_anterior 		INTEGER(10) UNSIGNED 	NOT NULL COMMENT 'id de persona anterior',
	tipo_doc_anterior			CHAR(3) 				NOT NULL COMMENT 'tipo y nro de documento anterior',
	nro_doc_anterior			INTEGER 	UNSIGNED 	NOT NULL,
	apellido_anterior			VARCHAR(255)			NOT NULL,
	nombre_anterior				VARCHAR(255)			NOT NULL,
	fecha_nac_anterior			DATE					NULL,
	id_persona_nuevo			INTEGER		UNSIGNED	NULL,
	tipo_doc_nuevo 				CHAR(3) 				NOT NULL COMMENT 'tipo y nro de documento nuevo',
	nro_doc_nuevo 				INTEGER 	UNSIGNED 	NOT NULL,
	apellido_nuevo				VARCHAR(255)			NOT NULL,
	nombre_nuevo				VARCHAR(255)			NOT NULL,
	fecha_nac_nuevo				DATE					NULL,
	nr0_hc 						INTEGER 	UNSIGNED 	NOT NULL COMMENT 'Historia clinica en cuestion',
	PRIMARY KEY pk_id_hc_persona (id_hc_persona),
	FOREIGN KEY fk_id_hc_persona (id_hc_persona)
	    REFERENCES hc_personas(id_hc_persona)
	      ON DELETE RESTRICT
	      ON UPDATE RESTRICT,
	FOREIGN KEY fk_id_persona_anterior (id_persona_anterior)
	    REFERENCES personas(id_persona)
	      ON DELETE RESTRICT
	      ON UPDATE RESTRICT,
	FOREIGN KEY fk_id_hc_persona (id_hc_persona)
	    REFERENCES hc_personas(id_hc_persona)
	      ON DELETE RESTRICT
	      ON UPDATE RESTRICT,
	FOREIGN KEY fk_id_efector (id_efector)
	    REFERENCES efectores(id_efector)
	      ON DELETE RESTRICT
	      ON UPDATE RESTRICT,
	UNIQUE INDEX idx_id_efector_nr0_hc (id_efector,nr0_hc)
) ENGINE=MyISAM;