-- MySQL dump 10.13  Distrib 5.1.34, for Win32 (ia32)
--
-- Host: localhost    Database: personasv1_2b
-- ------------------------------------------------------
-- Server version	5.1.34-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departamentos` (
  `id_dpto` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_prov` int(10) unsigned NOT NULL,
  `nom_dpto` varchar(50) NOT NULL,
  `cod_dpto` char(3) NOT NULL,
  PRIMARY KEY (`id_dpto`),
  KEY `departamentos_FKIndex1` (`id_prov`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `efectores`
--

DROP TABLE IF EXISTS `efectores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `efectores` (
  `id_efector` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_localidad` int(10) unsigned NOT NULL,
  `claveestd` varchar(8) DEFAULT NULL,
  `nom_efector` varchar(100) DEFAULT NULL,
  `nom_red_efector` varchar(50) DEFAULT NULL,
  `nodo` tinyint(4) unsigned DEFAULT NULL,
  `subnodo` smallint(6) unsigned DEFAULT NULL,
  `activo` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_efector`),
  UNIQUE KEY `idx_claveestd` (`claveestd`),
  KEY `efectores_FKIndex1` (`id_localidad`)
) ENGINE=MyISAM AUTO_INCREMENT=867 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hc_personas`
--

DROP TABLE IF EXISTS `hc_personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hc_personas` (
  `id_hc_persona` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_efector` int(10) unsigned DEFAULT NULL,
  `id_persona` int(10) unsigned NOT NULL,
  `numero_paciente_sicap` int(10) unsigned DEFAULT NULL,
  `numero_grupo_familiar_sicap` int(10) unsigned DEFAULT NULL,
  `historia_familiar_sicap` varchar(11) DEFAULT NULL,
  `historia_personal_sicap` varchar(11) DEFAULT NULL,
  `his_cli_internacion_hmi` int(10) unsigned DEFAULT NULL,
  `his_cli_ce_hmi` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_hc_persona`),
  UNIQUE KEY `idx_unique_efector_persona` (`id_efector`,`id_persona`),
  UNIQUE KEY `idx_unique_efector_his_cli_internacion_hmi` (`id_efector`,`his_cli_internacion_hmi`),
  UNIQUE KEY `idx_unique_efector_his_cli_ce_hmi` (`id_efector`,`his_cli_ce_hmi`),
  KEY `fk_id_persona` (`id_persona`)
) ENGINE=MyISAM AUTO_INCREMENT=780421 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `localidades`
--

DROP TABLE IF EXISTS `localidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `localidades` (
  `id_localidad` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_dpto` int(10) unsigned NOT NULL,
  `nom_loc` varchar(50) NOT NULL,
  `cod_loc` char(2) NOT NULL,
  `cod_postal` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id_localidad`),
  KEY `localidades_FKIndex1` (`id_dpto`)
) ENGINE=MyISAM AUTO_INCREMENT=570 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paises`
--

DROP TABLE IF EXISTS `paises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paises` (
  `id_pais` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom_pais` varchar(50) NOT NULL,
  `cod_pais` char(3) NOT NULL,
  PRIMARY KEY (`id_pais`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personas` (
  `id_persona` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_localidad` int(10) unsigned DEFAULT NULL,
  `tipo_doc` varchar(15) NOT NULL,
  `nro_doc` int(10) unsigned NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `sexo` char(1) NOT NULL,
  `dom_calle` varchar(255) DEFAULT NULL,
  `dom_nro` varchar(20) DEFAULT NULL,
  `dom_dpto` char(3) DEFAULT NULL,
  `dom_piso` varchar(5) DEFAULT NULL,
  `dom_mza_monobloc` varchar(40) DEFAULT NULL,
  `telefono_dom` varchar(30) DEFAULT NULL,
  `telefono_cel` varchar(30) DEFAULT NULL,
  `barrio` varchar(255) DEFAULT NULL,
  `localidad` varchar(255) DEFAULT NULL,
  `departamento` varchar(255) DEFAULT NULL,
  `provincia` varchar(255) DEFAULT NULL,
  `pais` varchar(255) DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `ocupacion` varchar(255) DEFAULT NULL,
  `tipo_doc_madre` varchar(15) DEFAULT NULL,
  `nro_doc_madre` varchar(255) DEFAULT NULL,
  `nivel_academico` varchar(255) DEFAULT NULL,
  `estado_civil` varchar(25) DEFAULT NULL,
  `situacion_laboral` varchar(255) DEFAULT NULL,
  `asociado` varchar(50) DEFAULT NULL,
  `fallecido` tinyint(1) NOT NULL,
  `fecha_ultima_cond` date DEFAULT NULL,
  `id_origen_info` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `idx_unique_tipo_nro_doc` (`tipo_doc`,`nro_doc`),
  KEY `fk_id_localidad` (`id_localidad`),
  KEY `fk_id_origen_info` (`id_origen_info`),
  KEY `idx_nro_doc` (`nro_doc`),
  KEY `idx_apellido` (`apellido`),
  KEY `idx_nombre` (`nombre`),
  KEY `idx_fallecido` (`fallecido`),
  KEY `idx_fecha_ultima_cond` (`fecha_ultima_cond`)
) ENGINE=MyISAM AUTO_INCREMENT=702652 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provincias`
--

DROP TABLE IF EXISTS `provincias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provincias` (
  `id_prov` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_pais` int(10) unsigned NOT NULL,
  `nom_prov` varchar(50) NOT NULL,
  `cod_prov` char(2) NOT NULL,
  PRIMARY KEY (`id_prov`),
  KEY `provincias_FKIndex1` (`id_pais`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servicios` (
  `id_servicio` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cod_servicio` char(3) NOT NULL,
  `nom_servicio` varchar(100) NOT NULL,
  PRIMARY KEY (`id_servicio`)
) ENGINE=MyISAM AUTO_INCREMENT=651 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'personasv1_2b'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-09-04 14:21:49
