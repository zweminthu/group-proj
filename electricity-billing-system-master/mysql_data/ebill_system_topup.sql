CREATE DATABASE  IF NOT EXISTS `ebill_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ebill_system`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: ebill_system
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `topup`
--

DROP TABLE IF EXISTS `topup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topup` (
  `topup_code` varchar(14) NOT NULL,
  `money` int(11) NOT NULL,
  `buy` enum('NO','YES') NOT NULL,
  PRIMARY KEY (`topup_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topup`
--

LOCK TABLES `topup` WRITE;
/*!40000 ALTER TABLE `topup` DISABLE KEYS */;
INSERT INTO `topup` VALUES ('92837456523400',500000,'YES'),('92837456523401',1000000,'YES'),('92837456523402',1000000,'YES'),('92837456523403',5000,'NO'),('92837456523404',1000000,'NO'),('92837456523405',1000000,'NO'),('92837456523406',1000000,'NO'),('92837456523407',100000,'NO'),('92837456523408',1000,'YES'),('92837456523409',500000,'NO'),('92837456523410',1000000,'NO'),('92837456523411',1000000,'NO'),('92837456523412',5000,'NO'),('92837456523413',1000,'NO'),('92837456523414',5000,'NO'),('92837456523415',1000000,'NO'),('92837456523416',1000,'NO'),('92837456523417',1000000,'NO'),('92837456523418',100000,'NO'),('92837456523419',1000,'NO'),('92837456523420',500000,'NO'),('92837456523421',1000,'NO'),('92837456523422',5000,'NO'),('92837456523423',50000,'NO'),('92837456523424',100000,'NO'),('92837456523425',10000,'NO'),('92837456523426',100000,'NO'),('92837456523427',50000,'NO'),('92837456523428',50000,'NO'),('92837456523429',1000,'NO'),('92837456523430',1000000,'NO'),('92837456523431',10000,'NO'),('92837456523432',1000,'NO'),('92837456523433',500000,'NO'),('92837456523434',1000,'NO'),('92837456523435',1000,'NO'),('92837456523436',10000,'NO'),('92837456523437',1000,'NO'),('92837456523438',10000,'NO'),('92837456523439',100000,'NO'),('92837456523440',5000,'NO'),('92837456523441',100000,'NO'),('92837456523442',100000,'NO'),('92837456523443',1000,'NO'),('92837456523444',50000,'NO'),('92837456523445',500000,'NO'),('92837456523446',1000000,'NO'),('92837456523447',50000,'NO'),('92837456523448',1000000,'NO'),('92837456523449',5000,'NO'),('92837456523450',50000,'NO'),('92837456523451',50000,'NO'),('92837456523452',100000,'NO'),('92837456523453',10000,'NO'),('92837456523454',50000,'NO'),('92837456523455',1000000,'NO'),('92837456523456',100000,'NO'),('92837456523457',1000,'NO'),('92837456523458',5000,'NO'),('92837456523459',1000,'NO'),('92837456523460',5000,'NO'),('92837456523461',500000,'NO'),('92837456523462',1000000,'NO'),('92837456523463',500000,'NO'),('92837456523464',500000,'NO'),('92837456523465',50000,'NO'),('92837456523466',100000,'NO'),('92837456523467',10000,'NO'),('92837456523468',10000,'NO'),('92837456523469',50000,'NO'),('92837456523470',500000,'NO'),('92837456523471',1000,'NO'),('92837456523472',50000,'NO'),('92837456523473',1000000,'NO'),('92837456523474',1000000,'NO'),('92837456523475',500000,'NO'),('92837456523476',10000,'NO'),('92837456523477',1000000,'NO'),('92837456523478',500000,'NO'),('92837456523479',10000,'NO'),('92837456523480',500000,'NO'),('92837456523481',5000,'NO'),('92837456523482',100000,'NO'),('92837456523483',50000,'NO'),('92837456523484',100000,'NO'),('92837456523485',100000,'NO'),('92837456523486',50000,'NO'),('92837456523487',100000,'NO'),('92837456523488',50000,'NO'),('92837456523489',10000,'NO'),('92837456523490',10000,'NO'),('92837456523491',1000,'NO'),('92837456523492',100000,'NO'),('92837456523493',500000,'NO'),('92837456523494',100000,'NO'),('92837456523495',100000,'NO'),('92837456523496',5000,'NO'),('92837456523497',10000,'NO'),('92837456523498',500000,'NO'),('92837456523499',50000,'NO');
/*!40000 ALTER TABLE `topup` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-20 11:56:56