/* Limpieza de la base personas v 1.4b*/

/* elimina las personas que vengan del padron electoral con tipo_doc = "DNR" y el nro_doc 
		ya existe en la tabla personas */
DELETE p2 
	FROM personas p1 
		INNER JOIN personas p2
			ON	(	p1.nro_doc	= p2.nro_doc
			AND		p1.apellido = p2.apellido
			AND		p1.nombre	= p2.nombre
			AND		p2.tipo_doc = 'DNR'
			AND		p2.id_origen_info = 4 );

	
/* elimina documentos menores de 6 digitos que no sean "cedula de identidad" que sean del padron o del 
	sistema de turnos del cullen */
DELETE
	FROM personas
	WHERE	nro_doc<1000000
	AND		tipo_doc<>'CI'
	AND		(id_origen_info=3 OR id_origen_info=4) ;
	
	
/* elimina las personas que tengan mismo nro_doc, mismo apellido, nombre, pero distinto tipo_doc y 
	que sean del turnos del cullen o del padron electoral. El filtro se aplica entre registros que
	provengan del HMI o del SICAP contra los registros del turnos de cullen y del padron electoral */	
	
DELETE p2
	FROM personas p1 
			INNER JOIN personas p2
				ON	(	p1.nro_doc	= p2.nro_doc
				AND		p1.apellido = p2.apellido
				AND		p1.nombre	= p2.nombre
				AND		p1.tipo_doc = 'DNI'
				AND 	( p1.id_origen_info = 1 OR p1.id_origen_info = 2)
				AND		p2.tipo_doc<> 'DNI'
				AND		( p2.id_origen_info = 3 OR p2.id_origen_info = 4)
				);
		
/* elimina las personas que tengan mismo nro_doc, mismo apellido y nombre y distinto tipo_doc y sean
	del hmi de un lado y del sicap del otro, asegurando que no se pierda la historia clinica correspondiente.
	El criterio del registro que queda de la tabla "personas" es que sea del HMI y tipo_doc = 'DNI' y que tenga
	un tipo_doc<>'DNI' en el SICAP */
DROP TABLE IF EXISTS personas_duplicadas_hmi_sicap;

CREATE TABLE personas_duplicadas_hmi_sicap (
	queda_id_persona		INTEGER 		UNSIGNED	NOT NULL,
	queda_tipo_doc			CHAR(3)						NOT NULL,
	queda_nro_doc			INTEGER 					NOT NULL,
	queda_apellido			VARCHAR(255)				NOT NULL,
	queda_nombre			VARCHAR(255)				NOT NULL,
	queda_id_origen_info	TINYINT			UNSIGNED	NOT NULL,
	queda_id_hc_persona		INTEGER			UNSIGNED	NOT NULL,
	se_va_id_persona		INTEGER 		UNSIGNED	NOT NULL,
	se_va_tipo_doc			CHAR(3)						NOT NULL,
	se_va_nro_doc			INTEGER 					NOT NULL,
	se_va_apellido			VARCHAR(255)				NOT NULL,
	se_va_nombre			VARCHAR(255)				NOT NULL,
	se_va_id_origen_info	TINYINT			UNSIGNED	NOT NULL,
	se_va_id_hc_persona		INTEGER			UNSIGNED	NOT NULL
	);

INSERT INTO personas_duplicadas_hmi_sicap
		
	SELECT	p1.id_persona, p1.tipo_doc, p1.nro_doc, p1.apellido, p1.nombre, p1.id_origen_info,
		h1.id_hc_persona,
		p2.id_persona, p2.tipo_doc, p2.nro_doc, p2.apellido, p2.nombre, p2.id_origen_info,
		h2.id_hc_persona
			
		FROM
		(personas p1
			INNER JOIN
				hc_personas h1
					ON	p1.id_persona		= h1.id_persona
					AND	p1.tipo_doc			='DNI'
					AND	p1.id_origen_info	=1)
				
		INNER JOIN 
		
		(personas p2
			INNER JOIN 
				hc_personas h2
					ON 	p2.id_persona 		= h2.id_persona
					AND	p2.tipo_doc			<> 'DNI'
					AND	p2.id_origen_info 	= 2)
						
			ON		p1.nro_doc	= p2.nro_doc
			AND		p1.apellido = p2.apellido
			AND		p1.nombre	= p2.nombre;	

/* actualiza las historias clinicas */
UPDATE hc_personas hc, personas_duplicadas_hmi_sicap pd
	SET hc.id_persona = pd.queda_id_persona
	
	WHERE hc.id_persona = pd.se_va_id_persona;
	
/* borra de personas */	
DELETE p 
	FROM personas p, personas_duplicadas_hmi_sicap pd
	
	WHERE p.id_persona = pd.se_va_id_persona;

/* elimina la tabla auxiliar de duplicados de hmi sicap */
DROP TABLE personas_duplicadas_hmi_sicap;

/* limpia los registros que empiecen con nombre = "* ". Estos registros se dieron porque en el iturraspe
	se ha usado el asterisco para separar el apellido del nombre en el HMI */
UPDATE personas 
	SET nombre = TRIM(RIGHT(nombre,LENGTH(nombre)-2))
	WHERE LEFT(nombre,2)="* ";
			
/* optimize table */
OPTIMIZE TABLE personas,hc_personas;