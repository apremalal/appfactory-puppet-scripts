-- MySQL dump 10.13  Distrib 5.5.24, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: rss_mgt
-- ------------------------------------------------------
-- Server version       5.5.24-0ubuntu0.12.04.1

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
-- Table structure for table `RM_SERVER_INSTANCE`
--

DROP TABLE IF EXISTS `RM_SERVER_INSTANCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RM_SERVER_INSTANCE` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(128) NOT NULL,
  `SERVER_URL` varchar(1024) NOT NULL,
  `DBMS_TYPE` varchar(128) NOT NULL,
  `INSTANCE_TYPE` varchar(128) NOT NULL,
  `SERVER_CATEGORY` varchar(128) NOT NULL,
  `ADMIN_USERNAME` varchar(128) DEFAULT NULL,
  `ADMIN_PASSWORD` varchar(128) DEFAULT NULL,
  `TENANT_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME` (`NAME`,`TENANT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RM_SERVER_INSTANCE`
--

LOCK TABLES `RM_SERVER_INSTANCE` WRITE;
/*!40000 ALTER TABLE `RM_SERVER_INSTANCE` DISABLE KEYS */;
INSERT INTO `RM_SERVER_INSTANCE` VALUES (1,'Development_Relational_Storage_Server','jdbc:mysql://mysql.dev.appfactorypreview.wso2.com:3307','MYSQL','WSO2_RSS','LOCAL','root','root',-1234);
/*!40000 ALTER TABLE `RM_SERVER_INSTANCE` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-04-01 11:22:27
