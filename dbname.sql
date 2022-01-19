-- MySQL dump 10.17  Distrib 10.3.22-MariaDB, for debian-linux-gnueabihf (armv8l)
--
-- Host: localhost    Database: ttrss
-- ------------------------------------------------------
-- Server version	10.3.22-MariaDB-0+deb10u1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ttrss_access_keys`
--

DROP TABLE IF EXISTS `ttrss_access_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_access_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `access_key` varchar(250) NOT NULL,
  `feed_id` varchar(250) NOT NULL,
  `is_cat` tinyint(1) NOT NULL DEFAULT 0,
  `owner_uid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_uid` (`owner_uid`),
  CONSTRAINT `ttrss_access_keys_ibfk_1` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_app_passwords`
--

DROP TABLE IF EXISTS `ttrss_app_passwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_app_passwords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `pwd_hash` text NOT NULL,
  `service` varchar(100) NOT NULL,
  `created` datetime NOT NULL,
  `last_used` datetime DEFAULT NULL,
  `owner_uid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_archived_feeds`
--

DROP TABLE IF EXISTS `ttrss_archived_feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_archived_feeds` (
  `id` int(11) NOT NULL,
  `owner_uid` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `title` varchar(200) NOT NULL,
  `feed_url` text NOT NULL,
  `site_url` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `owner_uid` (`owner_uid`),
  CONSTRAINT `ttrss_archived_feeds_ibfk_1` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_cat_counters_cache`
--

DROP TABLE IF EXISTS `ttrss_cat_counters_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_cat_counters_cache` (
  `feed_id` int(11) NOT NULL,
  `owner_uid` int(11) NOT NULL,
  `value` int(11) NOT NULL DEFAULT 0,
  `updated` datetime NOT NULL,
  KEY `owner_uid` (`owner_uid`),
  CONSTRAINT `ttrss_cat_counters_cache_ibfk_1` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_counters_cache`
--

DROP TABLE IF EXISTS `ttrss_counters_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_counters_cache` (
  `feed_id` int(11) NOT NULL,
  `owner_uid` int(11) NOT NULL,
  `value` int(11) NOT NULL DEFAULT 0,
  `updated` datetime NOT NULL,
  KEY `owner_uid` (`owner_uid`),
  KEY `ttrss_counters_cache_feed_id_idx` (`feed_id`),
  KEY `ttrss_counters_cache_value_idx` (`value`),
  CONSTRAINT `ttrss_counters_cache_ibfk_1` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_enclosures`
--

DROP TABLE IF EXISTS `ttrss_enclosures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_enclosures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_url` text NOT NULL,
  `content_type` varchar(250) NOT NULL,
  `post_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `duration` text NOT NULL,
  `width` int(11) NOT NULL DEFAULT 0,
  `height` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `ttrss_enclosures_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `ttrss_entries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=984 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_entries`
--

DROP TABLE IF EXISTS `ttrss_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `guid` varchar(255) NOT NULL,
  `link` text NOT NULL,
  `updated` datetime NOT NULL,
  `content` longtext NOT NULL,
  `content_hash` varchar(250) NOT NULL,
  `cached_content` longtext DEFAULT NULL,
  `no_orig_date` tinyint(1) NOT NULL DEFAULT 0,
  `date_entered` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `num_comments` int(11) NOT NULL DEFAULT 0,
  `plugin_data` longtext DEFAULT NULL,
  `lang` varchar(2) DEFAULT NULL,
  `comments` varchar(250) NOT NULL DEFAULT '',
  `author` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `guid` (`guid`),
  KEY `ttrss_entries_date_entered_index` (`date_entered`),
  KEY `ttrss_entries_updated_idx` (`updated`)
) ENGINE=InnoDB AUTO_INCREMENT=154750 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_entry_comments`
--

DROP TABLE IF EXISTS `ttrss_entry_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_entry_comments` (
  `id` int(11) NOT NULL,
  `ref_id` int(11) NOT NULL,
  `owner_uid` int(11) NOT NULL,
  `private` tinyint(1) NOT NULL DEFAULT 0,
  `date_entered` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ref_id` (`ref_id`),
  KEY `owner_uid` (`owner_uid`),
  CONSTRAINT `ttrss_entry_comments_ibfk_1` FOREIGN KEY (`ref_id`) REFERENCES `ttrss_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ttrss_entry_comments_ibfk_2` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_error_log`
--

DROP TABLE IF EXISTS `ttrss_error_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_error_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_uid` int(11) DEFAULT NULL,
  `errno` int(11) NOT NULL,
  `errstr` text NOT NULL,
  `filename` text NOT NULL,
  `lineno` int(11) NOT NULL,
  `context` text NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_uid` (`owner_uid`),
  CONSTRAINT `ttrss_error_log_ibfk_1` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_feed_categories`
--

DROP TABLE IF EXISTS `ttrss_feed_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_feed_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_uid` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `collapsed` tinyint(1) NOT NULL DEFAULT 0,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `parent_cat` int(11) DEFAULT NULL,
  `view_settings` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `parent_cat` (`parent_cat`),
  KEY `owner_uid` (`owner_uid`),
  CONSTRAINT `ttrss_feed_categories_ibfk_1` FOREIGN KEY (`parent_cat`) REFERENCES `ttrss_feed_categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ttrss_feed_categories_ibfk_2` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_feedbrowser_cache`
--

DROP TABLE IF EXISTS `ttrss_feedbrowser_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_feedbrowser_cache` (
  `feed_url` text NOT NULL,
  `site_url` text NOT NULL,
  `title` text NOT NULL,
  `subscribers` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_feeds`
--

DROP TABLE IF EXISTS `ttrss_feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_feeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_uid` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `cat_id` int(11) DEFAULT NULL,
  `feed_url` text NOT NULL,
  `icon_url` varchar(250) NOT NULL DEFAULT '',
  `update_interval` int(11) NOT NULL DEFAULT 0,
  `purge_interval` int(11) NOT NULL DEFAULT 0,
  `last_updated` datetime DEFAULT NULL,
  `last_unconditional` datetime DEFAULT NULL,
  `last_error` varchar(250) NOT NULL DEFAULT '',
  `last_modified` varchar(250) NOT NULL DEFAULT '',
  `favicon_avg_color` varchar(11) DEFAULT NULL,
  `site_url` varchar(250) NOT NULL DEFAULT '',
  `auth_login` varchar(250) NOT NULL DEFAULT '',
  `auth_pass` varchar(250) NOT NULL DEFAULT '',
  `parent_feed` int(11) DEFAULT NULL,
  `private` tinyint(1) NOT NULL DEFAULT 0,
  `rtl_content` tinyint(1) NOT NULL DEFAULT 0,
  `hidden` tinyint(1) NOT NULL DEFAULT 0,
  `include_in_digest` tinyint(1) NOT NULL DEFAULT 1,
  `cache_images` tinyint(1) NOT NULL DEFAULT 0,
  `hide_images` tinyint(1) NOT NULL DEFAULT 0,
  `cache_content` tinyint(1) NOT NULL DEFAULT 0,
  `auth_pass_encrypted` tinyint(1) NOT NULL DEFAULT 0,
  `last_viewed` datetime DEFAULT NULL,
  `last_update_started` datetime DEFAULT NULL,
  `always_display_enclosures` tinyint(1) NOT NULL DEFAULT 0,
  `update_method` int(11) NOT NULL DEFAULT 0,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `mark_unread_on_update` tinyint(1) NOT NULL DEFAULT 0,
  `update_on_checksum_change` tinyint(1) NOT NULL DEFAULT 0,
  `strip_images` tinyint(1) NOT NULL DEFAULT 0,
  `view_settings` varchar(250) NOT NULL DEFAULT '',
  `pubsub_state` int(11) NOT NULL DEFAULT 0,
  `favicon_last_checked` datetime DEFAULT NULL,
  `feed_language` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `feed_url` (`feed_url`(255),`owner_uid`),
  KEY `owner_uid` (`owner_uid`),
  KEY `cat_id` (`cat_id`),
  KEY `parent_feed` (`parent_feed`),
  CONSTRAINT `ttrss_feeds_ibfk_1` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ttrss_feeds_ibfk_2` FOREIGN KEY (`cat_id`) REFERENCES `ttrss_feed_categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ttrss_feeds_ibfk_3` FOREIGN KEY (`parent_feed`) REFERENCES `ttrss_feeds` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_filter_actions`
--

DROP TABLE IF EXISTS `ttrss_filter_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_filter_actions` (
  `id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `description` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_filter_types`
--

DROP TABLE IF EXISTS `ttrss_filter_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_filter_types` (
  `id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `description` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_filters2`
--

DROP TABLE IF EXISTS `ttrss_filters2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_filters2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_uid` int(11) NOT NULL,
  `match_any_rule` tinyint(1) NOT NULL DEFAULT 0,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `inverse` tinyint(1) NOT NULL DEFAULT 0,
  `title` varchar(250) NOT NULL DEFAULT '',
  `order_id` int(11) NOT NULL DEFAULT 0,
  `last_triggered` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_uid` (`owner_uid`),
  CONSTRAINT `ttrss_filters2_ibfk_1` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_filters2_actions`
--

DROP TABLE IF EXISTS `ttrss_filters2_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_filters2_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filter_id` int(11) NOT NULL,
  `action_id` int(11) NOT NULL DEFAULT 1,
  `action_param` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `filter_id` (`filter_id`),
  KEY `action_id` (`action_id`),
  CONSTRAINT `ttrss_filters2_actions_ibfk_1` FOREIGN KEY (`filter_id`) REFERENCES `ttrss_filters2` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ttrss_filters2_actions_ibfk_2` FOREIGN KEY (`action_id`) REFERENCES `ttrss_filter_actions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_filters2_rules`
--

DROP TABLE IF EXISTS `ttrss_filters2_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_filters2_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filter_id` int(11) NOT NULL,
  `reg_exp` text NOT NULL,
  `inverse` tinyint(1) NOT NULL DEFAULT 0,
  `filter_type` int(11) NOT NULL,
  `feed_id` int(11) DEFAULT NULL,
  `cat_id` int(11) DEFAULT NULL,
  `cat_filter` tinyint(1) NOT NULL DEFAULT 0,
  `match_on` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `filter_id` (`filter_id`),
  KEY `filter_type` (`filter_type`),
  KEY `feed_id` (`feed_id`),
  KEY `cat_id` (`cat_id`),
  CONSTRAINT `ttrss_filters2_rules_ibfk_1` FOREIGN KEY (`filter_id`) REFERENCES `ttrss_filters2` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ttrss_filters2_rules_ibfk_2` FOREIGN KEY (`filter_type`) REFERENCES `ttrss_filter_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ttrss_filters2_rules_ibfk_3` FOREIGN KEY (`feed_id`) REFERENCES `ttrss_feeds` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ttrss_filters2_rules_ibfk_4` FOREIGN KEY (`cat_id`) REFERENCES `ttrss_feed_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_labels2`
--

DROP TABLE IF EXISTS `ttrss_labels2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_labels2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_uid` int(11) NOT NULL,
  `caption` varchar(250) NOT NULL,
  `fg_color` varchar(15) NOT NULL DEFAULT '',
  `bg_color` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `owner_uid` (`owner_uid`),
  CONSTRAINT `ttrss_labels2_ibfk_1` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_linked_feeds`
--

DROP TABLE IF EXISTS `ttrss_linked_feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_linked_feeds` (
  `feed_url` text NOT NULL,
  `site_url` text NOT NULL,
  `title` text NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `instance_id` int(11) NOT NULL,
  `subscribers` int(11) NOT NULL,
  KEY `instance_id` (`instance_id`),
  CONSTRAINT `ttrss_linked_feeds_ibfk_1` FOREIGN KEY (`instance_id`) REFERENCES `ttrss_linked_instances` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_linked_instances`
--

DROP TABLE IF EXISTS `ttrss_linked_instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_linked_instances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_connected` datetime NOT NULL,
  `last_status_in` int(11) NOT NULL,
  `last_status_out` int(11) NOT NULL,
  `access_key` varchar(250) NOT NULL,
  `access_url` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_key` (`access_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_plugin_storage`
--

DROP TABLE IF EXISTS `ttrss_plugin_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_plugin_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `owner_uid` int(11) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_uid` (`owner_uid`),
  CONSTRAINT `ttrss_plugin_storage_ibfk_1` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_prefs`
--

DROP TABLE IF EXISTS `ttrss_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_prefs` (
  `pref_name` varchar(250) NOT NULL,
  `type_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL DEFAULT 1,
  `access_level` int(11) NOT NULL DEFAULT 0,
  `def_value` text NOT NULL,
  PRIMARY KEY (`pref_name`),
  KEY `type_id` (`type_id`),
  KEY `section_id` (`section_id`),
  CONSTRAINT `ttrss_prefs_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `ttrss_prefs_types` (`id`),
  CONSTRAINT `ttrss_prefs_ibfk_2` FOREIGN KEY (`section_id`) REFERENCES `ttrss_prefs_sections` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_prefs_sections`
--

DROP TABLE IF EXISTS `ttrss_prefs_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_prefs_sections` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_prefs_types`
--

DROP TABLE IF EXISTS `ttrss_prefs_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_prefs_types` (
  `id` int(11) NOT NULL,
  `type_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_sessions`
--

DROP TABLE IF EXISTS `ttrss_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_sessions` (
  `id` varchar(250) NOT NULL,
  `data` text DEFAULT NULL,
  `expire` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_settings_profiles`
--

DROP TABLE IF EXISTS `ttrss_settings_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_settings_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `owner_uid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_uid` (`owner_uid`),
  CONSTRAINT `ttrss_settings_profiles_ibfk_1` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_tags`
--

DROP TABLE IF EXISTS `ttrss_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_uid` int(11) NOT NULL,
  `tag_name` varchar(250) NOT NULL,
  `post_int_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_int_id` (`post_int_id`),
  KEY `owner_uid` (`owner_uid`),
  CONSTRAINT `ttrss_tags_ibfk_1` FOREIGN KEY (`post_int_id`) REFERENCES `ttrss_user_entries` (`int_id`) ON DELETE CASCADE,
  CONSTRAINT `ttrss_tags_ibfk_2` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=181397 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_user_entries`
--

DROP TABLE IF EXISTS `ttrss_user_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_user_entries` (
  `int_id` int(11) NOT NULL AUTO_INCREMENT,
  `ref_id` int(11) NOT NULL,
  `uuid` varchar(200) NOT NULL,
  `feed_id` int(11) DEFAULT NULL,
  `orig_feed_id` int(11) DEFAULT NULL,
  `owner_uid` int(11) NOT NULL,
  `marked` tinyint(1) NOT NULL DEFAULT 0,
  `published` tinyint(1) NOT NULL DEFAULT 0,
  `tag_cache` text NOT NULL,
  `label_cache` text NOT NULL,
  `last_read` datetime DEFAULT NULL,
  `score` int(11) NOT NULL DEFAULT 0,
  `note` longtext DEFAULT NULL,
  `last_marked` datetime DEFAULT NULL,
  `last_published` datetime DEFAULT NULL,
  `unread` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`int_id`),
  KEY `ref_id` (`ref_id`),
  KEY `feed_id` (`feed_id`),
  KEY `orig_feed_id` (`orig_feed_id`),
  KEY `owner_uid` (`owner_uid`),
  KEY `ttrss_user_entries_unread_idx` (`unread`),
  CONSTRAINT `ttrss_user_entries_ibfk_1` FOREIGN KEY (`ref_id`) REFERENCES `ttrss_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ttrss_user_entries_ibfk_2` FOREIGN KEY (`feed_id`) REFERENCES `ttrss_feeds` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ttrss_user_entries_ibfk_3` FOREIGN KEY (`orig_feed_id`) REFERENCES `ttrss_archived_feeds` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ttrss_user_entries_ibfk_4` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=154750 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_user_labels2`
--

DROP TABLE IF EXISTS `ttrss_user_labels2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_user_labels2` (
  `label_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  KEY `label_id` (`label_id`),
  KEY `article_id` (`article_id`),
  CONSTRAINT `ttrss_user_labels2_ibfk_1` FOREIGN KEY (`label_id`) REFERENCES `ttrss_labels2` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ttrss_user_labels2_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `ttrss_entries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_user_prefs`
--

DROP TABLE IF EXISTS `ttrss_user_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_user_prefs` (
  `owner_uid` int(11) NOT NULL,
  `pref_name` varchar(250) DEFAULT NULL,
  `value` longtext NOT NULL,
  `profile` int(11) DEFAULT NULL,
  KEY `profile` (`profile`),
  KEY `owner_uid` (`owner_uid`),
  KEY `pref_name` (`pref_name`),
  CONSTRAINT `ttrss_user_prefs_ibfk_1` FOREIGN KEY (`profile`) REFERENCES `ttrss_settings_profiles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ttrss_user_prefs_ibfk_2` FOREIGN KEY (`owner_uid`) REFERENCES `ttrss_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ttrss_user_prefs_ibfk_3` FOREIGN KEY (`pref_name`) REFERENCES `ttrss_prefs` (`pref_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_users`
--

DROP TABLE IF EXISTS `ttrss_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(120) NOT NULL,
  `pwd_hash` varchar(250) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `access_level` int(11) NOT NULL DEFAULT 0,
  `email` varchar(250) NOT NULL DEFAULT '',
  `full_name` varchar(250) NOT NULL DEFAULT '',
  `email_digest` tinyint(1) NOT NULL DEFAULT 0,
  `last_digest_sent` datetime DEFAULT NULL,
  `salt` varchar(250) NOT NULL DEFAULT '',
  `created` datetime DEFAULT NULL,
  `twitter_oauth` longtext DEFAULT NULL,
  `otp_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `resetpass_token` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ttrss_version`
--

DROP TABLE IF EXISTS `ttrss_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttrss_version` (
  `schema_version` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-19 11:53:54
