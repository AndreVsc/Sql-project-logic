CREATE SCHEMA IF NOT EXISTS `ecommerce_db` DEFAULT CHARACTER SET utf8;
USE `ecommerce_db`;

CREATE TABLE IF NOT EXISTS `clients` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NULL,
  `last_name` VARCHAR(20) NULL,
  `client_type` ENUM('PF', 'PJ') NOT NULL,
  `cpf` VARCHAR(11) NULL,
  `cnpj` VARCHAR(14) NULL,
  `address` VARCHAR(255) NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE (`cpf`),
  UNIQUE (`cnpj`),
  CONSTRAINT `chk_client_type` CHECK (
    (`client_type` = 'PF' AND `cpf` IS NOT NULL AND `cnpj` IS NULL) OR
    (`client_type` = 'PJ' AND `cnpj` IS NOT NULL AND `cpf` IS NULL)
  )
);

CREATE TABLE IF NOT EXISTS `products` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(50) NOT NULL,
  `price` FLOAT NOT NULL DEFAULT 0,
  `category` ENUM('Eletrônico', 'Vestuário', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
  `description` VARCHAR(255) NULL,
  `rating` FLOAT NULL DEFAULT 0,
  `size` VARCHAR(10) NULL,
  `for_kids` BOOLEAN NULL DEFAULT FALSE,
  PRIMARY KEY (`id_product`)
);

CREATE TABLE IF NOT EXISTS `orders` (
  `id_order` INT NOT NULL AUTO_INCREMENT,
  `id_client` INT NOT NULL,
  `order_status` ENUM('Cancelado', 'Confirmado', 'Em processamento') NULL DEFAULT 'Em processamento',
  `order_description` VARCHAR(255) NULL,
  `shipping_cost` FLOAT NULL DEFAULT 0,
  `order_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery_status` ENUM('Aguardando Envio', 'Enviado', 'Em Trânsito', 'Entregue') NOT NULL DEFAULT 'Aguardando Envio',
  `tracking_code` VARCHAR(50) NULL,
  PRIMARY KEY (`id_order`),
  FOREIGN KEY (`id_client`) REFERENCES `clients`(`id_client`)
);

CREATE TABLE IF NOT EXISTS `payments` (
  `id_payment` INT NOT NULL AUTO_INCREMENT,
  `id_order` INT NOT NULL,
  `payment_type` ENUM('Dois cartões', 'Cartão', 'Boleto', 'PIX') NOT NULL,
  `limit_available` FLOAT NULL,
  PRIMARY KEY (`id_payment`),
  FOREIGN KEY (`id_order`) REFERENCES `orders`(`id_order`)
);

CREATE TABLE IF NOT EXISTS `suppliers` (
  `id_supplier` INT NOT NULL AUTO_INCREMENT,
  `social_name` VARCHAR(45) NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  `contact` CHAR(11) NULL,
  PRIMARY KEY (`id_supplier`),
  UNIQUE (`cnpj`)
);

CREATE TABLE IF NOT EXISTS `storages` (
  `id_storage` INT NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(255) NULL,
  PRIMARY KEY (`id_storage`)
);

CREATE TABLE IF NOT EXISTS `sellers` (
  `id_seller` INT NOT NULL AUTO_INCREMENT,
  `social_name` VARCHAR(255) NOT NULL,
  `fantasy_name` VARCHAR(255) NULL,
  `cnpj` VARCHAR(14) NULL,
  `cpf` VARCHAR(11) NULL,
  `location` VARCHAR(255) NULL,
  PRIMARY KEY (`id_seller`),
  UNIQUE (`cnpj`),
  UNIQUE (`cpf`)
);

CREATE TABLE IF NOT EXISTS `order_items` (
  `id_order` INT NOT NULL,
  `id_product` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 1,
  `price` FLOAT NULL,
  PRIMARY KEY (`id_order`, `id_product`),
  FOREIGN KEY (`id_order`) REFERENCES `orders`(`id_order`),
  FOREIGN KEY (`id_product`) REFERENCES `products`(`id_product`)
);

CREATE TABLE IF NOT EXISTS `product_in_storage` (
  `id_product` INT NOT NULL,
  `id_storage` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_product`, `id_storage`),
  FOREIGN KEY (`id_product`) REFERENCES `products`(`id_product`),
  FOREIGN KEY (`id_storage`) REFERENCES `storages`(`id_storage`)
);

CREATE TABLE IF NOT EXISTS `product_suppliers` (
  `id_supplier` INT NOT NULL,
  `id_product` INT NOT NULL,
  PRIMARY KEY (`id_supplier`, `id_product`),
  FOREIGN KEY (`id_supplier`) REFERENCES `suppliers`(`id_supplier`),
  FOREIGN KEY (`id_product`) REFERENCES `products`(`id_product`)
);

CREATE TABLE IF NOT EXISTS `product_sellers` (
  `id_seller` INT NOT NULL,
  `id_product` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_seller`, `id_product`),
  FOREIGN KEY (`id_seller`) REFERENCES `sellers`(`id_seller`),
  FOREIGN KEY (`id_product`) REFERENCES `products`(`id_product`)
);