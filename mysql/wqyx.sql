/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : wqyx

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2017-09-30 15:38:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `hero1`
-- ----------------------------
DROP TABLE IF EXISTS `hero1`;
CREATE TABLE `hero1` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `playerTag` varchar(255) DEFAULT NULL,
  `recruited` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hero1
-- ----------------------------
INSERT INTO `hero1` VALUES ('8', '888888-1', '4002;4003;5003');

-- ----------------------------
-- Table structure for `playerinfo1`
-- ----------------------------
DROP TABLE IF EXISTS `playerinfo1`;
CREATE TABLE `playerinfo1` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `playerTag` varchar(255) DEFAULT NULL,
  `lv` int(11) DEFAULT NULL,
  `sex` tinyint(4) DEFAULT NULL,
  `playerName` char(255) DEFAULT NULL,
  `headTag` tinyint(4) DEFAULT NULL,
  `diamond` int(11) DEFAULT NULL,
  `gold` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of playerinfo1
-- ----------------------------
INSERT INTO `playerinfo1` VALUES ('6', '888888-1', '1', '2', 'DG123456', '1', '0', '0');

-- ----------------------------
-- Table structure for `test`
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` int(11) NOT NULL DEFAULT '0',
  `std` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES ('1', '2');

-- ----------------------------
-- Table structure for `userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userName` char(255) DEFAULT NULL,
  `playerTag` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('8', '888888', '888888-1');
