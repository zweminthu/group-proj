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
-- Table structure for table `noticeboard`
--

DROP TABLE IF EXISTS `noticeboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `noticeboard` (
  `notic_id` int(11) NOT NULL AUTO_INCREMENT,
  `topic` varchar(500) NOT NULL,
  `info` varchar(500) NOT NULL,
  `contents` varchar(5000) NOT NULL,
  `date` varchar(10) NOT NULL,
  PRIMARY KEY (`notic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `noticeboard`
--

LOCK TABLES `noticeboard` WRITE;
/*!40000 ALTER TABLE `noticeboard` DISABLE KEYS */;
INSERT INTO `noticeboard` VALUES (1,'Electricity Cut Off','Today','Electricity will be cut off today between 1PM to 4PM.','17/09/2019'),(2,'Electricity Bill Payment Methods','Online Banking Now Supported And Have More Features','Users can now pay via both KBZ pay or CB pay.','17/09/2019'),(4,'Myanmar Aims to Generate Up to 3,600MW','AUTHOR: EI THANDAR TUN  22 JAN 2018     ','The Ministry of Electricity and Energy is planning to boost electrical generation up to around 3,600 MW by 2021, Dr. Tun Naing, Deputy Minister for the Ministry of Electricity and Energy, told Pyithu Hluttaw (lower house) at its seventh meeting of second regular meetings.','17/09/2019'),(5,'Laos Sell Electricity to Myanmar ','AUTHOR: XINHUA','Laos and Myanmar are mulling an electricity agreement to empower Laos\' development needs, local daily Vientiane Times quoted a senior Lao official as saying on Tuesday. ','17/09/2019'),(6,'Myanmar Will Need An Extra 300MW  ','AUTHOR: TIN MG OO','Roughly an additional 300 megawatts (MW) worth of energy will be needed in the summer of 2017, U Pe Zin Tun, Union Minister of Electricity Power and Energy, said at the parliamentary meeting of Pyithu Hluttaw. ','17/09/2019'),(7,'Productive Use of Renewable Energy: Opportunity for Remote Areas in Myanmar ','AUTHOR: KATARINA UHEROVA HASBANI',' After the liberalization process which started in 2011, Myanmar remains beset with an energy and economic challenge. The economy is expected to grow by 8 percent this year but achieving and sustaining this growth will require a better supply of electricity across the country. ','17/09/2019'),(9,'Mandalay Power Plant to Use GE Technology to Cut Costs, Boost Efficiency ','AUTHOR :  JASON M MURPHY','The 225-megwatt Myingyan power plant in Mandalay will be operating with two 6F.03 gas turbines manufactured by General Electric that were recently ordered by Sembcorp Myingyan Power Company\n\n','17/09/2019'),(10,'Efforts Underway to Provide Universal Electricity Access in Myanmar','17/09/2019','Myanmar’s recently unveiled economic agenda is heavily dependent on overcoming electricity shortages in areas already on the national grid as well as achieving the country’s goal of implementing universal access to electricity by 2030.','17/09/2019');
/*!40000 ALTER TABLE `noticeboard` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-20 11:56:57
