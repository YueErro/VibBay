CREATE DATABASE  IF NOT EXISTS `bd_vibbaygrupo02` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bd_vibbaygrupo02`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: bd_vibbaygrupo02
-- ------------------------------------------------------
-- Server version	5.7.17-log

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
-- Table structure for table `articulo`
--

DROP TABLE IF EXISTS `articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articulo` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(30) DEFAULT NULL,
  `imagen` text,
  `nombre` varchar(30) DEFAULT NULL,
  `categoria` varchar(14) DEFAULT NULL,
  `descripcion` varchar(485) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  `estado` varchar(7) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `email` (`email`),
  CONSTRAINT `articulo_ibfk_1` FOREIGN KEY (`email`) REFERENCES `usuario` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulo`
--

LOCK TABLES `articulo` WRITE;
/*!40000 ALTER TABLE `articulo` DISABLE KEYS */;
INSERT INTO `articulo` VALUES (1,'itziar@gmail.com','coche.jpg','Coche','Otros','Nuevo coche de alta gama.',14999.99,'En puja','2017-01-08 11:32:14'),(2,'yue.trbj@gmail.com','equipoDeMusica.jpg','Equipo de musica','Electronica','Equipo de musica de ultima generacion, alta gama y sin estrenar.',482.99,'Cerrado','2017-01-08 12:46:58'),(3,'yue.trbj@gmail.com','cartas.jpg','Cartas de poker','Otros','Baraja de cartas de poker. Perfecto para jugar con amigos. En perfecto estado.',1.5,'En puja','2017-01-08 12:47:41'),(4,'yue.trbj@gmail.com','vestido.jpg','Vestido tricolor','Moda y Belleza','Vestido de color azul y negro o blanco y dorado o azul y dorado.',19.95,'En puja','2017-01-08 12:48:32'),(6,'itziar@gmail.com','router.jpg','Router','Electronica','Router de alta gama. Wifi para toda la familia. Ideal contra vecinos chora-megas.',110,'En puja','2017-01-08 12:52:45'),(7,'itziar@gmail.com','perfume.jpg','Perfume','Moda y Belleza','Perfume de mujer. volumen 100ml.',56.78,'En puja','2017-01-08 12:53:56'),(8,'itziar@gmail.com','bici.jpg','Bicicleta de montana','Otros','Bicicleta de alta gama. Talla M. Nueva.',120.05,'En puja','2017-01-08 13:01:10'),(9,'mco@gmail.com','paraguas.jpg','Paraguas azul','Otros','wwww',7001,'En puja','2017-01-09 12:01:35');
/*!40000 ALTER TABLE `articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puja`
--

DROP TABLE IF EXISTS `puja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `puja` (
  `fecha` datetime NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `codarticulo` int(11) DEFAULT NULL,
  `cantidad` double DEFAULT NULL,
  PRIMARY KEY (`fecha`),
  UNIQUE KEY `fecha` (`fecha`),
  KEY `email` (`email`),
  KEY `codarticulo` (`codarticulo`),
  CONSTRAINT `puja_ibfk_1` FOREIGN KEY (`email`) REFERENCES `usuario` (`correo`),
  CONSTRAINT `puja_ibfk_2` FOREIGN KEY (`codarticulo`) REFERENCES `articulo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puja`
--

LOCK TABLES `puja` WRITE;
/*!40000 ALTER TABLE `puja` DISABLE KEYS */;
INSERT INTO `puja` VALUES ('2017-01-08 11:33:21','yue.trbj@gmail.com',1,15000),('2017-01-08 11:40:19','yue.trbj@gmail.com',1,15000.01),('2017-01-08 12:54:17','itziar@gmail.com',2,500),('2017-01-08 12:54:29','itziar@gmail.com',3,1.51),('2017-01-08 12:55:09','programador@gmail.com',3,1.52),('2017-01-08 12:55:32','programador@gmail.com',7,60),('2017-01-08 12:55:44','programador@gmail.com',1,15200),('2017-01-08 12:55:58','programador@gmail.com',2,501),('2017-01-08 13:05:49','itziar@gmail.com',3,3),('2017-01-08 13:09:54','yue.trbj@gmail.com',1,15250),('2017-01-09 12:25:37','mco@gmail.com',8,120.06),('2017-01-09 12:34:58','mco@gmail.com',8,120.07),('2017-01-09 12:38:06','yue.trbj@gmail.com',8,130);
/*!40000 ALTER TABLE `puja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `correo` varchar(30) NOT NULL,
  `nick` varchar(16) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `pass` varchar(16) NOT NULL,
  `fnac` date DEFAULT NULL,
  `genero` varchar(9) DEFAULT NULL,
  `tlf` int(9) NOT NULL,
  `foto` text,
  PRIMARY KEY (`correo`),
  UNIQUE KEY `correo` (`correo`),
  UNIQUE KEY `dni_UNIQUE` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('itziar@gmail.com','Itziar','11223344B','1234','1996-02-21','Femenino',945146035,'sfp.jpg'),('mco@gmail.com','MCO2','98765432M','1234','1990-01-18','Femenino',945123456,'Dora.jpg'),('programador@gmail.com','Programador12345','12345678Z','9876','1900-01-01','Masculino',945000000,'programador.jpg'),('yue.trbj@gmail.com','YueErro','11223355E','0000','1900-01-01','Femenino',945101010,'sfp.jpg');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-09 13:02:08
