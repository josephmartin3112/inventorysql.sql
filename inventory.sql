CREATE DATABASE IF NOT EXISTS `inventory_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventory_db`;

-- Drop tables if they exist
DROP TABLE IF EXISTS `inventory_item`;
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `supplier`;
DROP TABLE IF EXISTS `inventory_transaction`;

-- Table 1: Supplier
CREATE TABLE `supplier` (
  `supplier_id` INT AUTO_INCREMENT NOT NULL,
  `supplier_name` VARCHAR(100) NOT NULL,
  `contact_person` VARCHAR(100) DEFAULT NULL,
  `email` VARCHAR(255) DEFAULT NULL,
  `phone` VARCHAR(20) DEFAULT NULL,
  `address` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
);

-- Table 2: Category
CREATE TABLE `category` (
  `category_id` INT AUTO_INCREMENT NOT NULL,
  `category_name` VARCHAR(100) NOT NULL,
  `description` TEXT DEFAULT NULL,
  PRIMARY KEY (`category_id`)
);

-- Table 3: Inventory Item
CREATE TABLE `inventory_item` (
  `item_id` INT AUTO_INCREMENT NOT NULL,
  `item_name` VARCHAR(100) NOT NULL,
  `description` TEXT DEFAULT NULL,
  `sku` VARCHAR(50) UNIQUE NOT NULL,
  `price` DECIMAL(10, 2) NOT NULL,
  `quantity` INT NOT NULL DEFAULT 0,
  `category_id` INT DEFAULT NULL,
  `supplier_id` INT DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`item_id`),
  FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE SET NULL,
  FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`) ON DELETE SET NULL
);

-- Table 4: Inventory Transaction
CREATE TABLE `inventory_transaction` (
  `transaction_id` INT AUTO_INCREMENT NOT NULL,
  `item_id` INT NOT NULL,
  `quantity_change` INT NOT NULL,
  `transaction_type` ENUM('purchase', 'sale', 'adjustment', 'return') NOT NULL,
  `transaction_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `notes` TEXT DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  FOREIGN KEY (`item_id`) REFERENCES `inventory_item` (`item_id`) ON DELETE CASCADE
);