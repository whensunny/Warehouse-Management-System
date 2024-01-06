/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : wmh

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 26/12/2023 20:12:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for adminuser
-- ----------------------------
DROP TABLE IF EXISTS `adminuser`;
CREATE TABLE `adminuser`  (
  `uid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phonenum` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of adminuser
-- ----------------------------
INSERT INTO `adminuser` VALUES (3, '23236', '2323', 'guest', '13734997387');
INSERT INTO `adminuser` VALUES (4, '321645', '321645', 'guest', '13963012476');
INSERT INTO `adminuser` VALUES (5, '444555666', '444555666', 'admin', '13955231317');
INSERT INTO `adminuser` VALUES (6, '789', '123', 'admin', '13908930234');
INSERT INTO `adminuser` VALUES (7, '789456', '789456', 'guest', '13903587986');
INSERT INTO `adminuser` VALUES (8, '789456123', '123', 'admin', '13921016308');
INSERT INTO `adminuser` VALUES (9, '987654', '987654', 'admin', '13951067741');
INSERT INTO `adminuser` VALUES (10, 'admin', '123456', 'admin', '13736538097');
INSERT INTO `adminuser` VALUES (11, 'admin1 ', '111222', 'admin', '13949978815');
INSERT INTO `adminuser` VALUES (12, 'admin3', '111222', 'admin', '13791872640');
INSERT INTO `adminuser` VALUES (13, 'bvxcvxc', 'vcx', 'guest', '13715739938');
INSERT INTO `adminuser` VALUES (14, 'fdasfdas', 'fffff', 'guest', '15208571640');
INSERT INTO `adminuser` VALUES (15, 'fdsa', 'fdas', 'admin', '13715911261');
INSERT INTO `adminuser` VALUES (16, 'fdsadf', 'fdsadfa', 'guest', '13767154156');
INSERT INTO `adminuser` VALUES (17, 'fdsavcz', 'fdsa', 'guest', '13795684101');
INSERT INTO `adminuser` VALUES (18, 'ffff', 'ffff', 'guest', '13795445963');
INSERT INTO `adminuser` VALUES (19, 'gfdsgfd', 'fdsa', 'guest', '13950088034');
INSERT INTO `adminuser` VALUES (20, 'haha', 'haha', 'guest', '13770794922');
INSERT INTO `adminuser` VALUES (21, 'hahaha', 'fdsa', 'guest', '15274411397');
INSERT INTO `adminuser` VALUES (22, 'lalala', '123456', NULL, '13913804142');
INSERT INTO `adminuser` VALUES (23, 'pengwen', 'pengwen', 'guest', '13922004121');
INSERT INTO `adminuser` VALUES (24, 'shaoruisi', 'shaoruisi', 'guest', '13993801247');
INSERT INTO `adminuser` VALUES (25, 'wswsw', '123456', 'guest', NULL);
INSERT INTO `adminuser` VALUES (26, 'guest', '123456', 'guest', NULL);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `gid` int NOT NULL AUTO_INCREMENT,
  `gtype` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gname` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `spid` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `introduction` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT NULL,
  PRIMARY KEY (`gid`) USING BTREE,
  INDEX `spno`(`spid` ASC) USING BTREE,
  CONSTRAINT `spno` FOREIGN KEY (`spid`) REFERENCES `suppliers` (`spid`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, '手机', 'iPhone 13', '00001', '全新的iPhone 13，为你带来无限可能', 11100);
INSERT INTO `goods` VALUES (2, '家用电器', '电视机55英寸', '00002', '震撼画质，家庭影院新选择', 11000);
INSERT INTO `goods` VALUES (3, '家具', '皮质沙发', '00003', '舒适时尚的家居装饰，打造温馨空间', 10000);
INSERT INTO `goods` VALUES (4, '手机', '三星Galaxy S21', '00004', '三星Galaxy S21，智能科技新体验', 10001);
INSERT INTO `goods` VALUES (5, '家用电器', '滚筒洗衣机', '00005', '高效洗涤，轻松处理家庭衣物', 10000);
INSERT INTO `goods` VALUES (6, '家具', '实木书桌', '00006', '简约设计，稳固耐用的书写空间', 10000);
INSERT INTO `goods` VALUES (7, '手机', '华为P40', '00007', '华为P40系列，拍摄无界限', 10000);
INSERT INTO `goods` VALUES (8, '家用电器', '冰箱冷柜组合', '00008', '存储食材，保鲜饮品，家庭必备', 10000);
INSERT INTO `goods` VALUES (9, '家具', '折叠餐桌', '00009', '灵活运用空间，方便收纳使用', 10000);
INSERT INTO `goods` VALUES (10, '手机', '小米11', '00010', '小米11，极致性能，无限可能', 10000);
INSERT INTO `goods` VALUES (11, '食品', '进口牛奶', '00001', '高品质进口牛奶，健康之选', 10000);
INSERT INTO `goods` VALUES (12, '服装', '男士西装', '00002', '典雅男士西装，商务必备', 10000);
INSERT INTO `goods` VALUES (13, '鞋帽', '篮球鞋', '00003', '专业篮球鞋，提升运动表现', 10000);
INSERT INTO `goods` VALUES (14, '日用品', '洗发水', '00004', '柔顺清爽，呵护秀发', 10000);
INSERT INTO `goods` VALUES (15, '家具', '双人床', '00005', '舒适睡眠，健康生活的开始', 10000);
INSERT INTO `goods` VALUES (16, '纺织品', '纯棉床单', '00006', '优质纯棉，呵护睡眠质量', 10000);
INSERT INTO `goods` VALUES (17, '五金电料', '螺丝批套装', '00007', '多功能螺丝批套装，维修必备', 10000);
INSERT INTO `goods` VALUES (18, '厨具', '不锈钢锅具套装', '00008', '耐用不锈钢，烹饪利器', 10000);
INSERT INTO `goods` VALUES (19, '手机', 'realme GT', '00009', 'realme GT，潮玩新主张', 10000);
INSERT INTO `goods` VALUES (20, '家用电器', '吸尘器', '00010', '清洁无死角，家居健康守护', 10000);
INSERT INTO `goods` VALUES (21, '食品', '巧克力礼盒', '00001', '精致巧克力礼盒，甜蜜心意', 10000);
INSERT INTO `goods` VALUES (22, '服装', '女士连衣裙', '00002', '优雅女士连衣裙，展现魅力', 10000);
INSERT INTO `goods` VALUES (23, '鞋帽', '运动跑鞋', '00003', '专业运动跑鞋，舒适轻便', 10000);
INSERT INTO `goods` VALUES (24, '日用品', '洗洁精', '00004', '高效清洁，保护家庭卫生', 10000);
INSERT INTO `goods` VALUES (25, '家具', '书架', '00005', '整洁有序，展示您的精彩', 10000);
INSERT INTO `goods` VALUES (26, '纺织品', '毛巾套装', '00006', '柔软吸水，享受沐浴时光', 10000);
INSERT INTO `goods` VALUES (27, '五金电料', '螺丝钉组合', '00007', '多功能螺丝钉组合，家居维修利器', 10000);
INSERT INTO `goods` VALUES (28, '厨具', '刀具套装', '00008', '锋利刀具，烹饪利器', 10000);
INSERT INTO `goods` VALUES (29, '手机', '华为Mate 40', '00009', '华为Mate 40系列，超感知影像', 10000);
INSERT INTO `goods` VALUES (30, '家用电器', '电风扇', '00010', '清凉降温，享受舒适风', 10000);
INSERT INTO `goods` VALUES (31, '家具', '懒人沙发', '00002', '舒适休憩，尽享慵懒时光', 10000);
INSERT INTO `goods` VALUES (32, '纺织品', '丝绸床品套装', '00003', '柔软丝绸，奢华享受', 10000);
INSERT INTO `goods` VALUES (33, '五金电料', '螺丝刀套装', '00004', '多功能螺丝刀套装，家居维修利器', 10000);
INSERT INTO `goods` VALUES (34, '家具', '儿童书桌', '00005', '陪伴成长，书写童年', 10000);
INSERT INTO `goods` VALUES (35, '手机', '华为P50', '00006', '华为P50系列，拍摄无界限', 10000);
INSERT INTO `goods` VALUES (36, '家用电器', '冷热风空调', '00007', '一机双享，舒适全年', 10000);
INSERT INTO `goods` VALUES (37, '家具', '吊篮椅', '00008', '惬意摇摆，享受悠闲时光', 10000);
INSERT INTO `goods` VALUES (38, '纺织品', '羽绒被', '00009', '柔软暖和，温暖美好的梦境', 10000);
INSERT INTO `goods` VALUES (39, '五金电料', '充电手电筒', '00010', '便携充电，照亮黑暗', 10000);
INSERT INTO `goods` VALUES (40, '家具', '多功能收纳柜', '00002', '整洁有序，便捷收纳', 10000);
INSERT INTO `goods` VALUES (41, '手机', 'OPPO Find X3', '00003', 'OPPO Find X3系列，影像探索', 10000);
INSERT INTO `goods` VALUES (42, '家用电器', '多功能烤箱', '00004', '多功能烹饪，美味轻松上桌', 10000);
INSERT INTO `goods` VALUES (43, '家具', '简约吧台', '00005', '简约设计，时尚生活', 10000);
INSERT INTO `goods` VALUES (44, '纺织品', '舒适睡袍', '00006', '舒适休息，尽情放松', 10000);
INSERT INTO `goods` VALUES (45, '五金电料', '手动工具组合', '00007', '基础工具，修复方便', 10000);
INSERT INTO `goods` VALUES (46, '家具', '休闲椅', '00008', '休闲时光，享受安逸', 10000);
INSERT INTO `goods` VALUES (47, '手机', 'Vivo X60', '00009', 'Vivo X60系列，拍出美好', 10000);
INSERT INTO `goods` VALUES (48, '家用电器', '挂烫机', '00010', '衣物焕新，轻松熨烫', 10000);
INSERT INTO `goods` VALUES (49, '家具', '玻璃茶几', '00002', '简约时尚，精致设计', 10000);
INSERT INTO `goods` VALUES (50, '纺织品', '情侣睡袍套装', '00003', '暖暖相伴，温馨双人', 10000);
INSERT INTO `goods` VALUES (51, '家具', '多功能储物床', '00004', '空间利用更大，收纳更便捷', 10000);
INSERT INTO `goods` VALUES (52, '手机', 'Xiaomi 12', '00005', 'Xiaomi 12系列，创新科技', 10000);
INSERT INTO `goods` VALUES (53, '家用电器', '智能洗衣机', '00006', '智能洗涤，轻松洁净', 10000);
INSERT INTO `goods` VALUES (54, '家具', '餐边柜', '00007', '装饰家居，美观实用', 10000);
INSERT INTO `goods` VALUES (55, '纺织品', '法式蕾丝窗帘', '00008', '优雅浪漫，营造温馨空间', 10000);
INSERT INTO `goods` VALUES (56, '五金电料', '全能电钻组合', '00009', '多功能钻孔，施工利器', 10000);
INSERT INTO `goods` VALUES (57, '家具', '升降办公桌', '00010', '健康办公，自由升降', 10000);
INSERT INTO `goods` VALUES (58, '手机', 'Samsung Galaxy S22', '00002', 'Galaxy S22系列，卓越表现', 10010);
INSERT INTO `goods` VALUES (59, '家用电器', '智能扫地机器人', '00003', '智能清扫，守护家园', 10000);
INSERT INTO `goods` VALUES (60, '家具', '复古吊灯', '00004', '怀旧设计，独特光影', 10000);
INSERT INTO `goods` VALUES (61, '纺织品', '优质毛巾套装', '00005', '柔软亲肤，呵护身体', 10000);
INSERT INTO `goods` VALUES (62, '五金电料', '高压电喷枪', '00006', '家居喷涂，轻松完成', 10000);
INSERT INTO `goods` VALUES (63, '家具', '旋转餐桌', '00007', '灵活空间，多角度使用', 10000);
INSERT INTO `goods` VALUES (64, '手机', 'OnePlus 10', '00008', 'OnePlus 10系列，流畅体验', 10000);
INSERT INTO `goods` VALUES (65, '家用电器', '智能电饭煲', '00009', '智能烹饪，一键操作', 10000);
INSERT INTO `goods` VALUES (66, '家具', '皮质沙发', '00010', '奢华品质，尊贵享受', 10000);
INSERT INTO `goods` VALUES (67, '纺织品', '夏日凉席套装', '00002', '清凉舒爽，夏日必备', 10000);
INSERT INTO `goods` VALUES (68, '五金电料', '多功能电动工具组合', '00003', '家居维修神器，多用途工具', 10000);
INSERT INTO `goods` VALUES (69, '家具', '多层储物架', '00004', '空间整理，收纳利器', 10000);
INSERT INTO `goods` VALUES (70, '手机', 'Google Pixel 7', '00005', 'Google Pixel 7系列，智慧拍摄', 10000);
INSERT INTO `goods` VALUES (71, '家用电器', '冰箱消毒杀菌器', '00006', '健康保障，食品安全', 10000);
INSERT INTO `goods` VALUES (72, '家具', '酒柜', '00007', '收纳整理，美酒收藏', 10010);
INSERT INTO `goods` VALUES (73, '纺织品', '儿童床品套装', '00008', '儿童专属，呵护成长', 10000);
INSERT INTO `goods` VALUES (74, '五金电料', '智能家居套装', '00009', '智能生活，便捷控制', 10000);
INSERT INTO `goods` VALUES (75, '家具', '摇椅', '00010', '轻松摇晃，释放压力', 10000);
INSERT INTO `goods` VALUES (76, '手机', 'Sony Xperia 5', '00002', 'Sony Xperia 5系列，影音精彩', 10000);
INSERT INTO `goods` VALUES (77, '家用电器', '果蔬清洗机', '00003', '健康饮食，清洗更便捷', 10000);
INSERT INTO `goods` VALUES (78, '家具', '实木衣柜', '00004', '质感舒适，耐用经久', 10000);
INSERT INTO `goods` VALUES (79, '纺织品', '多功能抱枕', '00005', '舒适支撑，多用途', 10000);
INSERT INTO `goods` VALUES (80, '五金电料', '智能插座', '00006', '远程控制，智能生活', 10000);
INSERT INTO `goods` VALUES (84, '书本', '语文书', '00001', NULL, 10000);
INSERT INTO `goods` VALUES (86, '玩具', '纸飞机', '00003', NULL, 10000);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `spid` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gtype` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gname` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `order_number` int NULL DEFAULT NULL,
  `order_price` decimal(10, 2) NULL DEFAULT NULL,
  `is_instock` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '是',
  `order_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (2, '00003', '纺织品', '丝绸床品套装', 1, 299.60, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (3, '00004', '五金电料', '螺丝刀套装', 3, 49.99, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (4, '00005', '家具', '儿童书桌', 1, 149.99, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (5, '00006', '手机', '华为P50', 2, 899.00, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (6, '00007', '家用电器', '冷热风空调', 1, 799.99, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (7, '00008', '家具', '吊篮椅', 2, 199.99, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (8, '00009', '纺织品', '羽绒被', 1, 129.99, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (9, '00010', '五金电料', '充电手电筒', 5, 19.99, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (10, '00002', '家具', '多功能收纳柜', 1, 179.99, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (11, '00003', '手机', 'OPPO Find X3', 2, 749.00, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (12, '00004', '家用电器', '多功能烤箱', 1, 299.50, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (13, '00005', '家具', '简约吧台', 3, 239.99, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (14, '00006', '纺织品', '舒适睡袍', 1, 89.99, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (15, '00007', '五金电料', '手动工具组合', 2, 29.99, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (16, '00008', '家具', '休闲椅', 4, 149.99, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (17, '00009', '手机', 'Vivo X60', 3, 699.00, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (18, '00010', '家用电器', '挂烫机', 1, 49.99, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (19, '00002', '家具', '玻璃茶几', 2, 119.99, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (20, '00003', '纺织品', '情侣睡袍套装', 1, 159.50, '是', '2023-12-07 21:42:21');
INSERT INTO `orders` VALUES (21, '00002', '服装', '女士连衣裙', 1, 99.00, '是', '2023-12-07 21:43:37');
INSERT INTO `orders` VALUES (22, '00002', '书本', '物理书', 1, 39.00, '是', '2023-12-07 22:02:45');
INSERT INTO `orders` VALUES (23, '00001', '书本', '语文书', 10000, 39.00, '是', '2023-12-07 22:23:20');
INSERT INTO `orders` VALUES (24, '00003', '玩具', '纸飞机', 10000, 11.00, '是', '2023-12-26 18:25:08');

-- ----------------------------
-- Table structure for quantity_changes
-- ----------------------------
DROP TABLE IF EXISTS `quantity_changes`;
CREATE TABLE `quantity_changes`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `gid` int NULL DEFAULT NULL,
  `change_amount` int NULL DEFAULT NULL,
  `change_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `gname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `gid`(`gid` ASC) USING BTREE,
  CONSTRAINT `quantity_changes_ibfk_1` FOREIGN KEY (`gid`) REFERENCES `goods` (`gid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of quantity_changes
-- ----------------------------
INSERT INTO `quantity_changes` VALUES (1, 72, 10, '2023-12-07 20:21:10', '酒柜');
INSERT INTO `quantity_changes` VALUES (2, 1, 1100, '2023-12-26 18:21:12', 'iPhone 13');
INSERT INTO `quantity_changes` VALUES (3, 2, 1000, '2023-12-26 18:21:23', '电视机55英寸');
INSERT INTO `quantity_changes` VALUES (4, 1, 1, '2023-12-26 18:51:11', 'iPhone 13');
INSERT INTO `quantity_changes` VALUES (5, 58, 10, '2023-12-26 18:52:36', 'Samsung Galaxy S22');
INSERT INTO `quantity_changes` VALUES (6, 4, 1, '2023-12-26 19:05:25', '三星Galaxy S21');
INSERT INTO `quantity_changes` VALUES (7, 1, -1, '2023-12-26 19:22:35', 'iPhone 13');

-- ----------------------------
-- Table structure for sp_permission
-- ----------------------------
DROP TABLE IF EXISTS `sp_permission`;
CREATE TABLE `sp_permission`  (
  `ps_id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ps_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限名称',
  `ps_pid` smallint UNSIGNED NOT NULL COMMENT '父id',
  `ps_c` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '控制器',
  `ps_a` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作方法',
  `ps_level` enum('0','2','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '权限等级',
  PRIMARY KEY (`ps_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 159 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sp_permission
-- ----------------------------
INSERT INTO `sp_permission` VALUES (101, '货物管理', 0, 'Goods', 'goodsmn', '0');
INSERT INTO `sp_permission` VALUES (102, '订单管理', 0, 'Order', 'ordermn', '0');
INSERT INTO `sp_permission` VALUES (103, '用户管理', 0, 'Manage', 'usermn', '0');
INSERT INTO `sp_permission` VALUES (104, '货物查询', 101, 'Goods', 'goods', '1');
INSERT INTO `sp_permission` VALUES (105, '添加商品', 104, 'Goods', 'addGood', '2');
INSERT INTO `sp_permission` VALUES (106, '订单列表', 102, 'Order', 'orders', '1');
INSERT INTO `sp_permission` VALUES (107, '删除订单', 0, 'Order', 'delteorder', '1');
INSERT INTO `sp_permission` VALUES (108, '编辑订单', 0, 'Order', 'editorder', '1');
INSERT INTO `sp_permission` VALUES (109, '添加订单', 106, 'Order', 'addorder', '2');
INSERT INTO `sp_permission` VALUES (110, '用户列表', 103, 'Manager', 'users', '1');
INSERT INTO `sp_permission` VALUES (116, '货物修改', 104, 'Goods', 'goodsalt', '2');
INSERT INTO `sp_permission` VALUES (117, '货物删除', 104, 'Goods', 'deletegoods', '2');
INSERT INTO `sp_permission` VALUES (121, '货物分类', 0, 'Goods', 'goodscls', '1');
INSERT INTO `sp_permission` VALUES (125, '权限管理', 0, 'Right', 'rights', '2');

-- ----------------------------
-- Table structure for sp_permission_api
-- ----------------------------
DROP TABLE IF EXISTS `sp_permission_api`;
CREATE TABLE `sp_permission_api`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `ps_id` int NOT NULL,
  `ps_api_service` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ps_api_action` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ps_api_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ps_api_order` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ps_id`(`ps_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sp_permission_api
-- ----------------------------
INSERT INTO `sp_permission_api` VALUES (1, 101, NULL, NULL, 'goods', 3);
INSERT INTO `sp_permission_api` VALUES (2, 102, NULL, NULL, 'orders', 4);
INSERT INTO `sp_permission_api` VALUES (3, 103, NULL, NULL, 'rights', 2);
INSERT INTO `sp_permission_api` VALUES (4, 104, 'GoodService', 'getAllGoods', 'goods', 1);
INSERT INTO `sp_permission_api` VALUES (5, 105, 'GoodService', 'createGood', 'goods', NULL);
INSERT INTO `sp_permission_api` VALUES (6, 107, 'OrderService', 'getAllOrders', 'orders', NULL);
INSERT INTO `sp_permission_api` VALUES (9, 109, 'OrderService', 'createOrder', 'orders', NULL);
INSERT INTO `sp_permission_api` VALUES (10, 110, 'ManagerService', 'getAllManagers', 'users', NULL);
INSERT INTO `sp_permission_api` VALUES (11, 111, 'RoleService', 'getAllRoles', 'roles', NULL);
INSERT INTO `sp_permission_api` VALUES (12, 112, 'RightService', 'getAllRights', 'rights', NULL);
INSERT INTO `sp_permission_api` VALUES (15, 115, 'CategoryService', 'getAttributes', 'params', 2);
INSERT INTO `sp_permission_api` VALUES (16, 116, 'GoodService', 'updateGood', 'goods', NULL);
INSERT INTO `sp_permission_api` VALUES (17, 117, 'GoodService', 'deleteGood', 'goods', NULL);
INSERT INTO `sp_permission_api` VALUES (21, 121, 'CategoryService', 'getAllCategories', 'categories', 3);
INSERT INTO `sp_permission_api` VALUES (22, 122, 'CategoryService', 'addCategory', 'categories', NULL);
INSERT INTO `sp_permission_api` VALUES (23, 123, 'CategoryService', 'deleteCategory', 'categories', NULL);
INSERT INTO `sp_permission_api` VALUES (25, 125, NULL, NULL, 'users', 1);
INSERT INTO `sp_permission_api` VALUES (29, 129, 'RoleService', 'createRole', 'roles', NULL);
INSERT INTO `sp_permission_api` VALUES (30, 130, 'RoleService', 'deleteRole', 'roles', NULL);
INSERT INTO `sp_permission_api` VALUES (31, 131, 'ManagerService', 'createManager', 'users', NULL);
INSERT INTO `sp_permission_api` VALUES (32, 132, 'ManagerService', 'deleteManager', 'users', NULL);
INSERT INTO `sp_permission_api` VALUES (33, 133, 'ManagerService', 'updateManager', 'users', NULL);
INSERT INTO `sp_permission_api` VALUES (34, 134, 'RoleService', 'updateRoleRight', 'roles', NULL);
INSERT INTO `sp_permission_api` VALUES (35, 135, 'RoleService', 'deleteRoleRight', 'roles', NULL);
INSERT INTO `sp_permission_api` VALUES (36, 136, 'ManagerService', 'getManager', 'users', NULL);
INSERT INTO `sp_permission_api` VALUES (37, 137, 'ManagerService', 'setRole', 'users', NULL);
INSERT INTO `sp_permission_api` VALUES (38, 138, 'RoleService', 'getAllRoles', 'roles', NULL);
INSERT INTO `sp_permission_api` VALUES (39, 139, 'RoleService', 'getRoleById', 'roles', NULL);
INSERT INTO `sp_permission_api` VALUES (40, 140, 'RoleService', 'updateRole', 'roles', NULL);
INSERT INTO `sp_permission_api` VALUES (41, 141, 'RoleService', 'updateRoleRight', 'roles', NULL);
INSERT INTO `sp_permission_api` VALUES (42, 142, 'AttributeService', 'getAttributes', 'categories', NULL);
INSERT INTO `sp_permission_api` VALUES (43, 143, 'AttributeService', 'createAttribute', 'categories', NULL);
INSERT INTO `sp_permission_api` VALUES (44, 144, 'AttributeService', 'deleteAttribute', 'categories', NULL);
INSERT INTO `sp_permission_api` VALUES (45, 145, NULL, NULL, 'reports', 5);
INSERT INTO `sp_permission_api` VALUES (46, 146, NULL, NULL, 'reports', NULL);
INSERT INTO `sp_permission_api` VALUES (47, 147, 'RightService', 'getAllRights', 'rights', NULL);
INSERT INTO `sp_permission_api` VALUES (48, 148, NULL, NULL, 'reports', NULL);
INSERT INTO `sp_permission_api` VALUES (49, 149, 'CategoryService', 'getCategoryById', 'categories', NULL);
INSERT INTO `sp_permission_api` VALUES (50, 150, 'GoodService', 'updateGoodPics', 'goods', NULL);
INSERT INTO `sp_permission_api` VALUES (51, 151, 'GoodService', 'updateGoodAttributes', 'goods', NULL);
INSERT INTO `sp_permission_api` VALUES (52, 152, 'GoodService', 'updateGoodsState', 'goods', NULL);
INSERT INTO `sp_permission_api` VALUES (53, 153, 'GoodService', 'getGoodById', 'goods', NULL);
INSERT INTO `sp_permission_api` VALUES (54, 154, 'OrderService', 'updateOrder', 'orders', NULL);
INSERT INTO `sp_permission_api` VALUES (55, 155, 'OrderService', 'getOrder', 'orders', NULL);
INSERT INTO `sp_permission_api` VALUES (56, 156, 'CategoryService', 'createAttribute', 'categories', NULL);
INSERT INTO `sp_permission_api` VALUES (57, 157, 'CategoryService', 'deleteAttribute', 'categories', NULL);
INSERT INTO `sp_permission_api` VALUES (58, 158, 'CategoryService', 'attributeById', 'categories', NULL);
INSERT INTO `sp_permission_api` VALUES (59, 159, 'ManagerService', 'updateMgrState', 'users', NULL);

-- ----------------------------
-- Table structure for suppliers
-- ----------------------------
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers`  (
  `spid` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `spname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `spaddress` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phonenum` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`spid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of suppliers
-- ----------------------------
INSERT INTO `suppliers` VALUES ('00001', '阿里', '北京', '18062795547');
INSERT INTO `suppliers` VALUES ('00002', '百度', '北京', '13751256211');
INSERT INTO `suppliers` VALUES ('00003', '腾讯', '深圳', '18065324125');
INSERT INTO `suppliers` VALUES ('00004', '淘宝', '武汉', '12345678902');
INSERT INTO `suppliers` VALUES ('00005', '立得', '武汉', '12345678903');
INSERT INTO `suppliers` VALUES ('00006', '谷歌', '纽约', '74185296301');
INSERT INTO `suppliers` VALUES ('00007', '外婆桥', '湖北', '18062354785');
INSERT INTO `suppliers` VALUES ('00008', '地信', '长达', '18062124123');
INSERT INTO `suppliers` VALUES ('00009', '美团', '天津', '13835421265');
INSERT INTO `suppliers` VALUES ('00010', '华为', '深圳', '13823441311');

-- ----------------------------
-- Triggers structure for table goods
-- ----------------------------
DROP TRIGGER IF EXISTS `track_quantity_changes`;
delimiter ;;
CREATE TRIGGER `track_quantity_changes` AFTER UPDATE ON `goods` FOR EACH ROW BEGIN
    DECLARE change_amount INT;
    DECLARE gname_val VARCHAR(255);

    SET change_amount = NEW.quantity - OLD.quantity;

    IF change_amount != 0 THEN
        SELECT gname INTO gname_val FROM goods WHERE gid = NEW.gid;

        INSERT INTO quantity_changes (gid, gname, change_amount) VALUES (NEW.gid, gname_val, change_amount);
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table orders
-- ----------------------------
DROP TRIGGER IF EXISTS `update_order_trigger`;
delimiter ;;
CREATE TRIGGER `update_order_trigger` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
    -- 定义变量存储 gname 是否存在的数量
    DECLARE g_count INT;

    -- 获取 gname 存在的数量
    SELECT COUNT(*) INTO g_count FROM goods WHERE gname = NEW.gname;

    -- 检查是否更新 is_instock 为 '是'，并且 gname 不存在于 goods 表中
    IF NEW.is_instock = '是' AND g_count = 0 THEN
        -- 插入新记录到 goods 表中
        INSERT INTO goods (gname, quantity, gtype, spid)
        VALUES (NEW.gname, NEW.order_number, NEW.gtype, NEW.spid);
    END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
