-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: psalud_mod_sims
-- ------------------------------------------------------
-- Server version	5.5.41-0+wheezy1

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
-- Table structure for table `d_depenadm`
--

DROP TABLE IF EXISTS `d_depenadm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d_depenadm` (
  `coddepadm` char(1) NOT NULL DEFAULT '',
  `nomdepadm` varchar(50) NOT NULL DEFAULT '',
  `tipdepadm` char(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`coddepadm`),
  UNIQUE KEY `coddepadm` (`coddepadm`),
  UNIQUE KEY `coddepadm_2` (`coddepadm`),
  UNIQUE KEY `coddepadm_3` (`coddepadm`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='DETERMINA LA DEPENDENCIA ADMINISTRATIVA DEL EFECTOR';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `d_depenadm`
--

LOCK TABLES `d_depenadm` WRITE;
/*!40000 ALTER TABLE `d_depenadm` DISABLE KEYS */;
INSERT INTO `d_depenadm` VALUES ('1','Oficial Nacional','O'),('2','Fuerzas Armadas','O'),('3','Otros Nacionales','O'),('4','Oficial Provincial','O'),('5','Otros Provinciales','O'),('7','Comunidad','P'),('8','Obra Social','P'),('9','Privado','P'),('A','Universitario','P'),('B','Mutual','P'),('C','Privado Universitario','P'),('D','Laboral Universitario','P'),('6','Municipal','O'),('E','Provincia Comunidad','O');
/*!40000 ALTER TABLE `d_depenadm` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-21 17:49:47
