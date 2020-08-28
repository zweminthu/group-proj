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
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `log` varchar(255) NOT NULL,
  `date` varchar(10) NOT NULL,
  `time` varchar(5) NOT NULL,
  `user_id` int(11) NOT NULL,
  `table_name` varchar(8) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (8,'Paid','13/09/2019','02:41',5,'customer'),(9,'Paid','13/09/2019','11:59',7,'customer'),(10,'Paid','13/09/2019','12:32',7,'customer'),(11,'Paid','13/09/2019','12:36',7,'customer'),(12,'Paid','13/09/2019','12:39',7,'customer'),(13,'Paid','13/09/2019','12:40',7,'customer'),(14,'Paid','13/09/2019','16:56',3,'customer'),(15,'Paid','13/09/2019','17:03',3,'customer'),(16,'Paid','16/09/2019','09:17',5,'customer'),(17,'Updated Password','16/09/2019','09:41',2,'admin'),(18,'Updated Password','16/09/2019','09:42',2,'admin'),(19,'Paid','16/09/2019','10:06',3,'customer'),(20,'Paid','16/09/2019','13:55',5,'customer'),(21,'Updated Password','16/09/2019','13:59',3,'customer'),(22,'Updated Password','16/09/2019','15:41',5,'customer'),(23,'Information Updated','17/09/2019','14:12',2,'admin'),(24,'Updated Password','18/09/2019','09:17',2,'admin'),(25,'Information Updated','18/09/2019','09:17',2,'admin'),(26,'Paid','18/09/2019','13:11',5,'customer'),(27,'Paid','18/09/2019','13:11',5,'customer'),(28,'Paid','18/09/2019','13:11',5,'customer'),(29,'Paid','18/09/2019','13:11',5,'customer'),(30,'Paid','18/09/2019','13:11',5,'customer'),(31,'Paid','18/09/2019','13:12',5,'customer'),(32,'Paid','18/09/2019','13:12',5,'customer'),(33,'Paid','18/09/2019','13:12',5,'customer'),(34,'Paid','18/09/2019','13:12',5,'customer'),(35,'Paid','18/09/2019','13:12',5,'customer'),(36,'Paid','18/09/2019','13:12',5,'customer'),(37,'Paid','18/09/2019','13:12',5,'customer'),(38,'Paid','18/09/2019','13:12',5,'customer'),(39,'Paid','18/09/2019','13:12',5,'customer'),(40,'Paid','18/09/2019','13:12',5,'customer'),(41,'Paid','18/09/2019','13:12',5,'customer'),(42,'Paid','18/09/2019','13:12',5,'customer'),(43,'Paid','18/09/2019','13:12',5,'customer'),(44,'Paid','18/09/2019','13:12',5,'customer'),(45,'Paid','18/09/2019','13:12',5,'customer'),(46,'Paid','18/09/2019','13:12',5,'customer'),(47,'Paid','18/09/2019','13:12',5,'customer'),(48,'Paid','18/09/2019','13:12',5,'customer'),(49,'Paid','18/09/2019','13:12',5,'customer'),(50,'Paid','18/09/2019','13:12',5,'customer'),(51,'Paid','18/09/2019','13:12',5,'customer'),(52,'Paid','18/09/2019','13:12',5,'customer'),(53,'Paid','18/09/2019','13:12',5,'customer'),(54,'Paid','18/09/2019','13:12',5,'customer'),(55,'Paid','18/09/2019','13:12',5,'customer'),(56,'Paid','18/09/2019','13:12',5,'customer'),(57,'Paid','18/09/2019','13:12',5,'customer'),(58,'Paid','18/09/2019','13:12',5,'customer'),(59,'Paid','18/09/2019','13:12',5,'customer'),(60,'Paid','18/09/2019','13:12',5,'customer'),(61,'Paid','18/09/2019','13:12',5,'customer'),(62,'Paid','18/09/2019','13:12',5,'customer'),(63,'Paid','18/09/2019','13:12',5,'customer'),(64,'Paid','18/09/2019','13:12',5,'customer'),(65,'Paid','18/09/2019','13:12',5,'customer'),(66,'Paid','18/09/2019','13:12',5,'customer'),(67,'Paid','18/09/2019','13:12',5,'customer'),(68,'Paid','18/09/2019','13:12',5,'customer'),(69,'Paid','18/09/2019','13:12',5,'customer'),(70,'Paid','18/09/2019','13:12',5,'customer'),(71,'Paid','18/09/2019','13:12',5,'customer'),(72,'Paid','18/09/2019','13:12',5,'customer'),(73,'Paid','18/09/2019','13:12',5,'customer'),(74,'Paid','18/09/2019','13:12',5,'customer'),(75,'Paid','18/09/2019','13:12',5,'customer'),(76,'Paid','18/09/2019','13:12',5,'customer'),(77,'Paid','18/09/2019','13:12',5,'customer'),(78,'Paid','18/09/2019','13:12',5,'customer'),(79,'Paid','18/09/2019','13:12',5,'customer'),(80,'Paid','18/09/2019','13:12',5,'customer'),(81,'Paid','18/09/2019','13:12',5,'customer'),(82,'Paid','18/09/2019','13:12',5,'customer'),(83,'Paid','18/09/2019','13:12',5,'customer'),(84,'Paid','18/09/2019','13:12',5,'customer'),(85,'Paid','18/09/2019','13:12',5,'customer'),(86,'Paid','18/09/2019','13:12',5,'customer'),(87,'Paid','18/09/2019','13:12',5,'customer'),(88,'Paid','18/09/2019','13:12',5,'customer'),(89,'Paid','18/09/2019','13:12',5,'customer'),(90,'Paid','18/09/2019','13:12',5,'customer'),(91,'Paid','18/09/2019','13:12',5,'customer'),(92,'Paid','18/09/2019','13:12',5,'customer'),(93,'Paid','18/09/2019','13:12',5,'customer'),(94,'Paid','18/09/2019','13:12',5,'customer'),(95,'Paid','18/09/2019','13:12',5,'customer'),(96,'Paid','18/09/2019','13:12',5,'customer'),(97,'Paid','18/09/2019','13:12',5,'customer'),(98,'Paid','18/09/2019','13:12',5,'customer'),(99,'Paid','18/09/2019','13:12',5,'customer'),(100,'Paid','18/09/2019','13:12',5,'customer'),(101,'Paid','18/09/2019','13:12',5,'customer'),(102,'Paid','18/09/2019','13:12',5,'customer'),(103,'Paid','18/09/2019','13:12',5,'customer'),(104,'Paid','18/09/2019','13:12',5,'customer'),(105,'Paid','18/09/2019','13:12',5,'customer'),(106,'Paid','18/09/2019','13:12',5,'customer'),(107,'Paid','18/09/2019','13:12',5,'customer'),(108,'Paid','18/09/2019','13:12',5,'customer'),(109,'Information Updated','18/09/2019','17:26',5,'customer'),(110,'Updated Password','18/09/2019','17:27',5,'customer'),(111,'Paid','18/09/2019','17:27',5,'customer'),(112,'Paid','18/09/2019','18:28',5,'customer'),(113,'Paid','18/09/2019','18:32',17,'customer');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
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
