DROP TABLE IF EXISTS niveles_complejidades;

REPLACE INTO versiones VALUES ("efectores","v 0.41a",NOW());

/* regimenes_juridicos */
CREATE TABLE IF NOT EXISTS niveles_complejidades (
	id_nivel_complejidad 	TINYINT 	UNSIGNED 	NOT NULL AUTO_INCREMENT,
	nivcomest 				VARCHAR(4)	 			NOT NULL,
	descripcion				VARCHAR(255)			NOT NULL,
	PRIMARY KEY(id_nivel_complejidad),
	UNIQUE INDEX idx_unique_nivcomest(nivcomest)
)
ENGINE=InnoDB;

INSERT INTO niveles_complejidades VALUES (0,'0','S/D');
INSERT INTO niveles_complejidades VALUES (0,'Esp.','Especializados');
INSERT INTO niveles_complejidades VALUES (0,'I','I');
INSERT INTO niveles_complejidades VALUES (0,'II','II');   
INSERT INTO niveles_complejidades VALUES (0,'III','III');      
INSERT INTO niveles_complejidades VALUES (0,'IV','IV');    
INSERT INTO niveles_complejidades VALUES (0,'IX','IX');      
INSERT INTO niveles_complejidades VALUES (0,'V','V');
INSERT INTO niveles_complejidades VALUES (0,'VI','VI');
INSERT INTO niveles_complejidades VALUES (0,'VIII','VIII');