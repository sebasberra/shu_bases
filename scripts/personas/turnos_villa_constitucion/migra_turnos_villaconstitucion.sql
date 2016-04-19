/* nº de HC, apellido, nombre, documento, fecha de nacimiento, sexo, domicilio, localidad */

/* elimina la tabla */
DROP TABLE IF EXISTS pacientes_turnos_villaconstitucion;

/* carga los pacientes de villa constitucion */
CREATE TABLE IF NOT EXISTS pacientes_turnos_villaconstitucion(

	hc						INTEGER		UNSIGNED		NOT NULL,
	apellido				VARCHAR(255)				NOT NULL,
	nombre					VARCHAR(255)				NOT NULL,
	nro_doc					INTEGER		UNSIGNED		NOT NULL,
	fecha_nac				DATE						NOT NULL,
	sexo					CHAR(1)						NOT NULL,
	domicilio				VARCHAR(255)				NULL,
	localidad				VARCHAR(255)				NOT NULL,
	id_localidad			INTEGER						NULL,
	marca_borrado			BOOLEAN						NOT NULL 	DEFAULT FALSE,
PRIMARY KEY (hc)
)ENGINE=MyISAM;

/* carga los datos de los archivos de texto de datos generales de pacientes */
LOAD DATA LOCAL INFILE 'hcce-villa-const.txt'
	INTO TABLE pacientes_turnos_villaconstitucion
	FIELDS	TERMINATED BY '\t'
	LINES	TERMINATED BY '\r\n';
	
/* carga los id de localidad */
UPDATE
	pacientes_turnos_villaconstitucion pvc
SET
	pvc.id_localidad = (
					SELECT 
						l.id_localidad 
					FROM 
						localidades l 
					WHERE 
						l.nom_loc = pvc.localidad 
					AND id_dpto IS NOT NULL);
					
					
/* pone NULL a vacios */
UPDATE
	pacientes_turnos_villaconstitucion
SET
	domicilio = NULL
WHERE 
	domicilio = '';