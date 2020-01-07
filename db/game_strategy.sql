/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50720
 Source Host           : localhost:3306
 Source Schema         : game_strategy

 Target Server Type    : MySQL
 Target Server Version : 50720
 File Encoding         : 65001

 Date: 07/01/2020 22:54:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `del` int(11) NOT NULL DEFAULT 0,
  `role` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES (1, 'ew', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', 0, 1);
INSERT INTO `admin_user` VALUES (2, 'editor', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', 0, 2);
INSERT INTO `admin_user` VALUES (3, 'ew7', '2', 0, 2);
INSERT INTO `admin_user` VALUES (4, 'test', '123', 1, 2);

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gameId` int(11) NOT NULL,
  `del` int(11) NOT NULL DEFAULT 0,
  `create_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_f0c0a548770631363577d0c6063`(`gameId`) USING BTREE,
  CONSTRAINT `FK_f0c0a548770631363577d0c6063` FOREIGN KEY (`gameId`) REFERENCES `game` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (3, '《绝地求生：刺激战场》运输船介绍', '/public/img_1578406452504zr10xwqinq.jpg', 2, 0, '1578406495732', '<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">《</span><a href=\"https://shouyou.3dmgame.com/zt/29856/\" target=\"_blank\"><span style=\"color: rgb(0,128,255);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">绝地求生：刺激战场</span></a><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">》是腾讯旗下光子工作室群自研战斗特训手游，刺激战场这款游戏从推出至今已经是有接近两年的时间，目前也已经经历了很多个赛季了，而今年进行的大更新确实不算多，所以在五月份的时候是会进行一次大的更新的，这一次的更新不仅仅是同步端游的内容，还会推出一些新的内容的。</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428110033_93883.jpg\" alt=\"《绝地求生：刺激战场》运输船介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,102,0);background-color: rgb(255,255,255);font-size: 16px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>《绝地</strong></span><a href=\"https://shouyou.3dmgame.com/zt/qiusheng/\" target=\"_blank\"><span style=\"color: rgb(0,128,255);background-color: rgb(255,255,255);font-size: 16px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>求生</strong></span></a><span style=\"color: rgb(229,102,0);background-color: rgb(255,255,255);font-size: 16px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>：刺激战场》运输船介绍</strong></span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428110054_51339.jpg\" alt=\"《绝地求生：刺激战场》运输船介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">首选根据网络爆料的消息来看，这一次的更新很可能会上线一款新的地图，而且这个地图是一个4v4模式的地图，而且地图的样式非常像穿越火线当中的运输船这个地图，也是一个团队竞技，被淘汰之后是会复活的，而且也也分为两个阵营的。</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428110107_39847.jpg\" alt=\"《绝地求生：刺激战场》运输船介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">其实看到这里相信大家也都明白这个模式的含义了吧，第一点就是可以给我们玩家提供更快节奏的战斗，毕竟虽然有娱乐模式的存在，但是这种模式还是需要一定的时间的，而且有时候随机到的武器不一定是我们想用的，但是这个模式就不存在这种问题。</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428110119_12684.jpg\" alt=\"《绝地求生：刺激战场》运输船介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">因为在这个模式当中，玩家是有固定的出生点的，而且在出生点里面是有武器和配件可以让我们玩家自由去选择，类似于训练场里面的武器桌子，而且由于地图本身很小，所以玩家之间的对抗也是面对面的，不会存在那种伏地魔等很胆小的玩法。</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428110147_91775.jpg\" alt=\"《绝地求生：刺激战场》运输船介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">第二点就是可以练技术，要知道在这种很快节奏的玩法下面，我们玩家的技术可以提升的非常的快的，毕竟以前我们练技术只能在训练场里面，但是训练场里面只能打一下树和靶子，但是这个模式里面完完全全就是真人进行对抗的，对技术很有帮助。</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428110159_29657.jpg\" alt=\"《绝地求生：刺激战场》运输船介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">而且在这个模式里面我们是可以体验到空投武器的，因为像M249这种空投专属的武器在这个地图里面是全地图刷新的，这样也弥补了之前娱乐模式里面的不足之处，而且那些喜欢玩CF这种团队竞技的玩家也可以在刺激战场里面好好的去体验一下了。</span>&nbsp;</p>\n');
INSERT INTO `article` VALUES (4, '《绝地求生：刺激战场》8大热门载具盘点介绍', '/public/img_15784065206576plntf4m1kg.jpg', 2, 0, '1578406535173', '<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">《</span><a href=\"https://shouyou.3dmgame.com/zt/29856/\" target=\"_blank\"><span style=\"color: rgb(0,128,255);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">绝地求生：刺激战场</span></a><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">》是腾讯旗下光子工作室群自研战斗特训手游，《绝地</span><a href=\"https://shouyou.3dmgame.com/zt/qiusheng/\" target=\"_blank\"><span style=\"color: rgb(0,128,255);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">求生</span></a><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">：刺激战场》8大热门载具盘点，载具优缺点解析。在游戏中有不少的载具，不知道小伙伴们都用什么样的载具呢?在游戏中有8大热门载具，下面就和小编一起来看看吧!</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428102620_92000.jpg\" alt=\"《绝地求生：刺激战场》8大热门载具盘点介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,102,0);background-color: rgb(255,255,255);font-size: 16px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>《绝地求生：刺激战场》8大热门载具盘点</strong></span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">两轮摩托</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428102715_51932.jpg\" alt=\"《绝地求生：刺激战场》8大热门载具盘点介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">优点：速度快、灵活性高</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">缺点：难控制、易翻车</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">两轮摩托绝对是刺激战场上最能“秀”的载具，也是在各种技巧大神手下出场率最高的道具。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">由于其转向灵活，速度极快，模型轻小。我们遇到陡峭的地形时，摩托车会在空中腾空一段时间。利用这个特性，我们可以用压头或者抬头的方式，让摩托在空中旋转，做出很多炫酷的花式技巧。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">雪地摩托</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428102914_42053.jpg\" alt=\"《绝地求生：刺激战场》8大热门载具盘点介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">优点：雪地常见、机动性好</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">缺点：只能搭载2人、无防护</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">雪地摩托是雪地地图上独特和较为常见的载具之一。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">三轮车</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428103029_18746.jpg\" alt=\"《绝地求生：刺激战场》8大热门载具盘点介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">优点：外观有趣</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">缺点：速度一般、耐久不高</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">雨林地图节奏快，而三轮的速度一般，也不耐打，大家可以体验体验，但还是不要太依赖它哦~</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">蹦蹦车</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428103101_84157.jpg\" alt=\"《绝地求生：刺激战场》8大热门载具盘点介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">优点：机动性强、地形适应性高</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">缺点：缺少防护、噪声较大</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">蹦蹦速度快、灵活轻巧。无论是翻山越岭还是公路飙车，都可以游刃有余。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">轿车</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428103204_15281.jpg\" alt=\"《绝地求生：刺激战场》8大热门载具盘点介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">优点：耐久较高、速度较佳</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">缺点：爬坡能力较弱</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">轿车的设计很有家居车的影子，车身大小适中，车速也不落后其它以速度见长的载具，可以说是刺激战场上最为实用的载具了。一方面速度较快，方便我们进行转移。另一方面车身小巧、转向灵活又较为耐打。可以说，轿车绝对是刺激战场上最经济实惠的载具。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">越野车</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428103235_29281.jpg\" alt=\"《绝地求生：刺激战场》8大热门载具盘点介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">优点：耐久高、防护能力优秀</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">缺点：速度较慢、灵活性较差</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">说到载具自然少不了越野车!毫无疑问，说它是刺激战场最受欢迎的载具也不为过。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">越野车坚实的车身、厚重的模型，保证了我们在开车的时候，不那么容易被敌人乱枪击倒。其车速在公路上，也可见一般。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">加长轿车</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428103400_89369.jpg\" alt=\"《绝地求生：刺激战场》8大热门载具盘点介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">优点：外观酷炫、性能均衡</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">缺点：地形适应性较差</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">俗话说：爱屋及乌。鸡仔因为这款车，而沉迷了一段时间的沙漠地图。相信很多鸡友都已经猜到了~没错，就是这款加长轿车!</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">加长轿车车身扁平，启动速度快，启动后车速快而平稳。使用这款车要注意。由于底盘较低，不适合爬坡，一定要根据自己当时所处的情况，合理使用哦。</span></p>\n<p style=\"text-align:left;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 14px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">巴士</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428103431_28396.jpg\" alt=\"《绝地求生：刺激战场》8大热门载具盘点介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">优点：耐久高、防护强</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">缺点：速度慢、爬坡能力弱</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">大巴车相比其它载具，外形上看起来憨厚朴实。其共有六个座位的设定，方便我们在转移过程中被敌人扫射时，进行座位的切换。车速一般，车身耐打。</span>&nbsp;</p>\n');
INSERT INTO `article` VALUES (5, '《绝地求生：刺激战场》海岛图易防守建筑介绍', '/public/img_157840656367996ht7fvfunv.jpg', 2, 0, '1578406577277', '<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">《</span><a href=\"https://shouyou.3dmgame.com/zt/29856/\" target=\"_blank\"><span style=\"color: rgb(0,128,255);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">绝地求生：刺激战场</span></a><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">》是腾讯旗下光子工作室群自研战斗特训手游，《绝地</span><a href=\"https://shouyou.3dmgame.com/zt/qiusheng/\" target=\"_blank\"><span style=\"color: rgb(0,128,255);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">求生</span></a><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">：刺激战场》楼房防守战是最经常发生的事情，因为有一个好房区在有些时候是非常好用的。下面和小编一起来看看《绝地求生：刺激战场》海岛图最容易防守的建筑。</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428091443_37233.jpg\" alt=\"《绝地求生：刺激战场》海岛图易防守建筑介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,102,0);background-color: rgb(255,255,255);font-size: 16px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>《绝地求生：刺激战场》海岛图易防守建筑介绍</strong></span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">假车库</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428091451_71689.jpg\" alt=\"《绝地求生：刺激战场》海岛图易防守建筑介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">假车库只有一个楼梯可以上二楼，所以要守楼其实很简单，只要把楼梯堵住就可以。玩家可以驾驶一辆载具冲到楼梯，然后在楼上把车打爆。这样敌人就无法上楼，我们就可以在楼上对敌人进行打靶。不过二楼容易受到手雷攻击，所以玩家要注意从窗户进来的手雷。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">卫星楼</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428091458_36851.jpg\" alt=\"《绝地求生：刺激战场》海岛图易防守建筑介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">海岛的卫星楼只有少数几个位置，这几个位置都是视野比较开阔的地方。在卫星楼上面打靶是开心的事情，不过卫星楼容易被手雷攻击，所以玩家最好是卡楼梯。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">宿舍楼</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190428/20190428091505_20123.jpg\" alt=\"《绝地求生：刺激战场》海岛图易防守建筑介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">宿舍楼的楼层很高，屋顶还有平台，所以在屋顶很好狙击敌人。宿舍楼也只有一个楼梯可以上楼，玩家可以在楼梯的拐角去卡敌人视野。</span>&nbsp;</p>\n');
INSERT INTO `article` VALUES (6, '《绝地求生：刺激战场》握把搭配推荐介绍', '/public/img_1578406634015n9n2k8x2yc.jpg', 2, 0, '1578406646465', '<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">《</span><a href=\"https://shouyou.3dmgame.com/zt/29856/\" target=\"_blank\"><span style=\"color: rgb(0,128,255);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">绝地求生：刺激战场</span></a><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">》是腾讯旗下光子工作室群自研战斗特训手游，绝地</span><a href=\"https://shouyou.3dmgame.com/zt/qiusheng/\" target=\"_blank\"><span style=\"color: rgb(0,128,255);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">求生</span></a><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">刺激战场握把有很多种，而且每一个握把都有各自的特点。《绝地求生：刺激战场》握把怎么搭配?下面和小编一起看看《绝地求生：刺激战场》握把搭配推荐介绍。</span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190416/20190416103415_81433.jpg\" alt=\"《绝地求生：刺激战场》握把搭配推荐介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>《绝地求生：刺激战场》握把搭配推荐</strong></span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>直角握把</strong></span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190416/20190416103451_87445.jpg\" alt=\"《绝地求生：刺激战场》握把搭配推荐介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">直角握把大幅度减少横向后坐力，同时也可以减少垂直后坐力，因此直角握把比较适合横向后坐力较大的武器。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>武器推荐：SCAR</strong></span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>垂直握把</strong></span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190416/20190416103501_88361.jpg\" alt=\"《绝地求生：刺激战场》握把搭配推荐介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">垂直握把主要是减少垂直方向的后坐力，因此比较适合压枪，对于后坐力大的武器都非常适合。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>武器推荐：M416、M726、G36C</strong></span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>拇指握把</strong></span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190416/20190416103523_55078.jpg\" alt=\"《绝地求生：刺激战场》握把搭配推荐介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">拇指握把很适合近距离武器使用，提高开镜速度特别是冲锋枪。在巷战当中，谁先开镜瞄准就有更大的优势。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>武器推荐：UMP9、Vector</strong></span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>轻型握把</strong></span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190416/20190416103537_83293.jpg\" alt=\"《绝地求生：刺激战场》握把搭配推荐介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">轻型握把最主要的属性是增加瞄准稳定性以及后坐力恢复时间，因此轻型握把只能是用在单发点射当中，所以定位就很明显。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>武器推荐：SKS、MK14</strong></span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>半截式握把</strong></span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190416/20190416103549_36314.jpg\" alt=\"《绝地求生：刺激战场》握把搭配推荐介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">半截式握把综合能力较强，但是不太适合在高倍镜下使用，因此更加适合中短距离交战。跟拇指握把相比，综合性更强。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>武器推荐：M416、UMP9</strong></span>&nbsp;</p>\n');
INSERT INTO `article` VALUES (7, '《绝地求生：刺激战场》新手跳伞不推荐地点介绍', '/public/img_15784066821030apv8wna4ohi.jpg', 2, 0, '1578406691859', '<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">《</span><a href=\"https://shouyou.3dmgame.com/zt/29856/\" target=\"_blank\"><span style=\"color: rgb(0,128,255);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">绝地求生：刺激战场</span></a><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">》是腾讯旗下光子工作室群自研战斗特训手游，《绝地</span><a href=\"https://shouyou.3dmgame.com/zt/qiusheng/\" target=\"_blank\"><span style=\"color: rgb(0,128,255);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">求生</span></a><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">：刺激战场》新手因为自身技术问题，所以前期是不推荐去一些非常热门的地方。这些热门地方虽然资源多，但是人也多，所以新手往往会直接落地成盒。这边来看看《绝地求生：刺激战场》新手不推荐的几个跳点。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>学校</strong></span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190409/20190409163211_44398.jpg\" alt=\"《绝地求生：刺激战场》新手跳伞不推荐地点介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">学校一直都是热门地带，因为这里地处地图中心，所以前面几个圈不管怎么刷都是在圈内，玩家都不用担心去跑毒。学校的好资源跟地理优势吸引很多玩家，对自己技术没有信心的玩家还是不要靠近学校。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>Y城</strong></span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190409/20190409163219_15307.jpg\" alt=\"《绝地求生：刺激战场》新手跳伞不推荐地点介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">Y城房屋多，这样可以容纳很多队伍同时搜索。Y城的几个重要资源点是抢夺的重点，玩家不敢去抢海景楼或者餐厅就选择周边房区，搜完之后直接找车转移。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>P城</strong></span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190409/20190409163226_38898.jpg\" alt=\"《绝地求生：刺激战场》新手跳伞不推荐地点介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">P城也是地图中心区域，而且这里也有很多资源。P城虽然没有像Y城那么多房屋，但是在中间区域的资源也是比较密集。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(229,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\"><strong>军事基地</strong></span></p>\n<p style=\"text-align:center;\"></p>\n<img src=\"https://shouyou.3dmgame.com/uploadimg/upload/image/20190409/20190409163234_19723.jpg\" alt=\"《绝地求生：刺激战场》新手跳伞不推荐地点介绍\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 15px;font-family: 微软雅黑, \"Microsoft YaHei\", Arial, \"Heiti SC;\">军事基地资源可以说是海岛地图中最丰富的地方，这里资源点很多，玩家随便占据一块地方都可以获得大量资源。军事基地进去容易，出来难。</span>&nbsp;</p>\n');
INSERT INTO `article` VALUES (8, 'LOL也出狗牌功能了？永恒星碑功能即将上线', '/public/img_1578407114178o9mnm951wam.jpg', 1, 0, '1578407115377', '<p>LOL也出狗牌功能了？永恒星碑功能即将上线</p>\n');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `p_id` int(11) NOT NULL,
  `l_id` int(11) NOT NULL,
  `r_id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` int(11) NOT NULL COMMENT '1：游戏平台\r\n2：游戏类型\r\n3：游戏专区',
  `del` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 0, 1, 20, 'root', 0, 0);
INSERT INTO `category` VALUES (7, 1, 2, 11, '电脑游戏', 1, 0);
INSERT INTO `category` VALUES (10, 7, 3, 4, '动作游戏1', 2, 1);
INSERT INTO `category` VALUES (19, 7, 3, 4, '角色扮演', 2, 0);
INSERT INTO `category` VALUES (20, 7, 5, 6, '第一人称射击', 2, 0);
INSERT INTO `category` VALUES (21, 1, 12, 19, '手机游戏', 1, 0);
INSERT INTO `category` VALUES (22, 7, 7, 8, '策略战棋', 2, 0);
INSERT INTO `category` VALUES (23, 7, 9, 10, '赛车竞速', 2, 0);
INSERT INTO `category` VALUES (24, 21, 13, 14, '体育竞技', 2, 0);
INSERT INTO `category` VALUES (25, 21, 15, 16, '休闲益智', 2, 0);
INSERT INTO `category` VALUES (26, 21, 17, 18, '生存冒险', 2, 0);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `articleId` int(11) NOT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `replyUserId` int(11) NOT NULL DEFAULT 0,
  `read` int(11) NOT NULL DEFAULT 0,
  `del` int(11) NOT NULL DEFAULT 0,
  `create_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_c0354a9a009d3bb45a08655ce3b`(`userId`) USING BTREE,
  INDEX `FK_c20404221e5c125a581a0d90c0e`(`articleId`) USING BTREE,
  CONSTRAINT `FK_c0354a9a009d3bb45a08655ce3b` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_c20404221e5c125a581a0d90c0e` FOREIGN KEY (`articleId`) REFERENCES `article` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for favorites
-- ----------------------------
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `articleId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `create_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_a9e25be94f65c6f11f420d97bca`(`articleId`) USING BTREE,
  INDEX `FK_e747534006c6e3c2f09939da60f`(`userId`) USING BTREE,
  CONSTRAINT `FK_a9e25be94f65c6f11f420d97bca` FOREIGN KEY (`articleId`) REFERENCES `article` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_e747534006c6e3c2f09939da60f` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for follow
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gameId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_82d964eacf90242048c84e5e405`(`gameId`) USING BTREE,
  INDEX `FK_af9f90ce5e8f66f845ebbcc6f15`(`userId`) USING BTREE,
  CONSTRAINT `FK_82d964eacf90242048c84e5e405` FOREIGN KEY (`gameId`) REFERENCES `game` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_af9f90ce5e8f66f845ebbcc6f15` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of follow
-- ----------------------------
INSERT INTO `follow` VALUES (1, 1, 1);
INSERT INTO `follow` VALUES (3, 2, 1);

-- ----------------------------
-- Table structure for game
-- ----------------------------
DROP TABLE IF EXISTS `game`;
CREATE TABLE `game`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `categoryId` int(11) NOT NULL,
  `del` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_3f10804f18297163a6189353e64`(`categoryId`) USING BTREE,
  CONSTRAINT `FK_3f10804f18297163a6189353e64` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of game
-- ----------------------------
INSERT INTO `game` VALUES (1, '英雄联盟', 'ss\'d撒大苏打撒旦', '/public/img_15779345224231xtmf0l0txa.jpeg', 19, 0);
INSERT INTO `game` VALUES (2, '刺激战场', '123', '/public/img_1577935186157qgfvmsreuz.jpeg', 26, 0);
INSERT INTO `game` VALUES (5, '使命召唤', 'rewrewr ', '/public/img_1577934348198m8z9oem013.jpeg', 20, 0);
INSERT INTO `game` VALUES (6, '英雄联盟', 'ss\'d撒大苏打撒旦', '/public/img_1577934364104njml4dvnrli.jpeg', 19, 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录名',
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `del` int(11) NOT NULL DEFAULT 0,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'test', 'test', '2', '1', 0, 'qwe');

SET FOREIGN_KEY_CHECKS = 1;
