-- phpMyAdmin SQL Dump
-- version 2.6.0-pl2
-- http://www.phpmyadmin.net
-- 
-- Servidor: localhost
-- Tiempo de generación: 11-05-2011 a las 06:26:13
-- Versión del servidor: 4.1.10
-- Versión de PHP: 4.3.10
-- 
-- Base de datos: `bs_mod_sims`
-- 

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `d_establecimiento`
-- 

CREATE TABLE `d_establecimiento` (
  `cbrest` varchar(8) default NULL,
  `jerarquia` char(1) NOT NULL default '0',
  `coddepest` char(3) NOT NULL default '',
  `codnroest` varchar(5) default NULL,
  `coddigest` char(1) default NULL,
  `nomest` varchar(80) default NULL,
  `nomredest` varchar(30) default NULL,
  `cabcoddepest` char(3) default NULL,
  `cabcodnroest` varchar(5) default NULL,
  `nodo` tinyint(4) NOT NULL default '0',
  `subnodo` smallint(6) NOT NULL default '0',
  `codzonest` char(2) default NULL,
  `codlocest` char(2) default NULL,
  `dcalest` varchar(40) default NULL,
  `dnroest` varchar(5) default NULL,
  `dcpest` varchar(4) default NULL,
  `telest` varchar(30) default NULL,
  `faxest` varchar(20) default NULL,
  `emailest` varchar(40) default NULL,
  `nivcomest` varchar(4) default NULL,
  `fechabest` datetime default NULL,
  `codprovest` char(2) default NULL,
  `codparbarest` char(3) default NULL,
  `regjurest` varchar(15) default NULL,
  `regimenjuridico` char(2) default NULL,
  `acadmest` varchar(15) default NULL,
  `fecadmest` datetime default NULL,
  `hpaest` smallint(6) default NULL,
  `tipogestion` varchar(40) NOT NULL default '',
  `hpainsest` varchar(10) default NULL,
  `camaguest` smallint(6) default NULL,
  `camcroest` smallint(6) default NULL,
  `fecactest` datetime default NULL,
  `marintest` smallint(1) default NULL,
  `depadmest` char(1) default NULL,
  `tipifest` char(2) default NULL,
  `directest` varchar(30) default NULL,
  `presidest` varchar(25) default NULL,
  `tesorest` varchar(25) default NULL,
  `secreest` varchar(25) default NULL,
  `repestest` varchar(25) default NULL,
  `repproest` varchar(25) default NULL,
  `repnopest` varchar(25) default NULL,
  `repcomest` varchar(25) default NULL,
  `repcooest` varchar(25) default NULL,
  `fecapeest` datetime default NULL,
  `feccieest` datetime default NULL,
  `marbasest` smallint(6) default NULL,
  `marindest` smallint(6) default NULL,
  `marurbest` smallint(6) default NULL,
  `marinfest` smallint(6) default NULL,
  `marenfest` smallint(6) default NULL,
  `rrhest` varchar(6) default NULL,
  `rendicest` varchar(6) default NULL,
  `sueldest` varchar(6) default NULL,
  `claveestd` varchar(8) NOT NULL default '',
  `clavesisa` varchar(14) default NULL,
  `agregacion` int(1) default NULL,
  `clavelocest` varchar(5) NOT NULL default '',
  `fechaoper` datetime NOT NULL default '0000-00-00 00:00:00',
  `essipes` char(1) NOT NULL default '',
  `usuario` varchar(20) default NULL,
  `id_establecimiento` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id_establecimiento`),
  UNIQUE KEY `ix_claveestd` (`claveestd`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1246 ;
