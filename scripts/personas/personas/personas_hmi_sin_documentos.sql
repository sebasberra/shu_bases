DROP TABLE IF EXISTS personas;
DROP TABLE IF EXISTS hc_personas;
DROP TABLE IF EXISTS origen_info;
DROP TABLE IF EXISTS version;

CREATE TABLE version (
  version	VARCHAR(255) NOT NULL,
  fecha		DATE NOT NULL
)ENGINE=MyISAM;

INSERT INTO version VALUES ( 'Personas hmi (sin documentos) v 1.0b',CURDATE() );

CREATE TABLE origen_info (
  id_origen_info TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  origen_info VARCHAR(30) NOT NULL,
  PRIMARY KEY(id_origen_info)
)ENGINE=MyISAM;

INSERT INTO origen_info VALUES (0,'HMI sin documentos (iturraspe)');

CREATE TABLE personas (
  id_persona INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  id_localidad INTEGER(10) UNSIGNED NULL,
  tipo_doc VARCHAR(15) NOT NULL,
  nro_doc INTEGER UNSIGNED NOT NULL,
  apellido VARCHAR(255) NOT NULL,
  nombre VARCHAR(255) NOT NULL,
  sexo CHAR(1) NOT NULL,
  dom_calle VARCHAR(255) NULL,
  dom_nro VARCHAR(20) NULL,
  dom_dpto CHAR(3) NULL,
  dom_piso VARCHAR(5) NULL,
  dom_mza_monobloc VARCHAR(40) NULL,
  telefono_dom VARCHAR(30) NULL,
  telefono_cel VARCHAR(30) NULL,
  barrio VARCHAR(255) NULL,
  localidad VARCHAR(255) NULL,
  departamento VARCHAR(255) NULL,
  provincia VARCHAR(255) NULL,
  pais VARCHAR(255) NULL,
  fecha_nac DATE NULL,
  ocupacion VARCHAR(255) NULL,
  tipo_doc_madre VARCHAR(15) NULL,
  nro_doc_madre VARCHAR(255) NULL,
  nivel_academico VARCHAR(255) NULL,
  estado_civil VARCHAR(25) NULL,
  situacion_laboral VARCHAR(255) NULL,
  asociado VARCHAR(50) NULL,
  fallecido BOOLEAN NOT NULL,
  fecha_ultima_cond DATE NULL,
  id_origen_info TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY(id_persona),
  FOREIGN KEY fk_id_localidad (id_localidad)
    REFERENCES localidades(id_localidad)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT,
  FOREIGN KEY fk_id_origen_info (id_origen_info)
    REFERENCES origen_info(id_origen_info)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
) ENGINE=MyISAM;

/* crea un indice unico para tipo y nro de doc */
CREATE UNIQUE INDEX idx_unique_tipo_nro_doc ON personas (tipo_doc,nro_doc);
CREATE INDEX idx_nro_doc ON personas (nro_doc);
CREATE INDEX idx_apellido ON personas (apellido);
CREATE INDEX idx_nombre ON personas (nombre);
CREATE INDEX idx_fallecido ON personas (fallecido);
CREATE INDEX idx_fecha_ultima_cond ON personas (fecha_ultima_cond);

CREATE TABLE hc_personas (
  id_hc_persona INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  id_efector INTEGER(10) UNSIGNED NULL,
  id_persona INTEGER UNSIGNED NOT NULL,
  numero_paciente_sicap INTEGER UNSIGNED NULL,
  numero_grupo_familiar_sicap INTEGER UNSIGNED NULL,
  historia_familiar_sicap VARCHAR(11) NULL,
  historia_personal_sicap VARCHAR(11) NULL,
  his_cli_internacion_hmi INTEGER UNSIGNED NULL,
  his_cli_ce_hmi INTEGER UNSIGNED NULL,
  PRIMARY KEY(id_hc_persona),
  FOREIGN KEY fk_id_efector (id_efector)
    REFERENCES efectores(id_efector)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT,
  FOREIGN KEY fk_id_persona (id_persona)
    REFERENCES personas(id_persona)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
) ENGINE=MyISAM;

/* crea un indice único para persona efector */
CREATE UNIQUE INDEX idx_unique_efector_persona ON hc_personas (id_efector,id_persona);
CREATE UNIQUE INDEX idx_unique_efector_his_cli_internacion_hmi ON hc_personas (id_efector,his_cli_internacion_hmi);
CREATE UNIQUE INDEX idx_unique_efector_his_cli_ce_hmi ON hc_personas (id_efector,his_cli_ce_hmi);