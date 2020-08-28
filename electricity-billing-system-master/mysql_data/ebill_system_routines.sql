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
-- Temporary view structure for view `current_month_payment`
--

DROP TABLE IF EXISTS `current_month_payment`;
/*!50001 DROP VIEW IF EXISTS `current_month_payment`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `current_month_payment` AS SELECT 
 1 AS `total_bill`,
 1 AS `meter_unit`,
 1 AS `month`,
 1 AS `year`,
 1 AS `meter_id`,
 1 AS `customer_id`,
 1 AS `user_id`,
 1 AS `user_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!50001 DROP VIEW IF EXISTS `invoice`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `invoice` AS SELECT 
 1 AS `total_bill`,
 1 AS `meter_unit`,
 1 AS `month`,
 1 AS `meter_id`,
 1 AS `customer_id`,
 1 AS `user_id`,
 1 AS `user_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `current_year_payment`
--

DROP TABLE IF EXISTS `current_year_payment`;
/*!50001 DROP VIEW IF EXISTS `current_year_payment`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `current_year_payment` AS SELECT 
 1 AS `total_bill`,
 1 AS `meter_unit`,
 1 AS `month`,
 1 AS `year`,
 1 AS `meter_id`,
 1 AS `customer_id`,
 1 AS `user_id`,
 1 AS `user_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `user_detail`
--

DROP TABLE IF EXISTS `user_detail`;
/*!50001 DROP VIEW IF EXISTS `user_detail`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_detail` AS SELECT 
 1 AS `customer_id`,
 1 AS `user_name`,
 1 AS `email`,
 1 AS `address`,
 1 AS `wallet_amount`,
 1 AS `meter_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `current_month_payment`
--

/*!50001 DROP VIEW IF EXISTS `current_month_payment`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `current_month_payment` AS select `bill`.`total_bill` AS `total_bill`,`bill`.`meter_unit` AS `meter_unit`,`bill`.`month` AS `month`,`bill`.`year` AS `year`,`meter`.`meter_id` AS `meter_id`,`customer`.`customer_id` AS `customer_id`,`user`.`user_id` AS `user_id`,`user`.`user_name` AS `user_name` from (((`user` join `customer` on((`customer`.`user_id` = `user`.`user_id`))) join `meter` on((`meter`.`customer_id` = `customer`.`customer_id`))) join `bill` on((`bill`.`meter_id` = `meter`.`meter_id`))) where (`bill`.`month` = convert(upper(left(monthname(str_to_date(month(curdate()),'%m')),3)) using utf8mb4)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `invoice`
--

/*!50001 DROP VIEW IF EXISTS `invoice`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `invoice` AS select `bill`.`total_bill` AS `total_bill`,`bill`.`meter_unit` AS `meter_unit`,`bill`.`month` AS `month`,`meter`.`meter_id` AS `meter_id`,`customer`.`customer_id` AS `customer_id`,`user`.`user_id` AS `user_id`,`user`.`user_name` AS `user_name` from (((`user` join `customer` on((`customer`.`user_id` = `user`.`user_id`))) join `meter` on((`meter`.`customer_id` = `customer`.`customer_id`))) join `bill` on((`bill`.`meter_id` = `meter`.`meter_id`))) where (`bill`.`status` = 'Paid') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `current_year_payment`
--

/*!50001 DROP VIEW IF EXISTS `current_year_payment`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `current_year_payment` AS select `bill`.`total_bill` AS `total_bill`,`bill`.`meter_unit` AS `meter_unit`,`bill`.`month` AS `month`,`bill`.`year` AS `year`,`meter`.`meter_id` AS `meter_id`,`customer`.`customer_id` AS `customer_id`,`user`.`user_id` AS `user_id`,`user`.`user_name` AS `user_name` from (((`user` join `customer` on((`customer`.`user_id` = `user`.`user_id`))) join `meter` on((`meter`.`customer_id` = `customer`.`customer_id`))) join `bill` on((`bill`.`meter_id` = `meter`.`meter_id`))) where (`bill`.`year` = year(curdate())) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_detail`
--

/*!50001 DROP VIEW IF EXISTS `user_detail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_detail` AS select `customer`.`customer_id` AS `customer_id`,`user`.`user_name` AS `user_name`,`user`.`email` AS `email`,`user`.`address` AS `address`,`wallet`.`wallet_amount` AS `wallet_amount`,group_concat(`meter`.`meter_id` separator ',') AS `meter_id` from (((`user` join `customer` on((`customer`.`user_id` = `user`.`user_id`))) left join `meter` on((`meter`.`customer_id` = `customer`.`customer_id`))) join `wallet` on((`wallet`.`customer_id` = `customer`.`customer_id`))) group by `user`.`user_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-20 11:56:58
