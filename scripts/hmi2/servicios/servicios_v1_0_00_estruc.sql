SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `servicios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `servicios` ;

CREATE  TABLE IF NOT EXISTS `servicios` (
  `id_servicio` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id autoincremental' ,
  `cod_servicio` CHAR(3) NOT NULL COMMENT 'codigo nuclear de servicios de nacion vigente desde 2008' ,
  `nom_servicio` VARCHAR(255) NOT NULL COMMENT 'nombre o descripcion del servicio' ,
  `nom_red_servicio` VARCHAR(30) NOT NULL ,
  `diagn_especiales` CHAR(1) NULL COMMENT 'I=diagnostico por imagenes' ,
  `medico` TINYINT NOT NULL COMMENT '0=no tiene definicion como medico o no medico; 1=medico; 2=no medico. NOTA: para servicios de internacion son todos 1' ,
  `tipo_servicio` TINYINT NOT NULL COMMENT '0=no definido; 1=final; 2=intermedio; 3=general' ,
  PRIMARY KEY (`id_servicio`) ,
  UNIQUE INDEX `idx_unique_cod_servicio` (`cod_servicio` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1, 
COMMENT = 'servicios que establecio nacion a partir del año 2008' ;


-- -----------------------------------------------------
-- Table `servicios_estadistica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `servicios_estadistica` ;

CREATE  TABLE IF NOT EXISTS `servicios_estadistica` (
  `id_servicio_estadistica` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id autoincremental' ,
  `id_servicio` INT UNSIGNED NOT NULL COMMENT 'id de tabla servicios' ,
  `cod_servicio` CHAR(3) NOT NULL COMMENT 'codigo nuclear de servicios de nacion vigente desde 2008' ,
  `sector` CHAR(1) NOT NULL COMMENT '1=varones; 2=mujeres; 3=mixto' ,
  `subsector` CHAR(1) NOT NULL COMMENT '4=internacion; 5=CE; 6=atencion domiciliaria;7=?internacion;8=?internacion' ,
  `nom_servicio_estadistica` VARCHAR(255) NOT NULL COMMENT 'descripcion del servicio obtenida del SIPES, tabla de servicios de 5 digitos' ,
  `nom_red_servicio_estadistica` VARCHAR(30) NOT NULL COMMENT 'idem anterios truncada con los primeros 30 caracteres' ,
  PRIMARY KEY (`id_servicio_estadistica`) ,
  UNIQUE INDEX `idx_unique_cod_servicio_sector_subsector` (`cod_servicio` ASC, `sector` ASC, `subsector` ASC) ,
  INDEX `idx_fk_servicios_estadistica_id_servicio` (`id_servicio` ASC) ,
  CONSTRAINT `fk_servicios_estadistica_id_servicio`
    FOREIGN KEY (`id_servicio` )
    REFERENCES `servicios` (`id_servicio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1, 
COMMENT = 'servicios que maneja estadistica de la provincia de santa fe' ;


-- -----------------------------------------------------
-- Table `efectores_servicios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `efectores_servicios` ;

CREATE  TABLE IF NOT EXISTS `efectores_servicios` (
  `id_efector_servicio` INT UNSIGNED NOT NULL COMMENT 'concatenacion del id_efector con el id_servicio_estadistica. los nuevos valores pueden obtenerse con la funcion get_id_efector_servicio' ,
  `id_efector` INT UNSIGNED NOT NULL COMMENT 'id del efector donde se ha habilitado el servicio de 5 digitos' ,
  `id_servicio_estadistica` INT UNSIGNED NOT NULL COMMENT 'id del servicio de 5 digitos de estadistica' ,
  `claveestd` CHAR(8) NOT NULL COMMENT 'codigo de establecimiento de 8 digitos obtenido del mod_sims' ,
  `cod_servicio` CHAR(3) NOT NULL COMMENT 'codigo nuclear de servicios de nacion vigente desde 2008' ,
  `sector` CHAR(1) NOT NULL COMMENT '1=varones; 2=mujeres; 3=mixto' ,
  `subsector` CHAR(1) NOT NULL COMMENT '4=internacion; 5=CE; 6=atencion domiciliaria' ,
  `nom_servicio_estadistica` VARCHAR(255) NOT NULL COMMENT 'Nombre del servicio de estadistica. Este campo se agrego para facilitar los select y reportes en programacion' ,
  `baja` TINYINT NOT NULL COMMENT 'estado actual del servicio en el efector: 0=alta; 1=baja' ,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'fecha de actualizacion del registro' ,
  PRIMARY KEY (`id_efector_servicio`) ,
  UNIQUE INDEX `idx_unique_claveestd_cod_servicio_sector_subsector` (`claveestd` ASC, `cod_servicio` ASC, `sector` ASC, `subsector` ASC) ,
  INDEX `idx_fk_efectores_servicios_id_efector` (`id_efector` ASC) ,
  INDEX `idx_fk_efectores_servicios_id_servicio_estadistica` (`id_servicio_estadistica` ASC) ,
  UNIQUE INDEX `idx_unique_id_efector_id_servicio_estadistica` (`id_efector` ASC, `id_servicio_estadistica` ASC) ,
  CONSTRAINT `fk_efectores_servicios_id_efector`
    FOREIGN KEY (`id_efector` )
    REFERENCES `efectores` (`id_efector` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_efectores_servicios_id_servicio_estadistica`
    FOREIGN KEY (`id_servicio_estadistica` )
    REFERENCES `servicios_estadistica` (`id_servicio_estadistica` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'servicios habilitados por estadistica en el efector' ;


-- -----------------------------------------------------
-- Table `salas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salas` ;

CREATE  TABLE IF NOT EXISTS `salas` (
  `id_sala` INT UNSIGNED NOT NULL COMMENT 'id_efector_servicio del area (area_id_efector_servicio)' ,
  `id_efector` INT UNSIGNED NOT NULL COMMENT 'id del efector de donde pertenece la sala' ,
  `nombre` VARCHAR(255) NOT NULL COMMENT 'nombre de la sala dentro del efector' ,
  `cant_camas` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'cantidad total de camas de la sala' ,
  `mover_camas` TINYINT(1) NOT NULL COMMENT 'bandera para el sistema que indica si se permite mover camas entre las habitaciones de la misma sala. por ejemplo: las incubadoras ' ,
  `area_id_efector_servicio` INT UNSIGNED NOT NULL COMMENT 'id del servicio del efector que es el referente de la sala (concepto de area del SIPES)' ,
  `area_cod_servicio` CHAR(3) NOT NULL COMMENT 'codigo de 3 digitos del area SIPES' ,
  `area_sector` CHAR(1) NOT NULL COMMENT 'campo sector correspondiente al area SIPES (1=varones; 2=mujeres; 3=mixto)' ,
  `area_subsector` CHAR(1) NOT NULL COMMENT 'subsector correspondiente al area SIPES (4=internacion; 5=CE; 6=atencion domiciliaria;7=?internacion;8=?internacion)' ,
  `baja` TINYINT NOT NULL COMMENT 'marca si la sala esta actualmente cerrada' ,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'fecha de modificacion del registro' ,
  PRIMARY KEY (`id_sala`) ,
  UNIQUE INDEX `idx_unique_id_efector_nombre` (`id_efector` ASC, `nombre` ASC) ,
  INDEX `idx_fk_salas_area_id_efector_servicio` (`area_id_efector_servicio` ASC) ,
  UNIQUE INDEX `idx_unique_id_efector_area_id_efector_servicio` (`id_efector` ASC, `area_id_efector_servicio` ASC) ,
  UNIQUE INDEX `idx_unique_id_efector_cod_servicio_sector_subsector` (`id_efector` ASC, `area_cod_servicio` ASC, `area_sector` ASC, `area_subsector` ASC) ,
  CONSTRAINT `fk_salas_id_efector`
    FOREIGN KEY (`id_efector` )
    REFERENCES `efectores` (`id_efector` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_salas_ref_id_efector_servicio`
    FOREIGN KEY (`area_id_efector_servicio` )
    REFERENCES `efectores_servicios` (`id_efector_servicio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1, 
COMMENT = 'sala logica o area en la config. edilicia del efector' ;


-- -----------------------------------------------------
-- Table `servicios_salas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `servicios_salas` ;

CREATE  TABLE IF NOT EXISTS `servicios_salas` (
  `id_servicio_sala` INT UNSIGNED NOT NULL COMMENT 'se genera como la concatenacion del id_sala + el id_servicio_estadistica' ,
  `id_efector` INT UNSIGNED NOT NULL COMMENT 'id_efector de donde es el servicio y la sala' ,
  `id_efector_servicio` INT UNSIGNED NOT NULL COMMENT 'id_efector_servicio del servicio del efector' ,
  `id_sala` INT UNSIGNED NOT NULL COMMENT 'id_sala de la sala del efector' ,
  `agudo_cronico` TINYINT NOT NULL COMMENT '1=agudo; 2=cronico' ,
  `tipo_servicio_sala` TINYINT NOT NULL COMMENT '0=comun; 1=hospital de dia; 2=atencion domiciliaria' ,
  `baja` TINYINT(1) NOT NULL COMMENT 'Se puede dar de baja a un servicio de una sala y mantener los pases de este' ,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'fecha de modificacion del registro' ,
  PRIMARY KEY (`id_servicio_sala`) ,
  UNIQUE INDEX `idx_unique_id_efector_servicio_id_sala` (`id_efector_servicio` ASC, `id_sala` ASC) ,
  INDEX `idx_fk_servicios_salas_id_sala` (`id_sala` ASC) ,
  INDEX `fk_servicios_salas_id_efector` (`id_efector` ASC) ,
  UNIQUE INDEX `idx_unique_id_efector_id_efector_servicio_id_sala` (`id_efector` ASC, `id_efector_servicio` ASC, `id_sala` ASC) ,
  CONSTRAINT `fk_servicios_salas_id_efector_servicio`
    FOREIGN KEY (`id_efector_servicio` )
    REFERENCES `efectores_servicios` (`id_efector_servicio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicios_salas_id_sala`
    FOREIGN KEY (`id_sala` )
    REFERENCES `salas` (`id_sala` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicios_salas_id_efector`
    FOREIGN KEY (`id_efector` )
    REFERENCES `efectores` (`id_efector` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1, 
COMMENT = 'servicios de 5 digitos habilitados en la sala' ;


-- -----------------------------------------------------
-- Table `subservicios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `subservicios` ;

CREATE  TABLE IF NOT EXISTS `subservicios` (
  `id_subservicio` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `id_efector_servicio` INT UNSIGNED NOT NULL ,
  `id_servicio` INT UNSIGNED NOT NULL ,
  `claveestd` CHAR(8) NOT NULL ,
  `cod_servicio` CHAR(3) NOT NULL ,
  `fecha_modificacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id_subservicio`) ,
  UNIQUE INDEX `idx_unique_id_efector_servicio_id_servicio` (`id_efector_servicio` ASC, `id_servicio` ASC) ,
  INDEX `idx_fk_subservicios_id_servicio` (`id_servicio` ASC) ,
  INDEX `idx_claveestd_cod_servicio` (`claveestd` ASC, `cod_servicio` ASC) ,
  CONSTRAINT `fk_subservicios_id_efector_servicio`
    FOREIGN KEY (`id_efector_servicio` )
    REFERENCES `efectores_servicios` (`id_efector_servicio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subservicios_id_servicio`
    FOREIGN KEY (`id_servicio` )
    REFERENCES `servicios` (`id_servicio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1, 
COMMENT = 'solo esta de ejemplo para una posible solucion (sin datos)' ;


-- -----------------------------------------------------
-- Table `efectores_servicios_hist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `efectores_servicios_hist` ;

CREATE  TABLE IF NOT EXISTS `efectores_servicios_hist` (
  `id_efector_servicio_hist` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `id_efector_servicio` INT UNSIGNED NOT NULL ,
  `fecha_apertura` DATE NOT NULL ,
  `fecha_cierre` DATE NULL ,
  `fecha_modificacion` TIMESTAMP NOT NULL COMMENT 'fecha de modificacion del registro' ,
  PRIMARY KEY (`id_efector_servicio_hist`) ,
  INDEX `idx_fk_id_efector_servicio` (`id_efector_servicio` ASC) ,
  UNIQUE INDEX `idx_unique_id_efector_servicio_fecha_apertura` (`id_efector_servicio` ASC, `fecha_apertura` ASC) ,
  CONSTRAINT `fk_efectores_servicios_hist_id_efector_servicio`
    FOREIGN KEY (`id_efector_servicio` )
    REFERENCES `efectores_servicios` (`id_efector_servicio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB, 
COMMENT = 'historico de apertura y cierre de servicios de los efectores' ;


-- -----------------------------------------------------
-- Table `servicios_salas_hist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `servicios_salas_hist` ;

CREATE  TABLE IF NOT EXISTS `servicios_salas_hist` (
  `id_servicio_sala_hist` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id autoincremental' ,
  `id_servicio_sala` INT UNSIGNED NOT NULL COMMENT 'un mismo servicio puede cerrarse o abrirse mas de una vez dentro de la misma sala' ,
  `fecha_apertura` DATE NOT NULL COMMENT 'fecha de apertura del servicio en la sala' ,
  `fecha_cierre` DATE NULL COMMENT 'fecha de cierre del servicio en la sala' ,
  `fecha_modificacion` TIMESTAMP NOT NULL COMMENT 'fecha de modificacion del registro' ,
  PRIMARY KEY (`id_servicio_sala_hist`) ,
  INDEX `idx_fk_servicios_salas_hist_id_servicio_sala` (`id_servicio_sala` ASC) ,
  UNIQUE INDEX `idx_unique_id_servicio_sala_fecha_apertura` (`id_servicio_sala` ASC, `fecha_apertura` ASC) ,
  CONSTRAINT `fk_servicios_salas_hist_id_servicio_sala`
    FOREIGN KEY (`id_servicio_sala` )
    REFERENCES `servicios_salas` (`id_servicio_sala` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB, 
COMMENT = 'historico de apertura y cierre de servicios en cada sala' ;


-- -----------------------------------------------------
-- Table `salas_hist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salas_hist` ;

CREATE  TABLE IF NOT EXISTS `salas_hist` (
  `id_sala_hist` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id autoincremental' ,
  `id_sala` INT UNSIGNED NOT NULL COMMENT 'una misma sala puede cerrarse o abrirse mas de una vez' ,
  `fecha_apertura` DATE NOT NULL COMMENT 'fecha aperura de la sala' ,
  `fecha_cierre` DATE NULL COMMENT 'fecha que dejo de funcionar la sala correspondiente a la fecha de apertura' ,
  `fecha_modificacion` TIMESTAMP NOT NULL ,
  PRIMARY KEY (`id_sala_hist`) ,
  INDEX `fk_salas_hist_id_sala` (`id_sala` ASC) ,
  UNIQUE INDEX `idx_unique_id_sala_fecha_apertura` (`id_sala` ASC, `fecha_apertura` ASC) ,
  CONSTRAINT `fk_salas_hist_id_sala1`
    FOREIGN KEY (`id_sala` )
    REFERENCES `salas` (`id_sala` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB, 
COMMENT = 'apertura y cierre de salas' ;


-- -----------------------------------------------------
-- function str_separa_ape
-- -----------------------------------------------------
DROP function IF EXISTS `str_separa_ape`;
DELIMITER $$
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `str_separa_ape`(ape_nom VARCHAR(255), tipo BOOLEAN) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
    COMMENT 'Devuelve el apellido de un STRING tipo apellido y nombre'
BEGIN
	DECLARE ape VARCHAR(255) DEFAULT '';
	DECLARE nom VARCHAR(255) DEFAULT '';
	DECLARE aux_ape_nom VARCHAR(255);
	DECLARE aux_char CHAR(1);
	DECLARE aux_i SMALLINT DEFAULT 1;
	DECLARE indice SMALLINT DEFAULT 1;
	
	
	IF ISNULL(ape_nom) THEN 
		RETURN NULL; 
	END IF;
	
	
	SET ape_nom = TRIM(REPLACE(ape_nom,","," "));
	
	
	SET ape_nom = TRIM(REPLACE(ape_nom,"."," "));
	
	
	SET ape_nom = TRIM(REPLACE(ape_nom,"*"," "));
	
	
	SET aux_ape_nom = UPPER(ape_nom);
	
	
	SET aux_i = 1;
	
	WHILE aux_i < LENGTH(aux_ape_nom) DO
	
		SET aux_char = SUBSTRING(aux_ape_nom,aux_i,1);
		
		IF aux_char=" " THEN
		
			IF SUBSTRING(aux_ape_nom,aux_i+1,1) = " " THEN
			
				SET aux_ape_nom = CONCAT(SUBSTRING(aux_ape_nom,
												1,
												aux_i),
									SUBSTRING(aux_ape_nom,
												aux_i+2,
												LENGTH(aux_ape_nom))
									);
				
			ELSE
				SET aux_i = aux_i + 1;
				
			END IF;
			
		ELSE
			SET aux_i = aux_i + 1;
		END IF;
	
	END WHILE;
	
	
	SET ape_nom = aux_ape_nom;
	
	
	SET ape = SUBSTRING_INDEX(aux_ape_nom," ",1);
	
	
	IF LENGTH(ape)<3 THEN
		SET indice=2;
	END IF;
	
	
	IF	ape = "VON" 	OR
		ape = "SANTA"	OR
		ape = "DAL" 	OR
		ape = "DEL" 	OR
		ape = "VAN" 	OR
		ape = "SAN" 	OR
		ape = "MAC" 	OR
		ape = "DOS" 	OR
		ape = "DAS" 
		THEN
		SET indice=2;
	END IF;
	
	
	SET ape = SUBSTRING_INDEX(aux_ape_nom," ",2);
		
	
	IF	ape = "DE LA" 		OR 
		ape = "VON DER" 	OR
		ape = "DE LOS" 		OR
		ape = "PONCE DE"
		THEN
		SET indice=3;
	END IF;
	
	
	SET ape = SUBSTRING_INDEX(ape_nom," ",indice);
	SET indice = LENGTH(ape)+2;
	SET nom = SUBSTRING(ape_nom,indice);
	
	
	IF tipo THEN
		RETURN TRIM(ape);
	ELSE
		RETURN TRIM(nom);
	END IF;
	
END
$$

$$

$$
DELIMITER ;


-- -----------------------------------------------------
-- function get_digito_control
-- -----------------------------------------------------
DROP function IF EXISTS `get_digito_control`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_digito_control`(fecha DATE, id_efector INTEGER, id_servicio_estadistica INTEGER, id_servicio INTEGER) RETURNS char(4) CHARSET latin1
    DETERMINISTIC
    COMMENT 'Genera el digito control compatibilidad SIPES. id_servicio_estadistica es el area en caso de las servicios salas'
BEGIN

	DECLARE digito1 INTEGER;
	DECLARE digito2 CHAR(1);
	DECLARE digito3 CHAR(1);
	DECLARE digito4 CHAR(1);
	
	DECLARE aux INTEGER;
	DECLARE sum_aux INTEGER;
	DECLARE len INTEGER;
	DECLARE i INTEGER;
	
	DECLARE claveestd CHAR(8);
	DECLARE cod_servicio_estadistica CHAR(5);
	DECLARE cod_servicio CHAR(3);
	
	
	
	
	SET aux = (SELECT DAY(fecha)*100 + MONTH(fecha)*1000 + YEAR(fecha));
	
	WHILE aux>9 DO
	
		SET len = LENGTH(aux);
		SET sum_aux = 0;
		SET i=1;
		
		WHILE i<=len DO
		
			SET sum_aux = sum_aux + ( SELECT SUBSTRING(aux,i,1) );
		
			SET i=i+1;
			
		END WHILE;
		
		SET aux = sum_aux;
		
	END WHILE;
	
	SET digito1 = aux;
	
	
	
		
	
	SET claveestd = 
		(SELECT 
			e.claveestd 
		FROM 
			efectores e 
		WHERE 
			e.id_efector = id_efector);
	
	IF claveestd IS NULL THEN
		
		RETURN NULL;
		
	END IF;	
	
	SET aux=claveestd;
	
	WHILE aux>9 DO
	
		SET len = LENGTH(aux);
		SET sum_aux = 0;
		SET i=1;
		
		WHILE i<=len DO
		
			SET sum_aux = sum_aux + ( SELECT SUBSTRING(aux,i,1) );
		
			SET i=i+1;
			
		END WHILE;
		
		SET aux = sum_aux;
		
	END WHILE;
	
	SET digito2 = CHAR(64+aux);
		
	
	
	
		
	
	SET cod_servicio_estadistica = 
		(SELECT 
			CONCAT(se.cod_servicio,se.sector,se.subsector) 
		FROM 
			servicios_estadistica se 
		WHERE 
			se.id_servicio_estadistica = id_servicio_estadistica);
	
	IF cod_servicio_estadistica IS NULL THEN
		
		RETURN NULL;
		
	END IF;
	
	SET aux=cod_servicio_estadistica;
	
	WHILE aux>9 DO
	
		SET len = LENGTH(aux);
		SET sum_aux = 0;
		SET i=1;
		
		WHILE i<=len DO
		
			SET sum_aux = sum_aux + ( SELECT SUBSTRING(aux,i,1) );
		
			SET i=i+1;
			
		END WHILE;
		
		SET aux = sum_aux;
		
	END WHILE;
	
	SET digito3 = CHAR(64+aux);
	
	
	
	
	
	
	SET cod_servicio = 
		(SELECT 
			s.cod_servicio
		FROM 
			servicios s 
		WHERE 
			s.id_servicio = id_servicio);
	
	IF cod_servicio IS NULL THEN
		
		RETURN NULL;
		
	END IF;
	
	SET aux=cod_servicio;
	
	WHILE aux>9 DO
	
		SET len = LENGTH(aux);
		SET sum_aux = 0;
		SET i=1;
		
		WHILE i<=len DO
		
			SET sum_aux = sum_aux + ( SELECT SUBSTRING(aux,i,1) );
		
			SET i=i+1;
			
		END WHILE;
		
		SET aux = sum_aux;
		
	END WHILE;
	
	SET digito4 = CHAR(64+aux);
		
	RETURN CONCAT(digito1,digito2,digito3,digito4);
	
	
END
$$

$$
DELIMITER ;


-- -----------------------------------------------------
-- function get_id_efector_servicio
-- -----------------------------------------------------
DROP function IF EXISTS `get_id_efector_servicio`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_id_efector_servicio`(id_efector INTEGER, id_servicio_estadistica INTEGER) RETURNS int(11)
    DETERMINISTIC
    COMMENT 'Calcula el id_efector_servicio'
BEGIN

	DECLARE aux_id INTEGER;
	
	
	SET aux_id = 
		(SELECT 
			COUNT(*) 
		FROM 
			efectores e 
		WHERE 
			e.id_efector = id_efector);
	
	IF aux_id=0 THEN
		
		RETURN -1;
		
	END IF;
	
	
	
	SET aux_id = 
	
		(SELECT 
			COUNT(*) 
		FROM 
			servicios_estadistica se 
		WHERE 
			se.id_servicio_estadistica = id_servicio_estadistica);
	
	IF aux_id=0 THEN
		
		RETURN -2;
		
	END IF;
	
	
	RETURN CONCAT(id_efector,LPAD(id_servicio_estadistica,3,'0'));

END

$$

$$
DELIMITER ;


-- -----------------------------------------------------
-- function get_id_servicio_sala
-- -----------------------------------------------------
DROP function IF EXISTS get_id_servicio_sala;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_id_servicio_sala`(id_sala INTEGER,id_servicio_estadistica INTEGER) RETURNS int(11)
    DETERMINISTIC
    COMMENT 'Calcula el id_efector_servicio'
BEGIN

	DECLARE aux_id INTEGER;
	
	
	SET aux_id = 
		(SELECT 
			COUNT(*) 
		FROM 
			salas s 
		WHERE 
			s.id_sala = id_sala);
	
	IF aux_id=0 THEN
		
		RETURN -1;
		
	END IF;
	
	
	
	SET aux_id = 
	
		(SELECT 
			COUNT(*) 
		FROM 
			servicios_estadistica se 
		WHERE 
			se.id_servicio_estadistica = id_servicio_estadistica);
	
	IF aux_id=0 THEN
		
		RETURN -2;
		
	END IF;
	
	
	RETURN CONCAT(id_sala,LPAD(id_servicio_estadistica,3,'0'));

END

$$

$$
DELIMITER ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
