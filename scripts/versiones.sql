DROP TABLE IF EXISTS versiones;

/* versiones */
CREATE TABLE versiones (
	base	VARCHAR(255) NOT NULL,	
	version VARCHAR(255) NOT NULL,
	fecha 	DATETIME NOT NULL,
	PRIMARY KEY (base)
);