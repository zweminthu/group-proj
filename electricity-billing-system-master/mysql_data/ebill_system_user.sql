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
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(25) NOT NULL,
  `password` varchar(94) NOT NULL,
  `email` varchar(50) NOT NULL,
  `email_confirmed` enum('Flase','True') NOT NULL,
  `phone_no` varchar(15) NOT NULL,
  `address` varchar(50) NOT NULL,
  `dob` varchar(10) NOT NULL,
  `role` enum('customer','admin') NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3,'Adminstrator','pbkdf2:sha256:150000$QKxEkOPW$3c475035304650d1b39ac8599ea89b05e2bc38d6b7b45b0abc0a3c5f75a0326b','yourniama@gmail.com','True','09799456462','No.123, Yangon, Insein Tsp, Myanmar','03/09/2000','admin'),(6,'Maung Maung Oo','pbkdf2:sha256:150000$7TmgkEmc$1f0fea9e5bf0e0056ae5444ab116022a2401f90c1854508f7b2271567c4ac97e','flattenearther@gmail.com','True','09799456462','No 123, Thanlyin','2019-09-11','customer'),(8,'Min Htin Kyaw Gaung','pbkdf2:sha256:150000$gZ2OWsxc$23e1486dd8214addb5d4d14795ef0a18fb0e74af1b54640d122e1b5fff4a9f16','40437404@live.napier.ac.uk','True','098765432','user home address','2019-09-02','customer'),(18,'Khant Sithu Aung','pbkdf2:sha256:150000$1YweHPZL$8405b8b05e4077dbdda76e99e9afdbc0d0b21f7bbf5fddc29b2562f9cd308280','khantsithuaung082@gmail.com','True','0987654321','Thamine, Yangon','2000-09-17','customer'),(19,'Zwe Min Thu','pbkdf2:sha256:150000$kyHPAKfi$5480aa5ee85c42c09278b9c514cd1beea65aeec76b09b322dd4a9ba111a5aec5','zweminthu8@gmail.com','True','09450043495','Kyimyindine Tsp, Yangon, Myanmar','1995-08-08','customer'),(20,'Kaung Khant Kyaw','pbkdf2:sha256:150000$MEv22xpW$de96f0bece1c4ba22bafa3c4d59f852c9a6488da313ba9692bedf5b39d589a5f','kaungkhantkyaw@gmail.com','True','0953233456','25 Bogyoke Museum Lane','1999-09-15','customer'),(21,'Aung Htet Myat Kyaw','pbkdf2:sha256:150000$87LU4jd5$a82518ee869060aeb0d02619a2143f58967683d9fa4e9ae00ca03807c28f8da5','epicrpg@gmail.com','True','0932738473','No. 123, BoneGyi Street, Lanmadaw Township, Yangon','1999-09-01','customer'),(22,'Kyaw Thuta Kyaw','pbkdf2:sha256:150000$jRBv4HJY$ccb087b6084bed8db8ae552d1072e05a7a860e6a2a96bc83abb8526910a1c270','kiyerfeedlion@gmail.com','True','09473847282','No. 999, Yankin Township, Yangon','2000-09-04','customer'),(23,'Hlaing Min Thant','pbkdf2:sha256:150000$wfDVbfxc$876b2cefc66e5d86eba0c3a6b88007d04ab79279a2d9e3b6bb87ea4b7234f7e9','imidiot@gmail.com','True','09473728284','No. 334, Kamaryut Township, Yangon','1998-09-12','customer'),(24,'Thrapi Oo','pbkdf2:sha256:150000$owYmp5Si$7e8823ce4f976f1a24cb8871e47f2b534a96ef09da8b9272226d3bfede49fa00','ilovemmo@gmail.com','True','09567376388','No. 998, Thanlynn Township, Yangon','1999-09-06','customer'),(25,'Cherry Phoo Pyae','pbkdf2:sha256:150000$CuimRdds$956cd431b8e80c69a0182d397d947f5374a80b774c4e6c0bbd187acb71b563fc','shortercuter@gmail.com','True','09463547264','No. 456, Sanchaung Township, Yangon','1998-09-03','customer'),(26,'Swan Fevian Kyaw','pbkdf2:sha256:150000$oCrSdGrm$2a68015d3f05e50316e0dc377e25b5b35541f1bdb0f4594ad205e037351a31fb','24hrnonsleep@gmail.com','True','09478473748','No. 333, Kamaryut Township, Yangon','1998-09-06','customer'),(27,'Htet Ei Ei Kyaw','pbkdf2:sha256:150000$XlU6ZW76$5fbd00a9ceb8dde8298b378bfa3f52ce40a55d71a9b1087c640696399a25b36d','cowiscow@gmail.com','True','0944729484','Yangon University, Engyin Hostel','1998-09-05','customer'),(28,'Bo Bo Oo','pbkdf2:sha256:150000$FNEoeIT7$a4704d27e529865083632cac72e36176be5c79b683d6fe217e4ecd1227b61240','shunlaiislove@gmail.com','True','09473647374','No. 232, Myaynigone Township, Yangon','1999-09-13','customer'),(29,'Htunlin Aung','pbkdf2:sha256:150000$vxiqGnGw$06ff62e932db72ca2590290344ef4e6e254a254843c834ca20ff544802d05db9','hentaimc@gmail.com','True','094758365739','No.56, A lone Township, Yangon','1999-09-05','customer'),(30,'Kyaw Thiha Soe','pbkdf2:sha256:150000$kKSfRGfT$91cbe9b6d9471e2c6fd74964d1dc2a1a49a946a7686f31ab80911b4615fdaaeb','slarkfeed@gmail.com','True','0946353734','No. 33, Yangon','1998-09-09','customer'),(31,'Lin Lat Lat Aung','pbkdf2:sha256:150000$CA61r5DX$65dc95f05a2779ac7e7060681c5d6002eb452c5b62247383f9f92b4a3de1384c','passwordchange@gmail.com','True','094635473847','No. 443, La Thar Township, Yangon','1998-09-03','customer'),(32,'Nyi Nyi Myo Thant','pbkdf2:sha256:150000$cUvYzbTM$4e5c430dba2148559cd227206cacb3798a52602eead8796cdfbe26752389e3fe','imblack@gmail.com','True','09573736464','No. 22, ChinaTown, Yangon','1999-09-10','customer'),(33,'Tin Htoo Zaw','pbkdf2:sha256:150000$NhYXLJkU$f980984508f9b4550907e07400ef6ce49a22088c3b2cc7a9500fd82e450b2332','networkgod@gmail.com','True','09564633644','Dala Township, Yangon','1999-09-17','customer'),(34,'Ngu War Hsan ','pbkdf2:sha256:150000$Dx5PyphZ$a5faf5882866b938df619a10fce422bcc7c6c98792decafbb707936ddea24226','nguwarhsan@gmail.com','True','095748294737','No. 34, Kabaraye Township, Yangon','1998-09-19','customer'),(35,'May Thu Aung','pbkdf2:sha256:150000$c4MwHozR$2d5783653e782056edc236d09f54fa85366d6bb5df9e1e86e2d4a02047a990fc','python@gmail.com','True','095746385746','No. 34, Kabaraye Township, Yangon','1999-09-05','customer');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
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
