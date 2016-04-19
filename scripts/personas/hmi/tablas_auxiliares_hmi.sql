DROP TABLE IF EXISTS asociado_hmi;
DROP TABLE IF EXISTS instruccion_hmi;
DROP TABLE IF EXISTS situacion_laboral_hmi;

CREATE TABLE asociado_hmi (
	id_asociado		CHAR(1) NOT NULL,
	desc_asociado	VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_asociado)
) TYPE=MyISAM;

INSERT INTO asociado_hmi VALUES ('1','obra social'),('2','plan de salud privado o laboral'),
	('3','plan o seguro publico'),('4','mas de uno'),('5','ninguno'),('6','se ignora');
	
CREATE TABLE instruccion_hmi (
	id_instruccion		CHAR(2) 	NOT NULL,
	desc_instruccion	VARCHAR(50)	NOT NULL,
	PRIMARY KEY (id_instruccion)
) TYPE=MyISAM;

INSERT INTO instruccion_hmi (id_instruccion,desc_instruccion) VALUES ('01','nunca asistio'),('02','primaria incompleta'),
	('03','primaria completa'),('04','secundario incompleto'),('05','secundario completo'),('06','universitario incompleto'),
	('07','universitario completo'),('11','egb.(1-2) incompleto'),('12','egb.(1-2) completo'),('13','egb.(3) incompleto'),
	('14','egb.(3) completo'),('15','polimodal incompleto'),('16','polimodal completo');

CREATE TABLE situacion_laboral_hmi (	  
	id_sit_lab		CHAR(1) NOT NULL,
	desc_sit_lab	VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_sit_lab)
) TYPE=MyISAM;

INSERT INTO situacion_laboral_hmi VALUES ('1','trabaja o esta de licencia'),('2','busca trabajo'),
	('3','no busca trabajo');