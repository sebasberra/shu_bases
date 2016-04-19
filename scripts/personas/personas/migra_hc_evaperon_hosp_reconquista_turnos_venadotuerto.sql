/* migra los numeros de historias clinicas del evaperon, hospital reconquista y turnos de venado tuerto */
/* a la nueva estructura de tablas de la version de personas 1.80 */

/* crea la tabla sistemas propietarios */
CREATE TABLE IF NOT EXISTS sistemas_propietarios (
	id_sistema_propietario 		TINYINT 		UNSIGNED	NOT NULL,
	nom_corto 					VARCHAR(25) 				NOT NULL,
	nom_largo						VARCHAR(255)				NOT NULL,
	observacion					VARCHAR(255)				NULL,
	PRIMARY KEY(id_sistema_propietario),
	UNIQUE INDEX idx_unique_nom_corto(nom_corto),
	UNIQUE INDEX idx_unique_nom_largo(nom_largo)
)ENGINE=MyISAM;

INSERT IGNORE INTO sistemas_propietarios
		(id_sistema_propietario, nom_corto, nom_largo, observacion) 
	VALUES 
		(1,
		'TURNOS EVA PERON',
		'SISTEMA DE TURNOS DEL HOSPITAL EVA PERON',
		'Migración de los pacientes del sistema de turnos del hospital Eva Peron. Hecho en Version 1.72a 07/06/2010');
		
INSERT IGNORE INTO sistemas_propietarios
		(id_sistema_propietario, nom_corto, nom_largo, observacion) 
	VALUES 
		(2,
		'HOSP. RECONQUISTA',
		'SISTEMA DE TURNOS DEL HOSPITAL DE RECONQUISTA',
		'Migración de los pacientes del sistema del hospital de Reconquista. Información de junio 2010');
		
INSERT IGNORE INTO sistemas_propietarios
		(id_sistema_propietario, nom_corto, nom_largo, observacion) 
	VALUES 
		(3,
		'TURNOS VENADO TUERTO',
		'SISTEMA DE TURNOS DEL HOSPITAL DE VENADO TUERTO',
		'Migración de los pacientes del sistema del hospital de Venado Tuerto. Información de junio 2010');

/* agrega los campos necesarios a la tabla hc_personas */
ALTER TABLE hc_personas
	ADD COLUMN id_sistema_propietario TINYINT UNSIGNED NULL
	AFTER id_persona;
	
ALTER TABLE hc_personas
	ADD COLUMN his_cli_sistema_propietario INTEGER UNSIGNED NULL;

/* agrega el nuevo indice */
CREATE UNIQUE INDEX idx_unique_id_sistema_propietario_his_cli_sistema_propietario
	ON hc_personas (id_sistema_propietario,his_cli_sistema_propietario);

/* agrega la foreign key (solo es para crear indice porque son tablas MyISAM) */
ALTER TABLE hc_personas
	ADD FOREIGN KEY fk_id_sistema_propietario (id_sistema_propietario)
	    REFERENCES sistemas_propietarios(id_sistema_propietario)
	      ON DELETE RESTRICT
	      ON UPDATE RESTRICT;
      
/* migra las hc del evaperon */
UPDATE hc_personas
	SET		his_cli_sistema_propietario = his_cli_turnos_evaperon,
			id_sistema_propietario = 1
	WHERE	his_cli_turnos_evaperon IS NOT NULL;
	
/* migra las hc del hospital de reconquista */
UPDATE hc_personas
	SET		his_cli_sistema_propietario = his_cli_hosp_reconquista,
			id_sistema_propietario = 2
	WHERE	his_cli_hosp_reconquista IS NOT NULL;
	
/* migra las hc del sistema de turnos de venado tuerto */
UPDATE hc_personas
	SET		his_cli_sistema_propietario = nro_paciente_turnos_venadotuerto,
			id_sistema_propietario = 3
	WHERE	nro_paciente_turnos_venadotuerto IS NOT NULL;
	
/* Dropea los campos e indices migrados */
ALTER TABLE hc_personas
	DROP INDEX idx_unique_efector_his_cli_turnos_evaperon;
	
ALTER TABLE hc_personas
	DROP INDEX idx_unique_efector_his_cli_hosp_reconquista;
	
ALTER TABLE hc_personas
	DROP INDEX idx_unique_efector_nro_paciente_turnos_venadotuerto;
	
ALTER TABLE hc_personas
	DROP COLUMN his_cli_turnos_evaperon;
	
ALTER TABLE hc_personas
	DROP COLUMN his_cli_hosp_reconquista;
	
ALTER TABLE hc_personas
	DROP COLUMN nro_paciente_turnos_venadotuerto;