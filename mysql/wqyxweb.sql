/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : wqyxweb

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2017-09-30 15:38:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `user_info`
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `userName` char(255) DEFAULT NULL,
  `passWord` char(255) DEFAULT NULL,
  `registerTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `serverID` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('0000000001', '8456747', '58467758', '2017-09-14 16:48:50', null);
INSERT INTO `user_info` VALUES ('0000000002', '888888', '888888', '2017-09-20 15:30:48', '1');
INSERT INTO `user_info` VALUES ('0000000003', '234777788', '5678888', '2017-09-14 17:49:41', null);
INSERT INTO `user_info` VALUES ('0000000004', '666666', '666666', '2017-09-22 10:15:06', null);
INSERT INTO `user_info` VALUES ('0000000005', '8888888', '8888888', '2017-09-29 17:55:44', null);
INSERT INTO `user_info` VALUES ('0000000006', '999999', '888888', '2017-09-30 15:09:16', null);
INSERT INTO `user_info` VALUES ('0000000007', '88888857', '888888', '2017-09-30 15:10:33', null);
INSERT INTO `user_info` VALUES ('0000000008', '888878857', '888888', '2017-09-30 15:11:20', null);
INSERT INTO `user_info` VALUES ('0000000009', '8888788757', '888888', '2017-09-30 15:14:24', null);
INSERT INTO `user_info` VALUES ('0000000010', '8888757', '888888', '2017-09-30 15:16:40', null);
INSERT INTO `user_info` VALUES ('0000000011', '88884757', '888888', '2017-09-30 15:16:54', null);
INSERT INTO `user_info` VALUES ('0000000012', '123456', '888888', '2017-09-30 15:20:42', null);
INSERT INTO `user_info` VALUES ('0000000013', '1234556', '888888', '2017-09-30 15:21:25', null);
