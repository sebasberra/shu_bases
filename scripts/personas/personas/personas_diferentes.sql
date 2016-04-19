DROP TABLE IF EXISTS hc_personas_hmi_diferentes;

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
	
	
DROP TABLE IF EXISTS hc_personas_diagnose_diferentes;
	
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
	
	
DROP TABLE IF EXISTS hc_personas_sicap_diferentes;
	
CREATE TABLE IF NOT EXISTS hc_personas_sicap_diferentes (
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
	numero_paciente_sicap		INTEGER 	UNSIGNED 	NOT NULL COMMENT 'Historia clinica en cuestion',
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
	UNIQUE INDEX numero_paciente_sicap (numero_paciente_sicap)
) ENGINE=MyISAM;