DROP TABLE IF EXISTS regimenes_juridicos;

REPLACE INTO versiones VALUES ("efectores","v 0.35a",NOW());

/* regimenes_juridicos */
CREATE TABLE IF NOT EXISTS regimenes_juridicos (
	id_regimen_juridico 	INTEGER 	UNSIGNED 	NOT NULL AUTO_INCREMENT,
	regjurest 				VARCHAR(15) 			NOT NULL,
	codigo 					CHAR(2) 				NOT NULL,
	PRIMARY KEY(id_regimen_juridico),
	UNIQUE INDEX idx_unique_codigo (codigo)
)
ENGINE=InnoDB;

INSERT IGNORE INTO regimenes_juridicos VALUES (0,'Dep. de SAMCo.','01');
INSERT IGNORE INTO regimenes_juridicos VALUES (0,'Descentralizado','02');
INSERT IGNORE INTO regimenes_juridicos VALUES (0,'Provincial','03');
INSERT IGNORE INTO regimenes_juridicos VALUES (0,'SAMCo.','04');   
INSERT IGNORE INTO regimenes_juridicos VALUES (0,'Municipal','05');      
INSERT IGNORE INTO regimenes_juridicos VALUES (0,'Comunal','06');    
INSERT IGNORE INTO regimenes_juridicos VALUES (0,'O.N.G.','07');      
INSERT IGNORE INTO regimenes_juridicos VALUES (0,'No definido','00');
		
	
	    
                                                                    